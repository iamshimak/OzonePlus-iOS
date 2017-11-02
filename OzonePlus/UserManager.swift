//
//  UserManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/30/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import GoogleSignIn

class UserManager: NSObject {
    
    static let sharedInstance = UserManager()
    
    private var user : User
    
    private override init() {
        self.user = User.init()
    }
    
    func updateFrom(googleUser: GIDProfileData!) {
        user.lastName = googleUser.givenName
        user.firstName = googleUser.familyName
        user.fullName = googleUser.name
        user.email = googleUser.email
        user.profilePic = googleUser.imageURL(withDimension: 500)
    }
    
    func currentUser() -> User {
        return user
    }
}
