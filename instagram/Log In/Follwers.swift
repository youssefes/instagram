//
//  Follwers.swift
//  instagram
//
//  Created by youssef on 3/6/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit
import Firebase
class Follwers: UIViewController {
    
    
    lazy var backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "prof4")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    lazy var MainLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Gilroy-Bold", size: 30)
        let attributedString = NSMutableAttributedString(string: "HOW MANY FOLLWERS DO YOU WANT?")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        lable.attributedText = attributedString
        lable.textColor = .white
        lable.numberOfLines = 0
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var BackButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Arrow   Left 2"), for: .normal)
        button.addTarget(self, action: #selector(handelSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let FollwersBtn : UIButton = {
        let button = UIButton()
        button.setTitle("FOLLOWERS", for: .normal)
        button.backgroundColor = .systemPurple
        button.cornerRadius = 4
        button.titleLabel?.font = UIFont(name: "Gilroy-Medium", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        return button
    }()
    
    
   lazy var subLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Gilroy-Medium", size: 16)
        lable.text = "PICK HERE "
        lable.textColor = .white
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    lazy var AcceeptTerms : UILabel = {
         let lable = UILabel()
         lable.font =  UIFont(name: "Gilroy-Medium", size: 16)
         let attributedString = NSMutableAttributedString(string: "BE FAMOUS , LIVE YOUR DREAM NEW")
         let paragraphStyle = NSMutableParagraphStyle()
         paragraphStyle.lineHeightMultiple = 1.5
         attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
         lable.attributedText = attributedString
         lable.textColor = .white
         lable.numberOfLines = 0
        lable.textAlignment = .center
         lable.translatesAutoresizingMaskIntoConstraints = false
         return lable
     }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
         view.addSubview(backgroundImage)
        view.addSubview(BackButton)
        view.addSubview(MainLabel)
        view.addSubview(AcceeptTerms)
        view.addSubview(FollwersBtn)
        view.addSubview(subLabel)
        setupInputView()
    }
    
    @objc func handelSignIn (){
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp(){
        
       
    }
    fileprivate func  setupInputView(){
        
        NSLayoutConstraint.activate([
            // add constraint to BackGround Image
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        BackButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, padingTop: 20, padingBotton: 0, padingLeft: 20, padingRight: 0, width: 40, height: 40)
        MainLabel.anchor(top: BackButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 20, padingBotton: 0, padingLeft: 40, padingRight: -40, width: 0, height: 0)
        FollwersBtn.anchor(top: MainLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 100, padingBotton: 0, padingLeft: 20, padingRight: -20, width: 0, height: 45)
        subLabel.anchor(top: FollwersBtn.bottomAnchor, bottom: nil, left: FollwersBtn.leftAnchor, right: FollwersBtn.rightAnchor, padingTop: 20, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 0)
        AcceeptTerms.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor , right: view.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 80, padingRight: -80, width: 0, height: 0)
        
    }
}




