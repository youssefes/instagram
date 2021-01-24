//
//  CategoryWithImageCollectionViewCell.swift
//  Design_to_code10
//
//  Created by Dheeraj Kumar Sharma on 06/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class CategoryWithImageCollectionViewCell: UICollectionViewCell {
    let cardView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 22.5
        v.layer.borderColor = UIColor(white: 0, alpha: 0.07).cgColor
        v.layer.borderWidth = 2
        return v
    }()
    
    let cardImage:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let cardLabel:UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cardView)
        cardView.addSubview(cardLabel)
        cardView.addSubview(cardImage)
        cardView.pin(to: self)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            cardImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            cardImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            cardImage.widthAnchor.constraint(equalToConstant: 15),
            cardImage.heightAnchor.constraint(equalToConstant: 15),
            
            cardLabel.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 5),
            cardLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cardLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
