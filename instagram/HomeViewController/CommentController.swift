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
        collectionView.backgroundColor = .black
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: "CommentCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
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
    
    lazy var containerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .systemPink
        containerView.frame = CGRect(x: 20, y: 0, width: 100, height: 45)
        let submitBtn = UIButton()
        submitBtn.setTitle("Send", for: .normal)
        submitBtn.setTitleColor(.white, for: .normal)
        submitBtn.titleLabel?.font = UIFont(name: Font.Medium.name, size: 16)
        submitBtn.addTarget(self, action: #selector(handleSubmitCommet), for: .touchUpInside)
        containerView.addSubview(submitBtn)
        
        submitBtn.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: nil, right: containerView.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: -12, width: 45, height: 0)
        
        containerView.addSubview(CommenttextField)
        CommenttextField.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, right: submitBtn.leftAnchor, padingTop: 0, padingBotton: 0, padingLeft: 12, padingRight: -12 , width: 0, height: 0)
        
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
        textField.placeholder = "Enter your Comment"
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
        return CGSize(width: view.frame.width, height: 100)
    }
}
