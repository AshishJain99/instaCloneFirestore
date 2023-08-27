//
//  RegisterationController.swift
//  instaCloneFirestore
//
//  Created by Ashish Jain on 27/08/23.
//

import UIKit

class Registrationcontroller:UIViewController{
    
    // MARK: - properties
    
    private let plusPhotoButton:UIButton={
       
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let emailTextFied:UITextField={
        let tf = customTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    private let passwordTextFied:UITextField={
        let tf = customTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let fullNameTextFied = customTextField(placeholder: "Full Name")
    private let userNameTextFied = customTextField(placeholder: "Username")
    
    private let signupButton:UIButton={
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemIndigo
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let alreadyHaveAccountButton:UIButton={
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have Account? ", secondPart: "Login ")
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Action
    
    @objc func handleAlreadyHaveAccount(){
        print("Already have account")
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper
    func configureUI(){
        
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextFied,passwordTextFied,fullNameTextFied,userNameTextFied,signupButton])

        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.anchor(top: plusPhotoButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 32,paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    
}

