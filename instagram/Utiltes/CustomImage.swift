//
//  CustomImage.swift
//  instagram
//
//  Created by youssef on 7/6/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit


var ImageCach = [String : UIImage]()
class CustomImageView : UIImageView{
    
    var lastUrlUseToLoadingImage : String?
    func loadImage(imageUrl : String) {
        
        if let cachImage = ImageCach[imageUrl] {
            self.image = cachImage
            return
        }
        self.lastUrlUseToLoadingImage = imageUrl
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        if url.absoluteString != self.lastUrlUseToLoadingImage {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, respond, error) in
            guard let data = data else {
                return
            }
            guard let image = UIImage(data: data) else{
                return
            }
            
            ImageCach[url.absoluteString] = image
            DispatchQueue.main.async {
                self.image = image
                print("loading.....")
            }
        }.resume()
    }
}
