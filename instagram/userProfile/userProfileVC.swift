//
//  userProfileVC.swift
//  instagram
//
//  Created by youssef on 6/30/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC : UICollectionViewController {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        collectionView.register(userProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        fetchUser()
    }
var user : User?
    
fileprivate func fetchUser(){
        guard let usreUId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(usreUId).observeSingleEvent(of: .value, with: { (Snapshot) in
            
            guard let snapshet = Snapshot.value as? [String : Any] else {
                return
            }
            
            self.user = User(dictionary: snapshet)
            guard let username = self.user?.userName else {
                return
            }
            self.navigationItem.title = username
            self.collectionView.reloadData()

        }) { (error) in
            print("filled to fetch user \(error)")
        }
    }
}

extension UserProfileVC : UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as? userProfileHeader else {
            return UICollectionViewCell()
        }
        header.user = self.user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}



struct User {
    var userName : String
    var prrofilURlImage : String
    
    init(dictionary : [String :Any]) {
        self.userName = dictionary["username"] as? String ?? ""
        self.prrofilURlImage =  dictionary["profileURL"] as? String ?? ""
        
    }
}
