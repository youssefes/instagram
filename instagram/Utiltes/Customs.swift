//
//  Customs.swift
//  Design_to_code10
//
//  Created by Dheeraj Kumar Sharma on 04/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

struct CustomFont{
    static let logo = "Billabong"
}

struct CustomColor {
    static let appLightGray:UIColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 1)
}

extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {


        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}
