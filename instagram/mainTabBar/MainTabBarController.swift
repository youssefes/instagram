//
//  MainTabBarController.swift
//  instagram
//
//  Created by youssef on 6/30/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let login = LogInVC()
                let navgController = UINavigationController(rootViewController: login)
                self.present(navgController, animated: true, completion: nil)
            }
            return
        }
        self.delegate = self
        setupViewController()
        
    }
    
    func setupViewController()  {
        //home ViewController add to tabBar
        guard let imageSelectedHome = UIImage(systemName: "house.fill"), let UnselectImageHome = UIImage(systemName: "house") else {return}
        let Home = templateNavigationController(unSelectedImage: UnselectImageHome, selectedImage: imageSelectedHome, rootViewController: HomeViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        
        // serarch viewContrroler
        guard let imageSelectedsearch = UIImage(systemName: "magnifyingglass"), let UnselectImagesearch = UIImage(systemName: "magnifyingglass") else {return}
        let SearchNc = templateNavigationController(unSelectedImage: UnselectImagesearch, selectedImage: imageSelectedsearch,rootViewController: SearchVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //Plus ViewController add to tabBar
        guard let imageSelectedPlus = UIImage(systemName: "plus.app.fill"), let UnselectImagePlus = UIImage(systemName: "plus.app") else {return}
        let PlusNc = templateNavigationController(unSelectedImage: UnselectImagePlus, selectedImage: imageSelectedPlus)
        
        //Plus ViewController add to tabBar
        guard let imageSelectedLike = UIImage(systemName: "heart.fill"), let UnselectImageLike = UIImage(systemName: "heart") else {return}
        let LikeNc = templateNavigationController(unSelectedImage: UnselectImageLike, selectedImage: imageSelectedLike)
        
        //UserPorfileViewcontroller Add to TabBar
        let layout = UICollectionViewFlowLayout()
        let UserProfile = UserProfileVC(collectionViewLayout: layout)
        let UserporofilNc = UINavigationController(rootViewController: UserProfile)
        UserporofilNc.tabBarItem.image = UIImage(systemName: "person")
        UserporofilNc.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        
        tabBar.tintColor = .black
        viewControllers = [Home,SearchNc,PlusNc,LikeNc,UserporofilNc]
    }
    
    func templateNavigationController(unSelectedImage : UIImage, selectedImage : UIImage, rootViewController : UIViewController = UIViewController() ) -> UINavigationController{
        let viewContrroler = rootViewController
        let nevController = UINavigationController(rootViewController: viewContrroler)
        nevController.tabBarItem.image = unSelectedImage
        nevController.tabBarItem.selectedImage = selectedImage
        return nevController
    }
}


extension MainTabBarController : UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if  let index = viewControllers?.firstIndex(of : viewController) {
            if index == 2{
                let layout = UICollectionViewFlowLayout()
                let photoSelector = PhotoSelectorVc(collectionViewLayout: layout)
                let navgationController = UINavigationController(rootViewController: photoSelector)
                present(navgationController, animated: true, completion: nil)
                return false
            }
            
        }
        
        return true
    }
}
