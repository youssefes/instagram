//
//  pickFollowers.swift
//  instagram
//
//  Created by youssef on 3/7/18.
//  Copyright © 2018 youssef. All rights reserved.
//


import UIKit
import Firebase

class pickFollowers : UIViewController {
    
    lazy var backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "prof4")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    
    lazy var MainLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: Font.Medium.rawValue , size: 30)
        let attributedString = NSMutableAttributedString(string: "PICK YOUR FAME")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        lable.attributedText = attributedString
        lable.textColor = .white
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var BackButton : UIButton = {
        let button = UIButton()
        button.setImage( #imageLiteral(resourceName: "Arrow   Left 2"), for: .normal)
        button.addTarget(self, action: #selector(dismissBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let firstFanBtn : UIButton = {
        let button = UIButton()
        button.setTitle("20K FOLLWERS", for: .normal)
        button.backgroundColor = .systemPurple
        button.cornerRadius = 4
        button.tag = 1
       button.titleLabel?.font = UIFont(name: "Gilroy-Medium", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    
    let SecondFanBtn : UIButton = {
        let button = UIButton()
        button.setTitle("75K FOLLWERS", for: .normal)
        button.backgroundColor = .systemPurple
        button.cornerRadius = 4
        button.tag = 2
       button.titleLabel?.font = UIFont(name: "Gilroy-Medium", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    let thiredFanBtn : UIButton = {
        let button = UIButton()
        button.setTitle("350K FOLLWERS", for: .normal)
        button.backgroundColor = .systemPurple
        button.cornerRadius = 4
        button.tag = 3
        button.titleLabel?.font = UIFont(name: "Gilroy-Medium", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    
    let FourFanBtn : UIButton = {
        let button = UIButton()
        button.setTitle("1M FOLLWERS", for: .normal)
        button.backgroundColor = .systemPurple
        button.cornerRadius = 4
        button.tag = 4
        button.titleLabel?.font = UIFont(name: "Gilroy-Medium", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    let NextBtn : UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name: "Gilroy-Medium", size: 18)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(handelNext), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .black
        
        setupInputView()
    }
    
    
    @objc func dismissBtn (){
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func handleSignIn(sender : UIButton){
        switch sender.tag {
        case 1:
            print("1")
            UIView.animate(withDuration: 0.5) {
                sender.backgroundColor = UIColor.rgb(red: 21, green: 141, blue: 253)
            }
            
        case 2:
            print("2")
        case 3:
            print("3")
        case 4:
            print("4")
        default:
            print("non")
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func  setupInputView(){
        view.addSubview(backgroundImage)
        view.addSubview(BackButton)
        view.addSubview(MainLabel)
        
        NSLayoutConstraint.activate([
            // add constraint to BackGround Image
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        BackButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, padingTop: 20, padingBotton: 0, padingLeft: 20, padingRight: 0, width: 40, height: 40)
        MainLabel.anchor(top: BackButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 20, padingBotton: 0, padingLeft: 20, padingRight: -20, width: 0, height: 0)
        
        let stackView = UIStackView(arrangedSubviews:[firstFanBtn, SecondFanBtn,thiredFanBtn,FourFanBtn,NextBtn])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: MainLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 80, padingBotton: 0, padingLeft: 20, padingRight: -20, width: 0, height: 300)
    }
    @objc func handelSignUp(){
        let signUp = SignUpVC()
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    @objc func handelNext(){
         print("done")
    }
    
}



