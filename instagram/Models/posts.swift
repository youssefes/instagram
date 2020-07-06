//
//  posts.swift
//  instagram
//
//  Created by youssef on 7/5/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation
struct Posts{
    var imageUrl : String
    init(dictionary : [String : Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
