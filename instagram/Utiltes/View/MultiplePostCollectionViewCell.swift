//
//  MultiplePostCollectionViewCell.swift
//  Design_to_code10
//
//  Created by Dheeraj Kumar Sharma on 04/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class MultiplePostCollectionViewCell: UICollectionViewCell {
    
    let imgArr = ["img1" , "img2", "img3"]
    
    let profilePicture:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "prof-img2")
        img.clipsToBounds = true
        img.layer.cornerRadius = 22.5
        return img
    }()
    
    let userName:UILabel = {
        let l = UILabel()
        l.text = "Sammy"
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let optionsBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(named: "options")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = .lightGray
        return btn
    }()
    
    //MARK:- Multiple Post Collection
    
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(PostImageCollectionViewCell.self, forCellWithReuseIdentifier: "PostImageCollectionViewCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.setCollectionViewLayout(layout, animated: false)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let stackView1:UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 5
        return sv
    }()
    
    //MARK:- Like view
    let likeView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let likeBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named:"heart"), for: .normal)
        return btn
    }()
    
    let likeLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "300+"
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return l
    }()
    
    //MARK:- Comment view
    let commentView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let commentBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named:"comment"), for: .normal)
        return btn
    }()
    
    let commentLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "100+"
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return l
    }()
    
    let stackView2:UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 5
        return sv
    }()
    
    let saveBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named:"save"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let shareBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named:"share"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let pageControl:UIPageControl = {
        let pg = UIPageControl()
        pg.translatesAutoresizingMaskIntoConstraints = false
        pg.currentPageIndicatorTintColor = .darkGray
        pg.pageIndicatorTintColor = CustomColor.appLightGray
        pg.currentPage = 0
        return pg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profilePicture)
        addSubview(userName)
        addSubview(optionsBtn)
        addSubview(collectionView)
        addSubview(stackView1)
        addSubview(pageControl)
        stackView1.addArrangedSubview(likeView)
        likeView.addSubview(likeBtn)
        likeView.addSubview(likeLabel)
        stackView1.addArrangedSubview(commentView)
        commentView.addSubview(commentBtn)
        commentView.addSubview(commentLabel)
        addSubview(stackView2)
        stackView2.addArrangedSubview(shareBtn)
        stackView2.addArrangedSubview(saveBtn)
        setUpConstraints()
        pageControl.numberOfPages = imgArr.count
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            profilePicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            profilePicture.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            profilePicture.widthAnchor.constraint(equalToConstant: 45),
            profilePicture.heightAnchor.constraint(equalToConstant: 45),
            
            userName.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 10),
            userName.topAnchor.constraint(equalTo: topAnchor, constant: 34),
            
            optionsBtn.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            optionsBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            optionsBtn.widthAnchor.constraint(equalToConstant: 45),
            optionsBtn.heightAnchor.constraint(equalToConstant: 45),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: stackView1.topAnchor, constant: -20),
            
            stackView1.leadingAnchor.constraint(equalTo: leadingAnchor ,constant: 40),
            stackView1.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant:20),
            stackView1.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-20),
            stackView1.widthAnchor.constraint(equalToConstant: 180),
            stackView1.heightAnchor.constraint(equalToConstant: 30),
            
            likeBtn.leadingAnchor.constraint(equalTo: likeView.leadingAnchor),
            likeBtn.centerYAnchor.constraint(equalTo: likeView.centerYAnchor),
            likeBtn.widthAnchor.constraint(equalToConstant: 40),
            likeBtn.heightAnchor.constraint(equalToConstant: 40),
            
            likeLabel.leadingAnchor.constraint(equalTo: likeBtn.trailingAnchor, constant: 5),
            likeLabel.centerYAnchor.constraint(equalTo: likeView.centerYAnchor),
            likeLabel.trailingAnchor.constraint(equalTo: likeView.trailingAnchor, constant: 2),
            
            commentBtn.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            commentBtn.centerYAnchor.constraint(equalTo: commentView.centerYAnchor),
            commentBtn.widthAnchor.constraint(equalToConstant: 40),
            commentBtn.heightAnchor.constraint(equalToConstant: 40),
            
            commentLabel.leadingAnchor.constraint(equalTo: commentBtn.trailingAnchor, constant: 5),
            commentLabel.centerYAnchor.constraint(equalTo: commentView.centerYAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor, constant: 2),
            
            stackView2.trailingAnchor.constraint(equalTo: trailingAnchor ,constant: -30),
            stackView2.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant:20),
            stackView2.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-20),
            stackView2.widthAnchor.constraint(equalToConstant: 100),
            stackView2.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / collectionView.frame.width)
    }
}

extension MultiplePostCollectionViewCell:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostImageCollectionViewCell", for: indexPath) as! PostImageCollectionViewCell
        cell.imagePreview.image = UIImage(named: imgArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
