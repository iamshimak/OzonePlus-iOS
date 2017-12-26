//
//  SafariBackGroundViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/5/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import GoogleSignIn

class SafariBackGroundViewController: UIViewController, GIDSignInUIDelegate {
    
    private var isUserSignedIn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GIDSignIn.sharedInstance().uiDelegate = self
        (SigninManager()).signinWithGoogle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        if error == nil {
            isUserSignedIn = true
            self.showDetailViewController(UIStoryboard.loadTabBarViewController(), sender: nil)
        }
    }
}
