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
    
    func signup(withOption: SignupOption) {

    }
    
    func signupWith(googleUser: GIDProfileData) {
        UserManager.sharedInstance.updateFrom(googleUser: googleUser)
    }
}
