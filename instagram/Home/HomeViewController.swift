//
//  HomeViewController.swift
//  instagram
//
//  Created by youssef on 7/6/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController : UICollectionViewController {
    var posts = [Posts]()
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        setupNavagitionItems()
        fetchPosts()
    }
    
    func setupNavagitionItems() {
        navigationItem.title = "Instagram"
    }
    
    
    fileprivate func fetchPosts(){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let referance = Database.database().reference().child("Posts").child(userId)
        
        referance.observeSingleEvent(of: .value, with: { (snapchat) in
            
            guard let dictionary = snapchat.value as? [String : Any] else {
                return
            }
            
            dictionary.forEach { (key,value) in
                print("key: \(key) value \(value)")
                
                guard  let dictionaryValue = value as? [String : Any] else {
                    return
                }
                let post = Posts(dictionary: dictionaryValue)
                self.posts.append(post)
            }
            self.collectionView.reloadData()
            
            
        }) { (error) in
            print(error)
        }
        
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? HomeCell{
            cell.post = posts[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height : CGFloat = 40 + 8 + 8
        
        height += view.frame.width
        height += 50
        height += 70
        return CGSize(width: view.frame.width, height: height)
    }
}
