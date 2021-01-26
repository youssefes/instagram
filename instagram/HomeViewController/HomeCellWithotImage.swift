//
//  HomeCellWithotImage.swift
//  LoftPop
//
//  Created by youssef on 1/26/21.
//  Copyright © 2021 youssef. All rights reserved.
//


import UIKit

class HomeCellWithotImage: UICollectionViewCell {
    
    var delegate : HomePostCellDeleget?
    
    var post : Posts?{
        didSet{
            
            guard let caption = post?.caption else {
                return
            }
            guard let user = post?.user else {
                return
            }
            
            guard let post = post else {
                return
            }
            likeButton.setImage(post.hasLike == true ? #imageLiteral(resourceName: "heart") : #imageLiteral(resourceName: "activity-selected"), for: .normal)
            PhotoImageView.loadImage(imageUrl: user.prrofilURlImage)
            let timpeToDisplay = post.creationDate.getPastTime(for: post.creationDate)
            timaCreationLbl.text = timpeToDisplay
            captionLbl.text = caption
            userNameLbl.text = user.userName
        }
    }

    
    let PhotoImageView : CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let userNameLbl : UILabel = {
        let label = UILabel()
        label.text = "userName"
        label.font = UIFont(name: Font.Bold.name, size: 14)
        return label
    }()
    
    let timaCreationLbl : UILabel = {
        let label = UILabel()
        label.text = "userName"
        label.font = UIFont(name: Font.Light.name, size: 10)
        label.textColor = UIColor.gray
        return label
    }()
    
    let captionLbl : UITextView = {
        let TextView = UITextView()
        TextView.isScrollEnabled = false
        TextView.backgroundColor = .clear
        TextView.font = UIFont.boldSystemFont(ofSize: 14)
        return TextView
    }()
    
    let optionButton : UIButton = {
        let button = UIButton()
        button.setTitle("...", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var likeButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "activity-selected"), for: .normal)
        button.addTarget(self, action: #selector(handelLikeBtn), for: .touchUpInside)
        return button
    }()
    
    @objc func handelLikeBtn(){
        delegate?.didlike(for: self)
    }
    
    lazy var commentButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handelComment), for: .touchUpInside)
        return button
    }()
    
    let sendMassageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let bookmarkButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    @objc func handelComment(){
        print("comment")
        guard let post = post else {
            return
        }
        delegate?.didTApComment(post: post)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(PhotoImageView)
        addSubview(userNameLbl)
        addSubview(optionButton)
        addSubview(timaCreationLbl)
        PhotoImageView.anchor(top: topAnchor, bottom: nil , left: leftAnchor, right: nil, padingTop: 8, padingBotton: 0, padingLeft: 8, padingRight: 0, width: 40, height: 40)
        PhotoImageView.layer.cornerRadius = 40 / 2
        
        userNameLbl.anchor(top: PhotoImageView.topAnchor, bottom: nil, left: PhotoImageView.rightAnchor, right: optionButton.leftAnchor, padingTop: 10, padingBotton: 0, padingLeft: 8, padingRight: 0, width: 0, height: 0)
        
        timaCreationLbl.anchor(top:  userNameLbl.bottomAnchor, bottom: PhotoImageView.bottomAnchor, left: PhotoImageView.rightAnchor, right: optionButton.leftAnchor, padingTop: 0, padingBotton: 0, padingLeft: 8, padingRight: 0, width: 0, height: 0)
        
        optionButton.anchor(top: topAnchor, bottom: PhotoImageView.bottomAnchor, left: nil, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 44, height: 0)
        
        addSubview(captionLbl)
        captionLbl.anchor(top: PhotoImageView.bottomAnchor, bottom: nil, left: PhotoImageView.rightAnchor, right: rightAnchor, padingTop: 12, padingBotton: 0, padingLeft: 8, padingRight: 8, width: 0, height: 0)
        
        setUpActionButton()

       
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpActionButton(){
        let stackView = UIStackView(arrangedSubviews: [likeButton,commentButton,sendMassageButton])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: captionLbl.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: nil, padingTop: 12, padingBotton: 0, padingLeft: 8, padingRight: 0, width: 150, height: 0)
        
        addSubview(bookmarkButton)
        likeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bookmarkButton.anchor(top: captionLbl.bottomAnchor, bottom: nil, left: nil, right: rightAnchor, padingTop: 12, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 50, height: 50)
    }
    
}

