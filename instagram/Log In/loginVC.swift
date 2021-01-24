//
//  loginVC.swift
//  instagram
//
//  Created by youssef on 7/1/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase

class LogInVC : UIViewController {
    
    lazy var backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "prof4")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    
    lazy var MainLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Gilroy-Regular", size: 25)
        lable.text = "WELCOME BACK"
        lable.textColor = .white
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var subLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Gilroy-Light", size: 20)
        lable.text = "LOG INTO YOUR ACOUNT"
        lable.textColor = .white
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
    
    
    let SignUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        let attrbiutedTitle = NSMutableAttributedString(string: "Do not have account? ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.white])
        attrbiutedTitle.append(NSAttributedString(string: "SignUp", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.systemPink]))
        button.setAttributedTitle(attrbiutedTitle, for: .normal)
        button.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
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

    let passwordTextField : TextField = {
           let tf = TextField()
           tf.placeholder = "Password"
           tf.translatesAutoresizingMaskIntoConstraints = false
           tf.isSecureTextEntry = true
           tf.backgroundColor = UIColor.rgb(red: 18, green: 18, blue: 18)
           tf.cornerRadius = 25
           tf.textColor = .white
           tf.font = UIFont.systemFont(ofSize: 18)
           tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
           return tf
       }()
    
    let signUpButton : UIButton = {
          let button = UIButton()
            button.setTitle("SIGN IN", for: .normal)
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
    
    
    @objc func dismissBtn (){
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func handleSignIn(){
        
        guard let email = emailTextField.text,!email.isEmpty,let password = passwordTextField.text,!password.isEmpty else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let  err = error{
                print(err)
                return
            }
            
            guard let mainTab = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else{
                return
            }
            mainTab.setupViewController()
            self.dismiss(animated: true, completion: nil)
            
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
        setupSignUpButton()
        
        NSLayoutConstraint.activate([
            // add constraint to BackGround Image
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        BackButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, padingTop: 20, padingBotton: 0, padingLeft: 20, padingRight: 0, width: 40, height: 40)
        MainLabel.anchor(top: BackButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 20, padingBotton: 0, padingLeft: 40, padingRight: -20, width: 0, height: 0)
        
        subLabel.anchor(top: MainLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 20, padingBotton: 0, padingLeft: 40, padingRight: -20, width: 0, height: 0)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.anchor(top: subLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 40, padingBotton: 0, padingLeft: 20, padingRight: -20, width: 0, height: 200)
    }
    @objc func handelSignUp(){
        let signUp = SignUpVC()
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    func setupSignUpButton(){
        view.addSubview(SignUpButton)
        SignUpButton.anchor(top: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, padingTop: 0, padingBotton: -20, padingLeft: 0, padingRight: 0, width: 0, height: 50)
    }
}

