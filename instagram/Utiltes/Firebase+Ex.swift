//
//  Firebase+Ex.swift
//  instagram
//
//  Created by youssef on 7/9/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation
import Firebase
extension Database {
    static func fetchUserWithUid(Uid : String, complation : @escaping (User)-> Void){
        Database.database().reference().child("users").child(Uid).observeSingleEvent(of: .value, with: { (snapchat) in
            guard let userdictionary = snapchat.value as? [String : Any] else {
                return
            }
            
            let user = User(userId: Uid, dictionary: userdictionary)
            complation(user)
            
        }) { (err) in
            print(err)
        }
    }
}
