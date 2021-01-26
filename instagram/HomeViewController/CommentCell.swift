//
//  CommentCell.swift
//  instagram
//
//  Created by youssef on 1/25/21.
//  Copyright © 2021 youssef. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UICollectionViewCell {
    
    var comment : Comment?{
        didSet{
            guard let commet = comment else {return}
            guard let imageUrl = commet.user?.prrofilURlImage else {return}
            guard let userName = commet.user?.userName else {return}
           
            
            let nsAttributedString = NSMutableAttributedString(string: userName, attributes: [NSAttributedString.Key.font : UIFont(name: Font.Bold.name, size: 16) ?? "", NSAttributedString.Key.foregroundColor : UIColor.white])
            nsAttributedString.append(NSAttributedString(string: "  " + commet.text, attributes: [NSAttributedString.Key.font : UIFont(name: Font.ExtraReg.name, size: 16) ?? "", NSAttributedString.Key.foregroundColor : UIColor.white]))
            
             userNameLbl.attributedText = nsAttributedString
            PhotoImageView.loadImage(imageUrl: imageUrl)
        }
    }
    
    let PhotoImageView : CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let userNameLbl : UITextView = {
        let TextView = UITextView()
        TextView.isScrollEnabled = false
        TextView.backgroundColor = .clear
        TextView.font = UIFont.boldSystemFont(ofSize: 14)
        return TextView
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
        seporatedView.backgroundColor = UIColor.white
        addSubview(seporatedView)
        seporatedView.anchor(top: nil, bottom: bottomAnchor, left: userNameLbl.leftAnchor, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
