//
//  SearchCell.swift
//  instagram
//
//  Created by youssef on 7/9/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase

class SearchCell: UICollectionViewCell {
    var user : User?{
        didSet{
            guard let user = user else {
                return
            }
            userNameLbl.text = user.userName
            PhotoImageView.loadImage(imageUrl: user.prrofilURlImage)
        }
    }
    
    let PhotoImageView : CustomImageView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(PhotoImageView)
        addSubview(userNameLbl)
        PhotoImageView.anchor(top: nil, bottom: nil , left: leftAnchor, right: nil, padingTop: 0, padingBotton: 0, padingLeft: 8, padingRight: 0, width: 50, height: 50)
        PhotoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        PhotoImageView.layer.cornerRadius = 50 / 2
        
        userNameLbl.anchor(top: topAnchor, bottom: bottomAnchor, left: PhotoImageView.rightAnchor, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 8, padingRight: 0, width: 0, height: 0)
        
        let seporatedView = UIView()
        seporatedView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(seporatedView)
        seporatedView.anchor(top: nil, bottom: bottomAnchor, left: userNameLbl.leftAnchor, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
