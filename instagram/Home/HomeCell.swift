//
//  HomeCell.swift
//  instagram
//
//  Created by youssef on 7/6/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    var post : Posts?{
        didSet{
            guard let url = post?.imageUrl else {
                return
            }
            ImageView.loadImage(imageUrl: url)
        }
    }
    
    let PhotoImageView : CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let ImageView : CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let userNameLbl : UILabel = {
        let label = UILabel()
        label.text = "userName"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let captionLbl : UILabel = {
        let label = UILabel()
        //label.text = "tidjfkjtyoyooyoyoyoyoyoyoyo"
        let nsAttributedString = NSMutableAttributedString(string: "userName ", attributes: [NSAttributedString.Key.font : 14])
        nsAttributedString.append(NSAttributedString(string: "some captiopvnfjfkfkfkf", attributes: [NSAttributedString.Key.font : 14]))
        
           nsAttributedString.append(NSAttributedString(string: "\n" , attributes: [NSAttributedString.Key.font : 4]))
        
        nsAttributedString.append(NSAttributedString(string: "\n 1 weaks age ", attributes: [NSAttributedString.Key.font : 14, NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        label.attributedText = nsAttributedString
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let optionButton : UIButton = {
        let button = UIButton()
        button.setTitle("...", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let likeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let commentButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(PhotoImageView)
        addSubview(userNameLbl)
        addSubview(ImageView)
        addSubview(optionButton)
        ImageView.anchor(top: PhotoImageView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, padingTop: 8, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0)
        ImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        PhotoImageView.anchor(top: topAnchor, bottom: nil , left: leftAnchor, right: nil, padingTop: 8, padingBotton: 0, padingLeft: 8, padingRight: 0, width: 40, height: 40)
        PhotoImageView.layer.cornerRadius = 40 / 2
        
        userNameLbl.anchor(top: topAnchor, bottom: PhotoImageView.bottomAnchor, left: PhotoImageView.rightAnchor, right: optionButton.leftAnchor, padingTop: 0, padingBotton: 0, padingLeft: 8, padingRight: 0, width: 0, height: 0)
        
        optionButton.anchor(top: topAnchor, bottom: PhotoImageView.bottomAnchor, left: nil, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 44, height: 0)
        
        setUpActionButton()

        addSubview(captionLbl)
        captionLbl.anchor(top: likeButton.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 8, padingRight: 8, width: 0, height: 0)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpActionButton(){
        let stackView = UIStackView(arrangedSubviews: [likeButton,commentButton,sendMassageButton])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: ImageView.bottomAnchor, bottom: nil, left: leftAnchor, right: nil, padingTop: 0, padingBotton: 0, padingLeft: 8, padingRight: 0, width: 150, height: 50)
        
        addSubview(bookmarkButton)
        bookmarkButton.anchor(top: ImageView.bottomAnchor, bottom: nil, left: nil, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 50, height: 50)
    }
    
}
