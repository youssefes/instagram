//
//  userProfileHeader.swift
//  instagram
//
//  Created by youssef on 6/30/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase

class userProfileHeader : UICollectionViewCell {
    
    var user : User? {
        didSet{
            guard  let urlprofile = self.user?.prrofilURlImage else {
                return
            }
            ProfilImage.loadImage(imageUrl: urlprofile)
            userNameLable.text = user?.userName
            editProfile()
        }
    }
    
    fileprivate func editProfile(){
        guard let currentuser = Auth.auth().currentUser?.uid else{return}
        guard let userId = user?.userID else {return}
        
        if currentuser == userId {
            editProfileFollowButtum.setTitle("Edit Profile", for: .normal)
        }else{
            Database.database().reference().child("Following").child(currentuser).child(userId).observeSingleEvent(of: .value, with: { (snapchat) in
                if let follwed = snapchat.value as? Int , follwed == 1{
                    self.setUpUNFollowStyle()
                }else{
                    self.setUpFollowStyle()
                }
            }) { (err) in
                print("the error in follwing",err)
            }
        }
    }
    
    
    let ProfilImage : CustomImageView = {
        let iv = CustomImageView()
        return iv
    }()
    
    let listButton : UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.setImage(UIImage(systemName: "rectangle.grid.3x2"), for: .normal)
        return button
    }()
    
    let BookmarkButton : UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        return button
    }()
    
    let gridButton : UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.setImage(UIImage(systemName: "grid"), for: .normal)
        return button
    }()
    
    let userNameLable : UILabel = {
        let lable = UILabel()
        lable.text = "userName"
        lable.textAlignment = .center
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        return lable
    }()
    
    let postLable : UILabel = {
        let lable = UILabel()
        lable.text = "11\nPosts"
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }()
    
    let followedLable : UILabel = {
        let lable = UILabel()
        lable.text = "11\nPosts"
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }()
    
    let followingLable : UILabel = {
        let lable = UILabel()
        lable.text = "11\nPosts"
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }()
    
    lazy var editProfileFollowButtum : UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handledFollowanEdited), for: .touchUpInside)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    
    @objc func handledFollowanEdited(){
        guard let currentLogginUser = Auth.auth().currentUser?.uid else{return}
        guard let userId = user?.userID else {
            return
        }
        if editProfileFollowButtum.titleLabel?.text == "UNFollow" {
            print("UNFollow")
            Database.database().reference().child("Following").child(currentLogginUser).child(userId).removeValue { (error, ref) in
                if let error = error{
                    print(error)
                    return
                }else{
                    self.setUpFollowStyle()
                }
                
            }
            
        }else{
            let ref = Database.database().reference().child("Following").child(currentLogginUser)
            let values = [userId : 1]
            ref.updateChildValues(values) { (error, ref) in
                if let err = error {
                    print(err)
                    return
                }else{
                    self.setUpUNFollowStyle()
               
                }
                
            }
        }
        
    }
    
    fileprivate func setUpFollowStyle(){
        editProfileFollowButtum.setTitle("Follow", for: .normal)
        editProfileFollowButtum.backgroundColor = .systemPink
        editProfileFollowButtum.setTitleColor(.white, for: .normal)
        print("seccess unFollow")
    }
    
    fileprivate func setUpUNFollowStyle(){
        editProfileFollowButtum.setTitle("UNFollow", for: .normal)
        editProfileFollowButtum.backgroundColor = .systemPink
        editProfileFollowButtum.setTitleColor(.white, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ProfilImage)
        ProfilImage.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: nil, padingTop: 12, padingBotton: 0, padingLeft: 12, padingRight: 0, width: 80, height: 80)
        ProfilImage.layer.cornerRadius = 80 / 2
        ProfilImage.clipsToBounds = true
        
        setupButtonTabBar()
        
        addSubview(userNameLable)
        userNameLable.anchor(top: ProfilImage.bottomAnchor, bottom: nil, left: ProfilImage.leftAnchor, right: ProfilImage.rightAnchor, padingTop: 5, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 30)
        
        setupLabel()
        
        addSubview(editProfileFollowButtum)
        
        editProfileFollowButtum.anchor(top: postLable.bottomAnchor, bottom: nil, left: postLable.leftAnchor, right: followingLable.rightAnchor, padingTop: 15, padingBotton: 0, padingLeft: 0, padingRight: -12, width: 0, height: 45)
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    fileprivate func setupLabel(){
        let satackView = UIStackView(arrangedSubviews: [postLable,followedLable,followingLable])
        addSubview(satackView)
        satackView.axis = .horizontal
        satackView.distribution = .fillEqually
        satackView.alignment = .center
        satackView.anchor(top: topAnchor, bottom: nil, left: ProfilImage.rightAnchor, right: rightAnchor, padingTop: 12, padingBotton: 0, padingLeft: 12, padingRight: 0, width: 0, height: 50)
    }
    
    fileprivate func setupButtonTabBar(){
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton,listButton,BookmarkButton])
        addSubview(stackView)
        
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.anchor(top: nil, bottom: self.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 50)
        topDividerView.anchor(top: stackView.topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0.5)
    }
}
