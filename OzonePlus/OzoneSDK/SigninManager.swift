//
//  SigninManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/25/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import Firebase
import FirebaseAuth
import GoogleSignIn

class SigninManager: NSObject {
    
    struct SigninUser {
        var username : String
        var password : String
    }
    
    func signinUser(signinUser: SigninUser, onCompletion:@escaping AuthResultCallback) {
        Auth.auth().signIn(withEmail: signinUser.username, password: signinUser.password) { (user, error) in
            if let error = error {
                onCompletion(nil, error)
            } else {
                onCompletion(user?.refreshToken, nil)
            }
        }
    }
    
    func signinWithGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    typealias AuthResultCallback = (_ : String?, _ : Error?) -> Void
}
