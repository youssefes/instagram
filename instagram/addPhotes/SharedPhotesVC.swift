//
//  SharedPhotesVC.swift
//  instagram
//
//  Created by youssef on 7/5/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
class SharedPhotoVC: UIViewController {
    
    var SelectedImage : UIImage? {
        didSet{
            self.ImageView.image = SelectedImage
        }
    }
    let ImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let textView : UITextView = {
        let text = UITextView()
        text.font = UIFont.boldSystemFont(ofSize: 14) 
        return text
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shared", style: .plain, target: self, action: #selector(handelShared))
        SetUpImageSharedWithText()
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func SetUpImageSharedWithText(){
        
        let containerView : UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        view.addSubview(containerView)
        
        containerView.anchor(top: topLayoutGuide.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 100)
        containerView.addSubview(ImageView)
        ImageView.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, right: nil, padingTop: 8, padingBotton: 8, padingLeft: 8, padingRight: 0, width: 84, height: 0)
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: ImageView.rightAnchor, right: containerView.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 4, padingRight: 0, width: 0, height: 0)
    }
    
    @objc func handelShared(){
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        if let userId = Auth.auth().currentUser?.uid{
            let StorageRef = Storage.storage().reference()
            if let Image = ImageView.image {
                guard  let data = Image.jpegData(compressionQuality: 0.5) else {
                    return
                }
                StorageRef.child("sharedUserImage").child(userId).putData(data, metadata: nil) { (mataData, error) in
                    if let err = error{
                        print("faild to upload Image \(err)")
                        return
                    }
                    
                    let ref = StorageRef.child("sharedUserImage").child(userId)
                    ref.downloadURL { (url, error) in
                        if let err = error{
                            
                            print("faild to get Image Url \(err)")
                            return
                        }
                        guard let ImageUrl = url?.absoluteString else {
                            return
                        }
                        
                        self.saveToDatabaseWithImageUrl(imageUrl: ImageUrl)
                    }
                }
            }
        }
        
       
    }
    
    
    func saveToDatabaseWithImageUrl(imageUrl : String){
        
        guard let postImage = SelectedImage else {
            return
        }
        guard let caption = textView.text, !caption.isEmpty else{
            return
        }
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let referance = Database.database().reference().child("Posts").child(userId)
        
        
        let ref = referance.childByAutoId()
        
        let value = ["imageUrl" : imageUrl, "caption" : caption, "imageHeight" : postImage.size.height, "imageWidth" : postImage.size.width , "creationDate" : Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(value) { (error, dataRef) in
            if let err = error{
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                print("faild to save data to database \(err)")
                return
            }
            
            print("successfull save")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
