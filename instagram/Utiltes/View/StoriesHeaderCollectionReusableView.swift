//
//  StoriesHeaderCollectionReusableView.swift
//  Design_to_code10
//
//  Created by Dheeraj Kumar Sharma on 05/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

struct UserStory {
    let name:String!
    let img:String!
}

class StoriesHeaderCollectionReusableView: UICollectionReusableView {
        
    let user:[UserStory] = [
        UserStory(name: "Dheeraj", img: "prof-img1"),
        UserStory(name: "Sammy", img: "prof-img2"),
        UserStory(name: "Richard", img: "prof-img3"),
        UserStory(name: "Henry", img: "prof-img4"),
        UserStory(name: "Payne", img: "prof-img5"),
        UserStory(name: "Lia", img: "prof-img6")
    ]
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(StoryImageCollectionViewCell.self, forCellWithReuseIdentifier: "StoryImageCollectionViewCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cv.setCollectionViewLayout(layout, animated: false)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.pin(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StoriesHeaderCollectionReusableView:UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryImageCollectionViewCell", for: indexPath) as! StoryImageCollectionViewCell
        cell.imageView.image = UIImage(named: user[indexPath.row].img)
        cell.userName.text = user[indexPath.row].name
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
