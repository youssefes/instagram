//
//  PhotoSelectorController.swift
//  instagram
//
//  Created by youssef on 7/2/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Photos
import Firebase

protocol PhotosSeccessUpload {
    func seccessFetchPotos(image : UIImage)
}

class PhotoSelectorVc : UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var Deleget : PhotosSeccessUpload?
    
    var selectedImage : UIImage?
    var SelectAsset = [PHAsset]()
    let cellId = "cellId"
    let HeaderId = "HeaderId"
    
    var post : String = ""
    
    init(collectionViewLayout layout: UICollectionViewLayout,deleget : PhotosSeccessUpload) {
        super.init(collectionViewLayout: layout)
         self.Deleget = deleget
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PhotoHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderId)
        
        collectionView.backgroundColor = .white
        collectionView.register(PhotoesSelectorCell.self, forCellWithReuseIdentifier: cellId)
        setUpTapBarButtons()
        
        fetechPhotoes()
    }
    var header : PhotoHeaderCell?
    var images = [UIImage]()
    
    func fetechPhotoes() {
        
        
        DispatchQueue.global(qos: .background).async {
            
            let optinPhotoes = PHFetchOptions()
            optinPhotoes.fetchLimit = 30
            
            let sortDescription = NSSortDescriptor(key: "creationDate", ascending: false)
            optinPhotoes.sortDescriptors = [sortDescription]
            let allPhotos = PHAsset.fetchAssets(with: .image, options: optinPhotoes)
            allPhotos.enumerateObjects { (asset, count, stop) in
                print(count)
                
                let imageManger = PHImageManager.default()
                
                let targetSize = CGSize(width: 200, height: 200)
                let optionManger = PHImageRequestOptions()
                optionManger.isSynchronous = true
                imageManger.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: optionManger) { (image, info) in
                    if let image = image {
                        self.images.append(image)
                        self.SelectAsset.append(asset)
                        if self.selectedImage == nil{
                            self.selectedImage = image
                           
                        }
                    }
                    
                    if count == allPhotos.count - 1{
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                    }
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Selected", style: .plain, target: self, action: #selector(NextButton) )
        
    }
    
    @objc func cancelButton (){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func NextButton (){
        guard let image = selectedImage else{return}
        self.Deleget?.seccessFetchPotos(image: image)
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let  imageSelected = images[indexPath.item]
        self.selectedImage = imageSelected
        self.collectionView.reloadData()
        
        let index = IndexPath(item: 0, section: 0)
        
        collectionView.scrollToItem(at: index, at: .bottom, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderId, for: indexPath) as? PhotoHeaderCell{
            self.header = header
            header.ImageView.image = selectedImage
            
            if let selectImage = selectedImage{
                if let index = self.images.firstIndex(of: selectImage){
                    let  selectAsset = self.SelectAsset[index]
                    
                    let imageManger = PHImageManager.default()
                    let target = CGSize(width: 600, height: 600)
                    imageManger.requestImage(for: selectAsset, targetSize: target, contentMode: .default, options: nil) { (image, infe) in
                        header.ImageView.image = image
                    }
                    
                    
                }
            }
            return header
        }else{
            
            return UICollectionViewCell()
        }
        
        
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
