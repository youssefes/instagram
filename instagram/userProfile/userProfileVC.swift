//
//  userProfileVC.swift
//  instagram
//
//  Created by youssef on 6/30/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC : UICollectionViewController, userProfileHeaderDeleget {
    
    
    var isfinishPagin = false
    
    let cellId = "cellId"
    let cellHomeIde = "cellHomeIde"
    var posts = [Posts]()
    var user : User?
    var userId : String?
    
    var isGridView = true
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        // MARK :-  register headerCell
        collectionView.register(userProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView.register(postPhotesCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellHomeIde)
        fetchUser()
        setupLogOutBotton()
    }
    
    fileprivate func fetchPaginationPost(){
        let userId = self.userId ?? (Auth.auth().currentUser?.uid ?? "")
        let referance = Database.database().reference().child("Posts").child(userId)
       
        let query = referance.queryOrderedByKey()
        
        if posts.count > 0 {
            let value = posts.last?.id
            query.queryStarting(atValue: value)
        }
        query.queryLimited(toFirst: 4).observeSingleEvent(of: .value) { (snapchat) in
            guard var allObjet = snapchat.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            if allObjet.count < 4{
                self.isfinishPagin = true
            }
            if self.posts.count > 0 {
                allObjet.removeFirst()
            }
            
            allObjet.forEach({ (snapchat) in
                
                guard let user = self.user else{return}
                guard let dictionery = snapchat.value as? [String: Any] else {return}
                var post = Posts(user: user, dictionary: dictionery)
                post.id = snapchat.key
                self.posts.append(post)
            })
            
            self.collectionView.reloadData()
        }
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
            self.posts.insert(post, at: 0)
//            self.posts.append(post)
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
                login.modalPresentationStyle = .overFullScreen
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
            self.fetchPaginationPost()
        }
    }
}

extension UserProfileVC : UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as? userProfileHeader else {
            return UICollectionViewCell()
        }
        header.user = self.user
        header.Deleget = self
        return header
    }
    
    func didchangeToGrid() {
        isGridView = true
        collectionView.reloadData()
    }
    
    func didchangeTolist() {
        isGridView = false
        collectionView.reloadData()

    }
    
    //MARK :- collectionView images 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == self.posts.count - 1 && !isfinishPagin{
            self.fetchPaginationPost()
        }
        if isGridView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! postPhotesCell
            cell.post = posts[indexPath.item]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellHomeIde, for: indexPath) as! HomeCell
            cell.post = posts[indexPath.item]
            return cell
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isGridView{
            let width = (view.frame.width - 2) / 3
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: view.frame.width, height: 580)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}




