//
//  ViewController.swift
//  instagram
//
//  Created by youssef on 6/28/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import Firebase
class SignUpVC: UIViewController {
    
    let plusPhotoButton : UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "plusicon"), for: .normal)
        button.addTarget(self, action: #selector(handelphotoButton), for: .touchUpInside)
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
    
    let usernameTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "username"
        
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
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
        button.setTitle("sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 253/55, green: 136/255, blue: 6/255, alpha: 0.7)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        return button
    }()
    
    
    let DontHaveAccountButton : UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("", for: .normal)
        let attrbiutedTitle = NSMutableAttributedString(string: "Do not have account? ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.lightGray])
           attrbiutedTitle.append(NSAttributedString(string: "SignIn", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 253, green: 136, blue: 6)]))
           button.setAttributedTitle(attrbiutedTitle, for: .normal)
           button.addTarget(self, action: #selector(handelSignIn), for: .touchUpInside)
           return button
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.anchor(top: view.topAnchor, bottom: nil, left: nil, right: nil, padingTop: 100, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 140, height: 140)
        view.addSubview(DontHaveAccountButton)
        DontHaveAccountButton.anchor(top: nil, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, padingTop: 0, padingBotton: -20, padingLeft: 0, padingRight: 0, width: 0, height: 50)
        setupInputView()
    }
    
    @objc func handelSignIn (){
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handelphotoButton(){
        let imagepackerController = UIImagePickerController()
        imagepackerController.delegate = self
        imagepackerController.allowsEditing = true
        imagepackerController.sourceType = .photoLibrary
        present(imagepackerController, animated: true) {
            
        }
    }
    @objc func handelTextFieldChange(){
        self.signUpButton.backgroundColor = UIColor(red: 253/55, green: 136/255, blue: 6/255, alpha: 0.7)
        guard let email = emailTextField.text,!email.isEmpty,let username = usernameTextField.text,!username.isEmpty,let password = passwordTextField.text,!password.isEmpty else {
            return
        }
        self.signUpButton.backgroundColor = UIColor.rgb(red: 253, green: 136, blue: 6)
        self.signUpButton.isEnabled = true
        
    }
    
    @objc func handleSignUp(){
        
        guard let email = emailTextField.text,!email.isEmpty,let username = usernameTextField.text,!username.isEmpty,let password = passwordTextField.text,!password.isEmpty else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let err = error{
                print(err)
            }
            guard let user = user?.user else {
                return
            }
            guard  let image = self.plusPhotoButton.imageView?.image else{
                return
            }
            
            guard let uploadImage = image.jpegData(compressionQuality: 0.3) else{
                return
            }
            
            let storageRef = Storage.storage().reference()
            storageRef.child("profile_image").child(user.uid).putData(uploadImage, metadata: nil) { (metaData, error) in
                
                if let err = error{
                    print("error on upload image \(err)")
                }
                
                let imageRefrence = storageRef.child("profile_image").child(user.uid)
                imageRefrence.downloadURL(completion: { (url, error) in
                    guard let downloadUrl = url?.absoluteString else{
                        print("an error occured after uploading and then getting the")
                        return
                    }
                    
                    let ref = Database.database().reference()
                    ref.child("users").child(user.uid).updateChildValues(["username" : username,"profileURL" : downloadUrl])
                    
                    guard let mainTab = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else{
                        return
                    }
                    mainTab.setupViewController()
                    self.dismiss(animated: true, completion: nil)
                })
                
            }
            
            
            
        }
        
    }
    fileprivate func  setupInputView(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,usernameTextField,passwordTextField,signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 40, padingBotton: 0, padingLeft: 40, padingRight: -40, width: 0, height: 250)
    }
}

extension SignUpVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageOriginal = info[.originalImage] as? UIImage{
            self.plusPhotoButton.setImage(imageOriginal.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        if let imageEditing = info[.editedImage] as? UIImage{
            self.plusPhotoButton.setImage(imageEditing.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        
        dismiss(animated: true, completion: nil)
        
    }
}



