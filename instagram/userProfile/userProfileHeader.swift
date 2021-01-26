//
//  userProfileHeader.swift
//  instagram
//
//  Created by youssef on 6/30/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase

protocol userProfileHeaderDeleget {
    func didchangeToGrid()
    func didchangeTolist()
}
class userProfileHeader : UICollectionViewCell {
    
    var Deleget : userProfileHeaderDeleget?
    
    var user : User? {
        didSet{
            guard  let urlprofile = self.user?.prrofilURlImage else {
                return
            }
            guard let email = Auth.auth().currentUser?.email else {
                      return
                  }
            userEmailLable.text = email
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
    
    lazy var listButton : UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(handelListButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "rectangle.grid.3x2"), for: .normal)
        return button
    }()
    
    @objc func handelListButton(){
        listButton.tintColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        gridButton.tintColor = UIColor(white: 0, alpha: 0.2)
        Deleget?.didchangeTolist()
    }
    
    let BookmarkButton : UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        return button
    }()
    
    lazy var gridButton : UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        button.setImage(UIImage(systemName: "grid"), for: .normal)
        button.addTarget(self, action: #selector(handelgridButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handelgridButton(){
         gridButton.tintColor = UIColor.rgb(red: 17, green: 154, blue: 237)
         listButton.tintColor = UIColor(white: 0, alpha: 0.2)
        Deleget?.didchangeToGrid()
     }
    
    let userNameLable : UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = UIFont(name: Font.Bold.name, size: 20)
        lable.textAlignment = .center
        return lable
    }()
    
    let userEmailLable : UILabel = {
         let lable = UILabel()
         lable.textColor = .white
         lable.font = UIFont(name: Font.Bold.name, size: 20)
         lable.textAlignment = .center
         return lable
     }()
    
    let postLable : UILabel = {
        let lable = UILabel()
        lable.text = "11\nPosts"
        lable.textColor = .white
        lable.font = UIFont(name: Font.Bold.name, size: 18)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }()
    
    let followedLable : UILabel = {
        let lable = UILabel()
        lable.text = "11\nFollowing"
        lable.textColor = .white
        lable.font = UIFont(name: Font.Bold.name, size: 17)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }()
    
    let followingLable : UILabel = {
        let lable = UILabel()
        lable.text = "11\nFollwer"
        lable.textColor = .white
        lable.font = UIFont(name: Font.Bold.name, size: 17)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }()
    
    lazy var editProfileFollowButtum : UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: Font.ExtraReg.name, size: 15)
        button.addTarget(self, action: #selector(handledFollowanEdited), for: .touchUpInside)
        button.backgroundColor = .systemPink
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
        
        setupButtonTabBar()
  
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupButtonTabBar(){
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        addSubview(ProfilImage)
        ProfilImage.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: self.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0)
        let Gredientview = UIView()
        Gredientview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        addSubview(Gredientview)
        Gredientview.anchor(top: ProfilImage.topAnchor, bottom: ProfilImage.bottomAnchor, left: ProfilImage.leftAnchor, right: ProfilImage.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0)
        addSubview(userNameLable)
        
        userNameLable.anchor(top: nil, bottom: nil, left: nil, right: nil, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0)
        userNameLable.centerYAnchor.constraint(equalTo: ProfilImage.centerYAnchor,constant: -20).isActive = true
        userNameLable.centerXAnchor.constraint(equalTo: ProfilImage.centerXAnchor).isActive = true
        addSubview(userEmailLable)
        userEmailLable.anchor(top: userNameLable.bottomAnchor, bottom: nil, left: nil, right: nil, padingTop: 5, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0)
        userEmailLable.leadingAnchor.constraint(equalTo: userNameLable.leadingAnchor).isActive = true
         userEmailLable.trailingAnchor.constraint(equalTo: userNameLable.trailingAnchor).isActive = true
        userEmailLable.centerXAnchor.constraint(equalTo: ProfilImage.centerXAnchor).isActive = true
        let satackView = UIStackView(arrangedSubviews: [postLable,followedLable,followingLable])
        addSubview(satackView)
        satackView.axis = .horizontal
        satackView.distribution = .fillEqually
        satackView.spacing = 0
        satackView.alignment = .center
        satackView.anchor(top: nil, bottom: ProfilImage.bottomAnchor, left: self.leftAnchor, right: nil, padingTop: 0, padingBotton: 20 , padingLeft: 0, padingRight: 0, width: 0, height: 50)
        addSubview(editProfileFollowButtum)
        
        editProfileFollowButtum.anchor(top: nil, bottom: ProfilImage.bottomAnchor, left: satackView.rightAnchor, right: rightAnchor, padingTop: 0, padingBotton: 20, padingLeft: 12, padingRight: -12, width: 120, height: 40)
        
        layoutIfNeeded()
       
        let stackView = UIStackView(arrangedSubviews: [gridButton,listButton,BookmarkButton])
        addSubview(stackView)
        
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.anchor(top: ProfilImage.bottomAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 50)
        topDividerView.anchor(top: stackView.topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0.5)
        
      
        
        
    }
}
