//
//  HomeViewController.swift
//  Design_to_code10
//
//  Created by Dheeraj Kumar Sharma on 04/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    let cellId = "cellId"
    var posts = [Posts]()
    
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.register(StoriesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "StoriesHeaderCollectionReusableView")
        cv.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
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
        collectionView.pin(to: view)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPosts()
        fatchfollwingUsers()
    }
    
    private func fatchfollwingUsers(){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("Following").child(userId).observeSingleEvent(of: .value, with: { (snapchat) in
            guard let usersIdDectionary = snapchat.value as? [String : Any] else {return}
            usersIdDectionary.forEach { (key, value) in
                Database.fetchUserWithUid(Uid: key) { (user) in
                    self.fetchPostWithUser(user: user)
                }
            }
        }) { (error) in
            print("error in fatch users following", error)
        }
    }
    
    func setUpCustomNavBar(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel()
        titleLabel.text = "STORIES"
        titleLabel.font = UIFont(name: CustomFont.logo, size: 30)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        let LeftTitleItem = UIBarButtonItem(customView: titleLabel)
        
        let messageButton = UIButton(type: .system)
        messageButton.setTitle("VIEW ALL", for: .normal)
        messageButton.setTitleColor(.systemRed, for: .normal)

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: messageButton)
        messageButton.addTarget(self, action: #selector(messageBtnPressed), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem()
        rightBarButtonItem.customView = messageButton
        navigationItem.setRightBarButton(rightBarButtonItem, animated: false)
        
        navigationItem.setLeftBarButtonItems([LeftTitleItem], animated: true)
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
               
               guard let dictionary = snapchat.value as? [String : Any] else {
                   return
               }
               
               dictionary.forEach { (key,value) in
                   print("key: \(key) value \(value)")
                   
                   guard  let dictionaryValue = value as? [String : Any] else {
                       return
                   }
                   
                   let post = Posts(user: user, dictionary: dictionaryValue)
                self.posts.append(post)
               }
            self.posts.sort { (p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            }
               self.collectionView.reloadData()
           }) { (error) in
               print(error)
           }
       }
    
    @objc func messageBtnPressed(){
        
    }
    
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StoriesHeaderCollectionReusableView", for: indexPath) as! StoriesHeaderCollectionReusableView
                header.backgroundColor = .white
                return header
            default:
                return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 580)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

