//
//  SigninOptionTableViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/30/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import GoogleSignIn

class SigninOptionTableViewController: UITableViewController, GIDSignInUIDelegate, UIViewControllerTransitioningDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        //GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "googleSigninCell", for: indexPath)
            
            let signinButton = cell.viewWithTag(100) as! UIButton
            signinButton.addTarget(self, action: #selector(googleSigninAction), for: .touchUpInside)
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customSigninCell", for: indexPath)
            
            let signinButton = cell.viewWithTag(100) as! UIButton
            signinButton.addTarget(self, action: #selector(emailSigninAction), for: .touchUpInside)
            
            return cell
            
        } else if indexPath.row == 2 {
            return tableView.dequeueReusableCell(withIdentifier: "facebookSigninCell", for: indexPath)
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "termsOfUseCell", for: indexPath)
        }
    }
    
    @objc func googleSigninAction(sender: UIButton) {
        performSegue(withIdentifier: "displaySafariBackground", sender: self)
    }
    
    @objc func emailSigninAction(sender: UIButton) {
        performSegue(withIdentifier: "showEmailSignup", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
}
