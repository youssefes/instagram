//
//  GFButton.swift
//  gitHubFollwers
//
//  Created by youssef on 5/26/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame : frame)
        configration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(backgroundColor: UIColor , title : String) {
        super.init(frame : .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configration()
    }
    
    private func configration(){
        layer.cornerRadius = 25
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
