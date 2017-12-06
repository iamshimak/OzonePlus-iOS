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
    
    public var isUserSignedIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isUserAuthenticated
    }
     */
}
