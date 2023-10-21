//
//  RegisterationController.swift
//  instaCloneFirestore
//
//  Created by Ashish Jain on 27/08/23.
//

import UIKit

class Registrationcontroller:UIViewController{
    
    // MARK: - properties
    
    private var viewModel = RegistrationViewModel()
    
    private let plusPhotoButton:UIButton={
       
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(photoAddButtonPressed), for: .touchUpInside)
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
        configureNotificationObservers()
    }
    
    // MARK: - Action
    
    @objc func handleAlreadyHaveAccount(){
        print("Already have account")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender:UITextField){
        print("Debug: Text did change")
        if sender == emailTextFied{
            print("Inside Email")
            viewModel.email = sender.text
        }else if sender == passwordTextFied{
            viewModel.password = sender.text
            print("Inside Password")
        }else if sender == fullNameTextFied{
            viewModel.fullname = sender.text
        }
        else if sender == userNameTextFied{
            viewModel.username = sender.text
        }
        updateForm()
    }
    
    @objc func photoAddButtonPressed(){
        print("Debug: show photo add button pressed")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
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
    
    func configureNotificationObservers(){
        
        emailTextFied.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextFied.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextFied.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextFied.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}

// MARK: - form view model

extension Registrationcontroller:formViewMode{
    func updateForm() {
        signupButton.backgroundColor = viewModel.buttonBackgroundColor
        signupButton.setTitleColor(viewModel.buttonTintColor, for: .normal)
        signupButton.isEnabled = viewModel.formIsValid
    }
    
    
}


// MARK: - UIImagepickerDelegate
extension Registrationcontroller:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("")
        
        guard let selectedImage = info[.editedImage] as? UIImage else{return}
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true)
    }
    
}
