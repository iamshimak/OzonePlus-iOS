//
//  SignupManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/30/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import Firebase
import FirebaseAuth
import GoogleSignIn

enum SignupOption {
    case Google
    case Facebook
    case Email
}

class SignupManager: NSObject {
    
    struct SignupUser {
        var firstName: String
        var lastName: String
        var email: String
        var password: String
    }
    
    func signup(withOption: SignupOption) {
        
    }
    
    func signupWith(googleUser: GIDProfileData) {
        UserManager.sharedInstance.updateFrom(googleUser: googleUser)
    }
    
    func signupWith(signupUser: SignupUser, onCompletion:@escaping (_ : String?, _ : Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: signupUser.email, password: signupUser.password, completion: { user, error in
            
            if let user == user {
                
                let ref = Database.database().reference().child("users/\(user.uid)/")
                let values = ["firstName" : signupUser.firstName,
                              "lastName" : signupUser.lastName,
                              "givenName" : signupUser.firstName + signupUser.lastName]
                
                ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error == nil {
                        UserManager.sharedInstance.updateFrom(firUser: user)
                        onCompletion("Success", nil)
                    } else {
                        onCompletion(nil, error)
                    }
                })
                
            } else {
                onCompletion(nil, error)
            }
            
        })
        
    }
}
