//
//  UserManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/30/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class UserManager: NSObject {
    
    static let sharedInstance = UserManager()
    
    private var user : OZUser
    
    private override init() {
        self.user = OZUser.init()
    }
    
    func updateFrom(googleUser: GIDProfileData!) {
        user.lastName = googleUser.givenName
        user.firstName = googleUser.familyName
        user.fullName = googleUser.name
        user.email = googleUser.email
        user.profilePic = googleUser.imageURL(withDimension: 500)
    }
    
    func updateFrom(firUser: User!) {
        user.fullName = firUser.displayName
        user.email = firUser.email
        user.profilePic = firUser.photoURL
    }
    
    func currentUser() -> OZUser {
        return user
    }
}
