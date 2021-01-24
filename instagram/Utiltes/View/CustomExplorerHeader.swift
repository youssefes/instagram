//
//  CustomExplorerHeader.swift
//  Design_to_code10
//
//  Created by Dheeraj Kumar Sharma on 05/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class CustomExplorerHeader: UIView {
    
    let categoryArr:[String] = ["IGTV" , "Shop" , "Photograph" , "Decor" , "Travel" , "Architecture" , "Art" , "Food"]
    
    let searchBarView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    let searchBar:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0, alpha: 0.1)
        v.layer.cornerRadius = 22.5
        return v
    }()
    
    let searchLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Search"
        l.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        l.textColor = .lightGray
        return l
    }()
    
    let searchIcon:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        img.tintColor = .black
        img.clipsToBounds = true
        return img
    }()
    
    let scanIcon:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "scan")?.withRenderingMode(.alwaysOriginal)
        img.clipsToBounds = true
        return img
    }()
    
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(CategoryWithImageCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryWithImageCollectionViewCell")
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        cv.backgroundColor = .white
        cv.setCollectionViewLayout(layout, animated: false)
        cv.delegate = self
        cv.dataSource = self
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBarView)
        addSubview(collectionView)
        searchBarView.addSubview(searchIcon)
        searchBarView.addSubview(scanIcon)
        searchBarView.addSubview(searchBar)
        searchBar.addSubview(searchLabel)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBarView.heightAnchor.constraint(equalToConstant: 50),
            
            searchIcon.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 20),
            searchIcon.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 50),
            searchIcon.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 5),
            searchBar.trailingAnchor.constraint(equalTo: scanIcon.leadingAnchor, constant: -5),
            searchBar.heightAnchor.constraint(equalToConstant: 45),
            
            scanIcon.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: -20),
            scanIcon.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            scanIcon.widthAnchor.constraint(equalToConstant: 50),
            scanIcon.heightAnchor.constraint(equalToConstant: 50),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 20),
            searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomExplorerHeader:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row >= 0 && indexPath.row <= 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryWithImageCollectionViewCell", for: indexPath) as! CategoryWithImageCollectionViewCell
            if indexPath.row == 0 {
                cell.cardImage.isHidden = false
                cell.cardImage.image = UIImage(named: "igtv")
            }
            if indexPath.row == 1 {
                cell.cardImage.isHidden = false
                cell.cardImage.image = UIImage(named: "shop")
            }
            cell.cardLabel.text = categoryArr[indexPath.row]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.cardLabel.text = categoryArr[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = categoryArr[indexPath.row]
        let font = UIFont.systemFont(ofSize: 15)
        let width = string.size(OfFont: font).width
        if indexPath.row >= 0 && indexPath.row <= 1 {
            return CGSize(width: width + 60, height: 45)
        }
        return CGSize(width: width + 40, height: 45)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}
