//
//  StoryImageCollectionViewCell.swift
//  Design_to_code10
//
//  Created by Dheeraj Kumar Sharma on 05/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class StoryImageCollectionViewCell: UICollectionViewCell {
    
    let imageView:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .lightGray
        img.clipsToBounds = true
        img.layer.cornerRadius = 34
        return img
    }()
    
    let backView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.layer.borderWidth = 2
        v.layer.cornerRadius = 40
        v.backgroundColor = .white
        return v
    }()
    
    let userName:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Dheeraj"
        l.textColor = .black
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        backView.addSubview(imageView)
        addSubview(userName)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backView.widthAnchor.constraint(equalToConstant: 80),
            backView.heightAnchor.constraint(equalToConstant: 80),
            
            imageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 68),
            imageView.heightAnchor.constraint(equalToConstant: 68),
            userName.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 5),
            userName.centerXAnchor.constraint(equalTo: centerXAnchor),
            userName.leadingAnchor.constraint(equalTo: leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
