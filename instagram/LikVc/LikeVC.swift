//
//  LikeVC.swift
//  LoftPop
//
//  Created by youssef on 1/27/21.
//  Copyright © 2021 youssef. All rights reserved.
//

import UIKit
import Firebase

class LikeVC : UIViewController, HomePostCellDeleget{
    
    let cellId = "cellId"
     let cellwithotImagg = "cellwithotImagg"
    var posts = [Posts]()
    
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        cv.register(HomeCellWithotImage.self, forCellWithReuseIdentifier: cellwithotImagg)
        cv.backgroundColor = .white
        cv.setCollectionViewLayout(layout, animated: false)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpCustomNavBar()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        let refreshVc = UIRefreshControl()
        refreshVc.addTarget(self, action: #selector(handelRefreshController), for: .valueChanged)
        collectionView.refreshControl = refreshVc
        collectionView.pin(to: view)
        fetchPosts()
    }
    
    @objc func handelRefreshController(){
        fetchPosts()
    }
    func setUpCustomNavBar(){
        title = "LIKES"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    fileprivate func fetchPosts(){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        Database.fetchUserWithUid(Uid: userId) { (user) in
            self.fetchPostWithUser(user: user)
        }
    }
    
    private func fetchPostWithUser(user : User){
        let referance = Database.database().reference().child("Posts").child(user.userID)
        referance.observeSingleEvent(of: .value, with: { (snapchat) in
            self.collectionView.refreshControl?.endRefreshing()
             self.posts.removeAll()
            guard let dictionary = snapchat.value as? [String : Any] else {
                return
            }
            dictionary.forEach { (key,value) in
                print("key: \(key) value \(value)")
                
                guard  let dictionaryValue = value as? [String : Any] else {
                    return
                }
               
                var post = Posts(user: user, dictionary: dictionaryValue)
                post.id = key
                guard let uid = Auth.auth().currentUser?.uid else {return}
                Database.database().reference().child("Likes").child(key).child(uid).observeSingleEvent(of: .value, with: { (Snapshot) in

                    if let value = Snapshot.value as? Int , value == 1{
                        post.hasLike = true
                        self.posts.append(post)
                    }else{
                        post.hasLike = false
                    }
                    self.posts.sort { (p1, p2) -> Bool in
                        return p1.creationDate.compare(p2.creationDate) == .orderedDescending
                    }
                    
                    self.collectionView.reloadData()
                }) { (error) in
                    print("error to fetch likes", error)
                }
            }
        }) { (error) in
            print(error)
        }
    }
    
    @objc func messageBtnPressed(){
        print("AddMassage")
    }
    
}

extension LikeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if posts[indexPath.row].imageUrl.isEmpty{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellwithotImagg, for: indexPath) as! HomeCellWithotImage
            cell.post = posts[indexPath.row]
            cell.delegate = self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
            cell.post = posts[indexPath.row]
            cell.delegate = self
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if posts[indexPath.row].imageUrl.isEmpty {
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            let dymCell = HomeCellWithotImage(frame: frame)
            dymCell.post = posts[indexPath.item]
            dymCell.layoutIfNeeded()
            let targetSize = CGSize(width: view.frame.width, height: 1000)
            let estmaitedSize = dymCell.systemLayoutSizeFitting(targetSize)
            let height = max(50+50 + 16, estmaitedSize.height)
            return CGSize(width: view.frame.width, height: height)
        }else{
            return CGSize(width: collectionView.frame.width, height: 580)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func didTApComment(post : Posts){
        print(post.caption)
        
        let commentViewcontroller = CommentController(collectionViewLayout: UICollectionViewFlowLayout())
        commentViewcontroller.post = post
        navigationController?.pushViewController(commentViewcontroller, animated: true)
    }
    
    func didlike(for homeCellPost: UICollectionViewCell) {
        guard let indexpath = collectionView.indexPath(for: homeCellPost) else {return}
        var post = posts[indexpath.item]
        guard  let postId = post.id else{return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values  = [uid : post.hasLike == true ? 0 : 1]
        Database.database().reference().child("Likes").child(postId).updateChildValues(values) { (error, _) in
            if let error = error{
                print("error in like ", error)
                return
            }
            print("seccess like")
             post.hasLike.toggle()
            self.posts[indexpath.item] = post
           
            self.collectionView.reloadItems(at: [indexpath])
        }
    }
}




