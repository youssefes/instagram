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
    
    let logocontainerView : UIView = {
        let view = UIView()
        
        let imageView = UIImageView(image: UIImage(named: "insta"))
        view.addSubview(imageView)
        imageView.anchor(top: nil, bottom: nil, left: nil, right: nil, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 200, height: 50)
        imageView.contentMode = .scaleAspectFill
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.rgb(red: 253, green: 136, blue: 6)
        return view
    }()
    let SignUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        let attrbiutedTitle = NSMutableAttributedString(string: "Do not have account? ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        attrbiutedTitle.append(NSAttributedString(string: "SignUp", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 253, green: 136, blue: 6)]))
        button.setAttributedTitle(attrbiutedTitle, for: .normal)
        button.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
        return button
    }()
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
       tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
        return tf
    }()

    let passwordTextField : UITextField = {
           let tf = UITextField()
           tf.placeholder = "password"
           tf.translatesAutoresizingMaskIntoConstraints = false
           tf.borderStyle = .roundedRect
           tf.isSecureTextEntry = true
           tf.font = UIFont.systemFont(ofSize: 14)
           tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
           tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
           return tf
       }()
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("log in", for: .normal)
        button.backgroundColor = UIColor(red: 253/55, green: 136/255, blue: 6/255, alpha: 0.7)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(logocontainerView)
        logocontainerView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 0, height: 150)
        setupSignUpButton()
        setupInputView()
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
        self.signUpButton.backgroundColor = UIColor(red: 253/55, green: 136/255, blue: 6/255, alpha: 0.7)
        guard let email = emailTextField.text,!email.isEmpty,let password = passwordTextField.text,!password.isEmpty else {
            return
        }
        self.signUpButton.backgroundColor = UIColor.rgb(red: 253, green: 136, blue: 6)
        self.signUpButton.isEnabled = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func  setupInputView(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: logocontainerView.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 40, padingBotton: 0, padingLeft: 40, padingRight: -40, width: 0, height: 200)
    }
    @objc func handelSignUp(){
        let signUp = SignUpVC()
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    func setupSignUpButton(){
        view.addSubview(SignUpButton)
        SignUpButton.anchor(top: nil, bottom: self.view.bottomAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, padingTop: 0, padingBotton: -20, padingLeft: 0, padingRight: 0, width: 0, height: 50)
    }
}

