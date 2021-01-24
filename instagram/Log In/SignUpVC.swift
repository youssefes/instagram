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
    
    
    lazy var backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "prof4")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let plusPhotoButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "prof-img1"), for: .normal)
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handelphotoButton), for: .touchUpInside)
        return button
    }()
    
    lazy var MainLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Gilroy-Regular", size: 25)
        lable.text = "CREATE AN ACCOUNT"
        lable.textColor = .white
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
    
    let emailTextField : TextField = {
        let tf = TextField()
        tf.placeholder = "Email"
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = .white
        tf.backgroundColor = UIColor.rgb(red: 18, green: 18, blue: 18)
        tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField : TextField = {
        let tf = TextField()
        tf.placeholder = "username"
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.backgroundColor = UIColor.rgb(red: 18, green: 18, blue: 18)
        tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
        return tf
    }()
    let passwordTextField : TextField = {
        let tf = TextField()
        tf.placeholder = "password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor.rgb(red: 18, green: 18, blue: 18)
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
        return tf
    }()
    
    
    let PhoneTextField : TextField = {
        let tf = TextField()
        tf.placeholder = "Phone"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.backgroundColor = UIColor.rgb(red: 18, green: 18, blue: 18)
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
        return tf
    }()
    
    let DataOfPrithTextField : TextField = {
        let tf = TextField()
        tf.placeholder = "Date"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.rgb(red: 18, green: 18, blue: 18)
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = .white
        tf.addTarget(self, action: #selector(handelTextFieldChange), for: .editingChanged)
        return tf
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("sign Up", for: .normal)
        button.backgroundColor = .systemPink
        button.cornerRadius = 25
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        return button
    }()
    
    lazy var AcceeptTerms : UILabel = {
         let lable = UILabel()
         lable.font =  UIFont(name: "Gilroy-Medium", size: 12)
         let attributedString = NSMutableAttributedString(string: "BY CLICKING SIGN UP YOU AGRREE TO THE FOLLOWING TERMS AND CONDITIONS WITHOUT RESERVATION")
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
        view.addSubview(plusPhotoButton)
        view.addSubview(AcceeptTerms)
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
//        self.signUpButton.backgroundColor = UIColor(red: 253/55, green: 136/255, blue: 6/255, alpha: 0.7)
//        guard let email = emailTextField.text,!email.isEmpty,let username = usernameTextField.text,!username.isEmpty,let password = passwordTextField.text,!password.isEmpty else {
//            return
//        }
//        self.signUpButton.backgroundColor = UIColor.rgb(red: 253, green: 136, blue: 6)
//        self.signUpButton.isEnabled = true
        
    }
    
    @objc func handleSignUp(){
        
        guard let email = emailTextField.text,!email.isEmpty,let username = usernameTextField.text,!username.isEmpty,let password = passwordTextField.text,!password.isEmpty,let phone = PhoneTextField.text,!phone.isEmpty, let date = DataOfPrithTextField.text, !date.isEmpty else {
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
                    ref.child("users").child(user.uid).updateChildValues(["username" : username, "phone" : phone, "date" : date ,"profileURL" : downloadUrl])
                    
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
        
        NSLayoutConstraint.activate([
            // add constraint to BackGround Image
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
        BackButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, padingTop: 20, padingBotton: 0, padingLeft: 20, padingRight: 0, width: 40, height: 40)
        MainLabel.anchor(top: BackButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 20, padingBotton: 0, padingLeft: 40, padingRight: -20, width: 0, height: 0)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.anchor(top: MainLabel.bottomAnchor, bottom: nil, left: nil, right: nil, padingTop: 20, padingBotton: 0, padingLeft: 0, padingRight: 0, width: 100, height: 100)
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField,emailTextField,PhoneTextField,DataOfPrithTextField,passwordTextField,signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, padingTop: 40, padingBotton: 0, padingLeft: 20, padingRight: -20, width: 0, height: 340)
       
        AcceeptTerms.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor , right: view.rightAnchor, padingTop: 0, padingBotton: 0, padingLeft: 20, padingRight: -20, width: 0, height: 0)
        
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



