//
//  Font.swift
//  Opportunities
//
//  Created by youssef on 12/1/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation


enum Font : String {
    case Bold = "Gilroy-Bold"
    case ExtraReg = "Gilroy-Regular"
    case Light =  "Gilroy-Light"
    case Medium = "Gilroy-Medium"
    var name : String {
        return self.rawValue
    }
}
