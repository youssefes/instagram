//
//  user.swift
//  instagram
//
//  Created by youssef on 7/9/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation
struct User {
    var userName : String
    var prrofilURlImage : String
    var email : String
    var userID : String
    
    init(userId : String, dictionary : [String :Any]) {
        self.userName = dictionary["username"] as? String ?? ""
        self.email = dictionary["username"] as? String ?? ""
        self.prrofilURlImage =  dictionary["profileURL"] as? String ?? ""
        self.userID = userId
    }
}
