//
//  SignViewController.swift
//  Design_to_code10
//
//  Created by youssef on 1/23/21.
//  Copyright © 2021 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {
    
    lazy var backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Sign-up-3")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    lazy var MainLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: Font.Bold.name, size: 40)
        let attributedString = NSMutableAttributedString(string: "MANIFEST YOUR DREAM WORLD")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        lable.attributedText = attributedString
        lable.textColor = .systemBackground
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 4
        return lable
    }()
    
    lazy var SubLabel : UILabel = {
        let lable = UILabel()
        lable.font =  UIFont(name: Font.Medium.name, size: 20)
       let attributedString = NSMutableAttributedString(string: "WITH MILLION OF USERS ALL OVER THE WORLD LOFTPOP GIVES YOU REAL FREEDOM LIVE HOW YOU WANT BE WHO YOU WANT")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        lable.attributedText = attributedString
        lable.textColor = .systemBackground
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        return lable
    }()
    
   
    
    lazy var buttonLogin : UIButton = {
        let button = GFButton(backgroundColor: UIColor.systemBackground, title: "LOG IN")
        button.setTitleColor(.systemPink, for: .normal)
        button.addTarget(self, action: #selector(handleSignInBtn), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSignInBtn(){
        let login = LogInVC()
        login.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(login, animated: true)
    }
    
    @objc func handleSignUpBtn(){
        let SignVC = SignUpVC()
        SignVC.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(SignVC, animated: true)
    }
    
    lazy var buttonSignUp : UIButton = {
        let button = GFButton(backgroundColor: UIColor.systemPink, title: "SIGN UP")
        button.addTarget(self, action: #selector(handleSignUpBtn), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    lazy var faceBook : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "28"), for: .normal)
        button.contentHorizontalAlignment = .trailing
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    
    
    lazy var Twitter : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "29"), for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    
    
    lazy var stackView : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [buttonLogin,buttonSignUp])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    
    
    lazy var buttomLabel : UILabel = {
        let lable = UILabel()
        lable.text = "OR LOG IN WITH "
        lable.font = DesignSystem.Typography.SubLable.font
        lable.textColor = .systemBackground
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        return lable
    }()
    
    
    lazy var MediastackView : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [faceBook,Twitter])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
       

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUpUI() {
        view.addSubview(backgroundImage)
        view.addSubview(MainLabel)
        view.addSubview(SubLabel)
        view.addSubview(stackView)
        view.addSubview(buttomLabel)
        view.addSubview(MediastackView)
        
        NSLayoutConstraint.activate([
            // add constraint to BackGround Image
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // add  constraint to main Lable
            MainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            MainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            MainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:  (-(view.frame.width / 2)
                + 20)),
            
            SubLabel.topAnchor.constraint(equalTo: MainLabel.bottomAnchor,constant: 20),
            SubLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            SubLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // add constraint to stackButton
            stackView.topAnchor.constraint(equalTo: SubLabel.bottomAnchor,constant: 40),
            stackView.leadingAnchor.constraint(equalTo: SubLabel.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: SubLabel.trailingAnchor),
            
            
            // add  constraint to main Lable
            buttomLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
            buttomLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,constant: 20),
            buttomLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: -20),
            
            // add constraint to stackButton
                 MediastackView.topAnchor.constraint(equalTo: buttomLabel.bottomAnchor,constant: 20),
                 MediastackView.leadingAnchor.constraint(equalTo: buttomLabel.leadingAnchor),
                 MediastackView.trailingAnchor.constraint(equalTo: buttomLabel.trailingAnchor),
            
            
        ])
    }

}
