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

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let signinManager = SigninManager()
        signinManager.signinWithGoogle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        if (error != nil) {
            return
        }
        
        showDetailViewController(UIStoryboard.loadTabBarViewController(), sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
