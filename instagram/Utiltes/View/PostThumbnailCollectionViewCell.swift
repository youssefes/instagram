//
//  PostThumbnailCollectionViewCell.swift
//  Design_to_code10
//
//  Created by Dheeraj Kumar Sharma on 05/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class PostThumbnailCollectionViewCell: UICollectionViewCell {
    
    let thumbNailImage:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 20
        img.backgroundColor = .lightGray
        img.clipsToBounds = true
        return img
    }()
    
    let multipleIcon:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "multiple")?.withRenderingMode(.alwaysTemplate)
        img.tintColor = .white
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(thumbNailImage)
        addSubview(multipleIcon)
        NSLayoutConstraint.activate([
            thumbNailImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            thumbNailImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            thumbNailImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            thumbNailImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            multipleIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            multipleIcon.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            multipleIcon.widthAnchor.constraint(equalToConstant: 20),
            multipleIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
