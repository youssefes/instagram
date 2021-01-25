//
//  Comment.swift
//  instagram
//
//  Created by youssef on 1/25/21.
//  Copyright © 2021 youssef. All rights reserved.
//

import Foundation

struct Comment {
    var text : String
    var Uid : String
    var user : User?
    init(dictionary : [String :Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.Uid = dictionary["Uid"] as? String ?? ""
    }
}
