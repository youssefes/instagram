//
//  Coler.swift
//  Opportunities
//
//  Created by youssef on 12/1/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation
import UIKit

extension DesignSystem {
    enum Colors : String {
        case title = "title"
      
        var color : UIColor {
            switch self {
            case .title:
                print(self.rawValue)
                return UIColor(named : self.rawValue)!
            }
        }
        
    }
}
