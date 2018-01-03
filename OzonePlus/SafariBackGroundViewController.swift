//
//  SafariBackGroundViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/5/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import GoogleSignIn

class SafariBackGroundViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    private var isUserSignedIn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        (SigninManager()).signinWithGoogle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        if error == nil {
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            isUserSignedIn = true
            let signupManager = SignupManager()
            signupManager.signupWith(googleUser: user.profile)
            
            self.showDetailViewController(UIStoryboard.loadTabBarViewController(), sender: nil)
        }
    }
}
