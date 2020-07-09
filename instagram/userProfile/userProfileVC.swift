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
    var posts = [Posts]()
    var user : User?
    var userId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        // MARK :-  register headerCell
        collectionView.register(userProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView.register(postPhotesCell.self, forCellWithReuseIdentifier: cellId)
        fetchUser()
        
        setupLogOutBotton()
        
        
    }
    
    fileprivate func fetchOrderPosts(){
        let userId = self.userId ?? (Auth.auth().currentUser?.uid ?? "")
        
        let referance = Database.database().reference().child("Posts").child(userId)
        
        referance.queryOrdered(byChild: "creationDate").observe(.childAdded) { (snapchat) in
            guard let dictionary = snapchat.value as? [String : Any] else {
                return
            }
            guard let user = self.user else {
                return
            }
            let post = Posts(user: user, dictionary: dictionary)
            self.posts.append(post)
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupLogOutBotton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slowmo")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handelLogOutButton))
        
    }
    @objc func handelLogOutButton(){
        let alerController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alerController.addAction(UIAlertAction(title: "Log out ", style: .destructive, handler: { (_) in
            
            do{
                try  Auth.auth().signOut()
                
                let login = LogInVC()
                let navgController = UINavigationController(rootViewController: login)
                self.present(navgController, animated: true, completion: nil)
                
            }catch{
                
            }
            
        }))
        alerController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alerController, animated: true, completion: nil)
    }
    fileprivate func fetchUser(){
        let usreUId = userId ?? Auth.auth().currentUser?.uid ?? ""
        Database.fetchUserWithUid(Uid: usreUId) { (user) in
            self.user  = user
            self.navigationItem.title = self.user?.userName
         
            self.collectionView.reloadData()
            self.fetchOrderPosts()
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
    
    //MARK :- collectionView images 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? postPhotesCell {
            cell.post = posts[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
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




