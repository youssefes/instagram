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
    
    var FollowerCountChoose : Int?
    lazy var backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Sign-up-3")
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func dismissBtn (){
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func handleSignIn(sender : UIButton){
        switch sender.tag {
        case 1:
            following()
            FollowerCountChoose = 250000
            print("1")
        case 2:
             following()
             FollowerCountChoose = 350000
        case 3:
             following()
             FollowerCountChoose = 750000
        case 4:
             following()
             FollowerCountChoose = 1000000
        default:
             following()
             FollowerCountChoose = 250
        
        }
        
    }
    
    func following(){
        guard let currentLogginUser = Auth.auth().currentUser?.uid else{return}
        let ref = Database.database().reference().child("Following").child(currentLogginUser)
        Database.database().reference().child("users").observe(.value, with: { (snapchat) in
            let value = snapchat.value as? [String : Any]
            value?.forEach({ (key , value) in
                let values = [key : 1]
                ref.updateChildValues(values) { (error, ref) in
                    if let err = error {
                        print(err)
                        return
                    }else{
                        
                    }
                }
            })
        }) { (error) in
            print(error)
        }
        let maintab = MainTabBarController()
        self.navigationController?.pushViewController(maintab, animated: true)
    }
    
    
    func setUpUNFollowStyle(sender : UIButton) {
        UIView.animate(withDuration: 0.5) {
            sender.backgroundColor = UIColor.rgb(red: 21, green: 141, blue: 253)
        }
        print("non")
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



