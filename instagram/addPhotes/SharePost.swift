//
//  SharePost.swift
//  LoftPop
//
//  Created by youssef on 1/26/21.
//  Copyright © 2021 youssef. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import UITextView_Placeholder


class SharePost: UIViewController, PhotosSeccessUpload{
    

    let ImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isHidden = true
        return image
    }()
    
    let textView : UITextView = {
        let text = UITextView()
        text.placeholder = "Write your post"
        text.font = UIFont.boldSystemFont(ofSize: 14)
        return text
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shared", style: .plain, target: self, action: #selector(saveTopostToDatabase))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add Photo", style: .plain, target: self, action: #selector(ChosePhotoTopostToDatabase))
        SetUpTextPost()
    }
    
    
    func seccessFetchPotos(image: UIImage) {
        ImageView.isHidden = false
        ImageView.image = image
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func SetUpTextPost(){
        
        let satckView : UIStackView = {
            let view = UIStackView(arrangedSubviews: [ImageView,textView])
            view.backgroundColor = .white
            view.axis = .vertical
            view.distribution = .fillEqually
            return view
        }()
        
        view.addSubview(satckView)
        satckView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0)
        textView.anchor(top: nil, bottom: nil, left: nil, right: nil, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 300)
    }
    
    @objc func ChosePhotoTopostToDatabase(){
        let layout = UICollectionViewFlowLayout()
        let photoSelector = PhotoSelectorVc(collectionViewLayout: layout, deleget: self)
        let navgationController = UINavigationController(rootViewController: photoSelector)
        photoSelector.post = textView.text
        present(navgationController, animated: true, completion: nil)
    }
    
    
    @objc func saveTopostToDatabase(){
        if ImageView.image != nil{
             handelShared()
        }else{
           savePostOnly()
        }
        
        
    }
    
    func savePostOnly()  {
        guard let caption = textView.text, !caption.isEmpty else{
            return
        }
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let referance = Database.database().reference().child("Posts").child(userId)
        
        
        let ref = referance.childByAutoId()
        
        let value = ["caption" : caption, "creationDate" : Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(value) { (error, dataRef) in
            if let err = error{
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                print("faild to save data to database \(err)")
                return
            }
            self.dismiss(animated: true, completion: nil)
            print("seccess add post")
        }
    }
}

extension SharePost {
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
                        print("seccess add post")
                    }
                }
            }
        }
        
    }
    
    func saveToDatabaseWithImageUrl(imageUrl : String){
        
        guard let postImage = ImageView.image else {
            return
        }
        guard let post = textView.text else{
            return
        }
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let referance = Database.database().reference().child("Posts").child(userId)
        
        
        let ref = referance.childByAutoId()
        
        let value = ["imageUrl" : imageUrl, "caption" : post, "imageHeight" : postImage.size.height, "imageWidth" : postImage.size.width , "creationDate" : Date().timeIntervalSince1970] as [String : Any]
        
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
