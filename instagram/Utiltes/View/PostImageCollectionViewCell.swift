//
//  PostImageCollectionViewCell.swift
//  Design_to_code10
//
//  Created by Dheeraj Kumar Sharma on 05/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class PostImageCollectionViewCell: UICollectionViewCell {
    
    let imagePreview:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 50
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imagePreview)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            imagePreview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imagePreview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            imagePreview.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imagePreview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
