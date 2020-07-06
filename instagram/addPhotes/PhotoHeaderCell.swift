//
//  PhotoHeaderCell.swift
//  instagram
//
//  Created by youssef on 7/5/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit

class PhotoHeaderCell: UICollectionViewCell {
    let ImageView : UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ImageView)
        ImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
