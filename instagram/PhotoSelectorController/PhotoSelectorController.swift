//
//  PhotoSelectorController.swift
//  instagram
//
//  Created by youssef on 7/2/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorVc : UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let HeaderId = "HeaderId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderId)
        
        collectionView.backgroundColor = .white
        collectionView.register(PhotoesSelectorCell.self, forCellWithReuseIdentifier: cellId)
        setUpTapBarButtons()
        
        fetechPhotoes()
    }
    
    var images = [UIImage]()
    
    func fetechPhotoes() {
        
        let optinPhotoes = PHFetchOptions()
        optinPhotoes.fetchLimit = 10
        
        let sortDescription = NSSortDescriptor(key: "creationDate", ascending: false)
        optinPhotoes.sortDescriptors = [sortDescription]
        let allPhotos = PHAsset.fetchAssets(with: .image, options: optinPhotoes)
        allPhotos.enumerateObjects { (asset, count, stop) in
            print(asset)
            
            let imageManger = PHImageManager.default()
            
            let targetSize = CGSize(width: 250, height: 250)
            let optionManger = PHImageRequestOptions()
            optionManger.isSynchronous = true
            imageManger.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: optionManger) { (image, info) in
                if let image = image {
                    self.images.append(image)
                }
                
                if count == allPhotos.count - 1{
                    self.collectionView.reloadData()
                }
            }
        }
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    func setUpTapBarButtons() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cansel", style: .plain, target: self, action: #selector(cancelButton) )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(NextButton) )
        
    }
    
    @objc func cancelButton (){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func NextButton (){
        print("next")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderId, for: indexPath)
        header.backgroundColor = .red
        return header
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotoesSelectorCell {
            cell.ImageView.image = images[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width  , height: width)
    }
    
}
