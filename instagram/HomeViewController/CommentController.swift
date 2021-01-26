//
//  CommentController.swift
//  instagram
//
//  Created by youssef on 1/25/21.
//  Copyright © 2021 youssef. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class CommentController:  UICollectionViewController{
    
    
    var post : Posts?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem?.title = "ff"
        title = "COMMENTS"
        collectionView.backgroundColor = .black
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: "CommentCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        collectionView.keyboardDismissMode = .interactive
        fetchComments()
    }

    var comments  = [Comment]()
    func fetchComments() {
        guard let postId = post?.id else{return}
        Database.database().reference().child("Comments").child(postId).observe(.childAdded, with: { (snapchat) in
            guard let comments = snapchat.value as? [String : Any] else {return}
            guard let UId = comments["Uid"] as? String else {return}
            
            Database.fetchUserWithUid(Uid: UId) { (user) in
                var comment = Comment(dictionary: comments)
                comment.user = user
                self.comments.append(comment)
                self.collectionView.reloadData()
            }
            
        }) { (errer) in
            print("error to fetch commets")
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.row]
        return cell
    }

    @objc func dismissBtn (){
        
        navigationController?.popViewController(animated: true)
    }
    
    
    lazy var containerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .black
        containerView.frame = CGRect(x: 20, y: 0, width: 100, height: 100)
        let submitBtn = UIButton()
        submitBtn.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        submitBtn.setTitleColor(.white, for: .normal)
        submitBtn.titleLabel?.font = UIFont(name: Font.Medium.name, size: 16)
        submitBtn.addTarget(self, action: #selector(handleSubmitCommet), for: .touchUpInside)
        containerView.addSubview(submitBtn)
        
        submitBtn.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: nil, right: containerView.rightAnchor, padingTop: 20, padingBotton: 40, padingLeft: 0, padingRight: -20, width: 40, height: 40)
        
        containerView.addSubview(CommenttextField)
        CommenttextField.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, right: submitBtn.leftAnchor, padingTop: 20, padingBotton: 40, padingLeft: 12, padingRight: -12 , width: 0, height: 0)
        
        let seporatedView = UIView()
        seporatedView.backgroundColor = UIColor.white
        containerView.addSubview(seporatedView)
        seporatedView.anchor(top: containerView.topAnchor, bottom: nil, left: containerView.leftAnchor, right: containerView.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0.5)
        return containerView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
      
    }
    
    override var inputAccessoryView: UIView?{
        get{
            return containerView
            
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    
    let CommenttextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string:"Write a Comment...", attributes:[NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 87, green: 87, blue: 90) , NSAttributedString.Key.font : UIFont(name: "Gilroy-Medium", size: 20)!])
        textField.textColor = .white
        return textField
    }()
   
    
    
    @objc func handleSubmitCommet(){
        guard let user = Auth.auth().currentUser?.uid else {
            return
        }
        guard let textF = CommenttextField.text, !textF.isEmpty else {return}
        
        let postId = post?.id ?? " "
        let value : [String : Any] = ["text" : textF , "creationDate" : Date().timeIntervalSince1970, "Uid" : user]
        Database.database().reference().child("Comments").child(postId).childByAutoId().updateChildValues(value) { (error, ref) in
            if let error = error{
                print("error in set commets", error)
                return
            }
        }
    }
}


extension CommentController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        let dymCell = CommentCell(frame: frame)
        dymCell.comment = comments[indexPath.item]
        dymCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estmaitedSize = dymCell.systemLayoutSizeFitting(targetSize)
        let height = max(50 + 16, estmaitedSize.height)
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
