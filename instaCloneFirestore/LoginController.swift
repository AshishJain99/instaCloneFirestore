//
//  LoginController.swift
//  instaCloneFirestore
//
//  Created by Ashish Jain on 27/08/23.
//

import UIKit

class Logincontroller:UIViewController{
    
    // MARK: - properties
    
    private let iconImage:UIImageView={
    let iv = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
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
    
    private let loginButton:UIButton={
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemIndigo
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let dontHaveAccountButton:UIButton={
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign up")
        button.addTarget(self, action: #selector(handleShowSignup), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton:UIButton={
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password? ", secondPart: "Get help signing in")
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Actions
    
    @objc func handleShowSignup(){
        print("Signup Button is working")
        
        let controller = Registrationcontroller()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextFied,passwordTextFied,loginButton,forgotPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(top: iconImage.bottomAnchor,left: view.leftAnchor,
                         right: view.rightAnchor,paddingLeft: 32,paddingRight: 32)
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    
}
