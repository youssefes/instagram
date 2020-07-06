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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        // MARK :-  register headerCell
        
        
        
        collectionView.register(userProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView.register(postPhotesCell.self, forCellWithReuseIdentifier: cellId)
        fetchUser()
        
        setupLogOutBotton()
        
        //fetchPosts()
        fetchOrderPosts()
        
    }
    
    fileprivate func fetchOrderPosts(){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let referance = Database.database().reference().child("Posts").child(userId)
        
        referance.queryOrdered(byChild: "creationDate").observe(.childAdded) { (snapchat) in
            guard let dictionary = snapchat.value as? [String : Any] else {
                return
            }
            
            let post = Posts(dictionary: dictionary)
            self.posts.append(post)
            self.collectionView.reloadData()
        }
    }
    
    
    
    var user : User?
    
    
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



struct User {
    var userName : String
    var prrofilURlImage : String
    
    init(dictionary : [String :Any]) {
        self.userName = dictionary["username"] as? String ?? ""
        self.prrofilURlImage =  dictionary["profileURL"] as? String ?? ""
        
    }
}
