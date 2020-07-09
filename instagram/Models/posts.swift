//
//  posts.swift
//  instagram
//
//  Created by youssef on 7/5/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation
struct Posts{
    
    let user : User
    var imageUrl : String
    var caption : String
    init(user : User ,dictionary : [String : Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
