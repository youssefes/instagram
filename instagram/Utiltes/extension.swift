//
//  extension.swift
//  instagram
//
//  Created by youssef on 6/29/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


extension UIView{
    func anchor(top : NSLayoutYAxisAnchor?, bottom : NSLayoutYAxisAnchor?,left : NSLayoutXAxisAnchor?, right : NSLayoutXAxisAnchor?, padingTop  : CGFloat, padingBotton  : CGFloat, padingLeft  : CGFloat, padingRight : CGFloat, width : CGFloat, height : CGFloat)  {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: padingTop).isActive = true
        }
        
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: padingLeft).isActive = true
            
        }
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom , constant: padingBotton).isActive = true
        }
        if let right = right{
            self.rightAnchor.constraint(equalTo: right, constant: padingRight).isActive = true
        }
        
        if height != 0{
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width != 0{
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        
    }
}
