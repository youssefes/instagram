//
//  chooseWorld.swift
//  instagram
//
//  Created by youssef on 3/6/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit
import Firebase

class ChooseWorld : UIViewController {
    
    lazy var backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Sign-up-3")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    
    lazy var MainLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Gilroy-Bold", size: 30)
        let attributedString = NSMutableAttributedString(string: "CHOOSE YOUR WORLD")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        lable.attributedText = attributedString
        lable.textColor = .white
        lable.numberOfLines = 2
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var BackButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Arrow   Left 2"), for: .normal)
        button.addTarget(self, action: #selector(dismissBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let HaveAFun : UIButton = {
        let button = UIButton()
        button.setTitle("HAVE FANS", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 21, green: 141, blue: 253)
        button.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(haveAFun), for: .touchUpInside)
        return button
    }()
    
    
    let BeFunBtn : UIButton = {
        let button = UIButton()
        button.setTitle("BE A FAN", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 21, green: 141, blue: 253)
        button.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20  )
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(beFunBtn), for: .touchUpInside)
        return button
    }()
    
    @objc func haveAFun(){
        let follwers = Follwers()
        self.navigationController?.pushViewController(follwers, animated: true)
    }
    
    
    @objc func beFunBtn(){
        let mainTab = MainTabBarController()
        self.navigationController?.pushViewController(mainTab, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .black
        
        setupInputView()
    }
    
    
    @objc func dismissBtn (){
        
        navigationController?.popViewController(animated: true)
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
        MainLabel.anchor(top: BackButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 50, padingBotton: 0, padingLeft: 40, padingRight: -20, width: 0, height: 0)
        
        let stackView = UIStackView(arrangedSubviews:[BeFunBtn, HaveAFun])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 40
        view.addSubview(stackView)
        stackView.anchor(top: MainLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 40, padingBotton: 0, padingLeft: 20, padingRight: -20, width: 0, height: 140)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func handelSignUp(){
        let signUp = SignUpVC()
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
}


