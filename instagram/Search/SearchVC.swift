//
//  SearchVC.swift
//  instagram
//
//  Created by youssef on 7/9/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase

class SearchVC: UICollectionViewController {
    
    
    var users = [User]()
    var filterUser = [User]()
    
    lazy var serachBar : UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter username"
        sb.delegate = self
        return sb
    }()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        addSearchBar()
        
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        
        fetchUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        serachBar.isHidden = false
    }
    private func addSearchBar(){
        let nav = navigationController?.navigationBar
        
        nav?.addSubview(serachBar)
        serachBar.anchor(top: nav?.topAnchor, bottom: nav?.bottomAnchor, left: nav?.leftAnchor, right: nav?.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 8, padingRight: -8, width: 0, height: 0)
    }
    
    
    fileprivate func fetchUsers(){
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapchat) in
            guard let value = snapchat.value as? [String : Any] else {
                return
            }
            value.forEach { (key, value) in
                guard let userDictionary = value as? [String: Any] else{
                    return
                }
                
                let user = User(userId: key, dictionary: userDictionary)
                
                if key == Auth.auth().currentUser?.uid {
                    return
                }
                self.users.append(user)
                
                
            }
            
            self.users.sort { (u1, u2) -> Bool in
                return u1.userName.compare(u2.userName) == .orderedAscending
            }
            self.filterUser = self.users
            self.collectionView.reloadData()
        }) { (err) in
            print(err)
        }
    }
    
    
}

extension SearchVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            self.filterUser = self.users
        }else{
            self.filterUser = self.users.filter({ (user) -> Bool in
                return user.userName.lowercased().contains(searchText.lowercased())
            })
        }
        collectionView.reloadData()
    }
}

extension SearchVC : UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterUser.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SearchCell else{
            return UICollectionViewCell()
        }
        
        cell.user = filterUser[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: view.frame.width, height: 66)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        serachBar.isHidden = true
        serachBar.resignFirstResponder()
        let user = self.filterUser[indexPath.item]
        
        let profileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        profileVC.userId = user.userID
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
