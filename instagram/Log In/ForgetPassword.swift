//
//  ForgetPassword.swift
//  instagram
//
//  Created by youssef on 3/6/18.
//  Copyright © 2018 youssef. All rights reserved.
//


import UIKit
import Firebase

class ForgetPassword : UIViewController {
    
    lazy var backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "prof4")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    
    lazy var MainLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Gilroy-Regular", size: 25)
        lable.text = "FORGOT PASSWORD"
        lable.textColor = .white
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var subLabel : UILabel = {
        let lable = UILabel()
        lable.font =  UIFont(name: "Gilroy-Regular", size: 18)
        let attributedString = NSMutableAttributedString(string: "PLEASE ENTER YOUR EMAIL ADDRESS YOU WILL RECEIVE A LINK TO CREATE A NEW PASSWORD")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        lable.attributedText = attributedString
        lable.textColor = .white
        lable.numberOfLines = 0
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
    
    
    let emailTextField : TextField = {
        let tf = TextField()
        tf.placeholder = "Email"
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = .white
        tf.backgroundColor = UIColor.rgb(red: 18, green: 18, blue: 18)
       tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
        return tf
    }()

    
    let signUpButton : UIButton = {
          let button = UIButton()
            button.setTitle("SEND", for: .normal)
            button.backgroundColor = .systemPink
            button.cornerRadius = 25
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
            return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .black
        
      
        setupInputView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: true)
       }
    
    @objc func dismissBtn (){
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func handleSignIn(){
        
        guard let email = emailTextField.text,!email.isEmpty else {
            return
        }
    }
    
    @objc func handelTextFieldChange(){
//        self.signUpButton.backgroundColor = UIColor(red: 253/55, green: 136/255, blue: 6/255, alpha: 0.7)
//        guard let email = emailTextField.text,!email.isEmpty,let password = passwordTextField.text,!password.isEmpty else {
//            return
//        }
//        self.signUpButton.backgroundColor = UIColor.rgb(red: 253, green: 136, blue: 6)
//        self.signUpButton.isEnabled = true
//
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func  setupInputView(){
        view.addSubview(backgroundImage)
        view.addSubview(BackButton)
        view.addSubview(MainLabel)
        view.addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            // add constraint to BackGround Image
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        BackButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, padingTop: 40, padingBotton: 0, padingLeft: 20, padingRight: 0, width: 40, height: 40)
        MainLabel.anchor(top: BackButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 50, padingBotton: 0, padingLeft: 40, padingRight: -20, width: 0, height: 0)
        
        subLabel.anchor(top: MainLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 20, padingBotton: 0, padingLeft: 40, padingRight: -20, width: 0, height: 0)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.anchor(top: subLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 50, padingBotton: 0, padingLeft: 20, padingRight: -20, width: 0, height: 120)
    }
    @objc func handelSignUp(){
        let signUp = SignUpVC()
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
}


