//
//  HomeCell.swift
//  instagram
//
//  Created by youssef on 7/6/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit

protocol HomePostCellDeleget {
    func didTApComment(post : Posts)
    
}

class HomeCell: UICollectionViewCell {
    
    var delegate : HomePostCellDeleget?
    
    var post : Posts?{
        didSet{
            guard let url = post?.imageUrl else {
                return
            }
            
            
            ImageView.loadImage(imageUrl: url)
            guard let user = post?.user else {
                return
            }
            userNameLbl.text = user.userName
            PhotoImageView.loadImage(imageUrl: user.prrofilURlImage)
            
            
            setupCptionLbl()
        }
    }
    
    fileprivate func setupCptionLbl(){
        
        guard let post = self.post else{
            return
        }
        
        let nsAttributedString = NSMutableAttributedString(string: post.user.userName, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)])
        nsAttributedString.append(NSAttributedString(string: " \(post.caption) ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .semibold)]))
        
         nsAttributedString.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .semibold)]))
        
        let timpeToDisplay = post.creationDate.getPastTime(for: post.creationDate)
        nsAttributedString.append(NSAttributedString(string: timpeToDisplay, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .semibold), NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        captionLbl.attributedText = nsAttributedString
        
    }
    let PhotoImageView : CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let ImageView : CustomImageView = {
        let image = CustomImageView()
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
        label.numberOfLines = 0
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
