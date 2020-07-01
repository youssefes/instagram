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
            getProfilImage()
            userNameLable.text = user?.userName
        }
    }
    
    
    let ProfilImage : UIImageView = {
        let iv = UIImageView()
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
    
    let editProfileButtum : UIButton = {
        let button = UIButton()
        button.setTitle("EditProfile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
        

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ProfilImage)
        ProfilImage.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: nil, padingTop: 12, padingBotton: 0, padingLeft: 12, padingRight: 0, width: 80, height: 80)
        ProfilImage.layer.cornerRadius = 80 / 2
        ProfilImage.clipsToBounds = true
        
        setupButtonTabBar()
        
        addSubview(userNameLable)
        userNameLable.anchor(top: ProfilImage.bottomAnchor, bottom: gridButton.topAnchor, left: leftAnchor, right: rightAnchor, padingTop: 4, padingBotton: 0, padingLeft: 12, padingRight: 12, width: 0, height: 0)
        
        setupLabel()
        
        addSubview(editProfileButtum)
        
        editProfileButtum.anchor(top: postLable.bottomAnchor, bottom: nil, left: postLable.leftAnchor, right: followingLable.rightAnchor, padingTop: 8, padingBotton: 0, padingLeft: 0, padingRight: -12, width: 0, height: 50)
    
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func getProfilImage(){
        
            guard  let urlprofile = self.user?.prrofilURlImage else {
                return
            }
            guard let url = URL(string: urlprofile) else {
                return
            }
            URLSession.shared.dataTask(with: url) { (data, respond, error) in
                guard let data = data else {
                    return
                }
                guard let image = UIImage(data: data) else{
                    return
                }
                DispatchQueue.main.async {
                    self.ProfilImage.image = image
                }
            }.resume()
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
