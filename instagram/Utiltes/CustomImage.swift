//
//  CustomImage.swift
//  instagram
//
//  Created by youssef on 7/6/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit

class CustomImageView : UIImageView{
    
    var lastUrlUseToLoadingImage : String?
    func loadImage(imageUrl : String) {
        self.lastUrlUseToLoadingImage = imageUrl
        print("loading.....")
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
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
