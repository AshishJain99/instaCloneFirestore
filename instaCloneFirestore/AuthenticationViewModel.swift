//
//  AuthenticationViewModel.swift
//  instaCloneFirestore
//
//  Created by Ashish Jain on 27/08/23.
//

import Foundation

struct loginViewModel{
    
    var email:String?
    var password:String?
    
    
    var formIsValid:Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
}
struct RegistrationViewModel{
    
}
