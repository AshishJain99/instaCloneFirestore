//
//  AuthenticationViewModel.swift
//  instaCloneFirestore
//
//  Created by Ashish Jain on 27/08/23.
//

import UIKit

protocol AuthenticationViewModel{
   
    var formIsValid:Bool { get }
    var buttonBackgroundColor:UIColor { get }
    var buttonTintColor:UIColor { get }
    
}

protocol formViewMode{
 func updateForm()
}

struct loginViewModel:AuthenticationViewModel{
    
    var email:String?
    var password:String?
    
    
    var formIsValid:Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor:UIColor{
        return formIsValid ? UIColor.systemPurple:UIColor.systemPurple.withAlphaComponent(0.5)
    }
    
    var buttonTintColor:UIColor{
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
}
struct RegistrationViewModel:AuthenticationViewModel{
    
    
    var email:String?
    var password:String?
    var fullname:String?
    var username:String?
    
    
    var formIsValid:Bool{
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor:UIColor{
        return formIsValid ? UIColor.systemPurple:UIColor.systemPurple.withAlphaComponent(0.5)
    }
    
    var buttonTintColor:UIColor{
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}
