//
//  Typography.swift
//  Opportunities
//
//  Created by youssef on 12/1/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation
import UIKit

extension DesignSystem {
    enum Typography {
        case Title
        case SubLable
        case button
        
        private var fontDiscriptor : CustomFontDiscriptor {
            switch self {
            case .Title:
                return CustomFontDiscriptor(font: .ExtraReg, size: 55, Style: .title1)
            case .SubLable:
                return CustomFontDiscriptor(font: .Medium, size: 20, Style: .title2)
            case .button:
                return CustomFontDiscriptor(font: .Medium, size: 20, Style: .body)
                
            }
        }
        
        var font : UIFont {
            guard let font = UIFont(name: fontDiscriptor.font.name, size: fontDiscriptor.size) else{
                return UIFont.preferredFont(forTextStyle: fontDiscriptor.Style)
            }
            
            let fontMatrix = UIFontMetrics(forTextStyle: fontDiscriptor.Style)
            return fontMatrix.scaledFont(for: font)
        }
    }
}
