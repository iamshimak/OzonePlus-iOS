//
//  SignInViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/19/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import GoogleSignIn
import ChameleonFramework

class LoginViewController: UIViewController, UITextFieldDelegate, UIActionSheetDelegate, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var shrinkableLogoView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var shrinkableLogoViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextFieldToLogoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signupButtomBottomConstraint: NSLayoutConstraint!
    
    private var isTextFieldSelected = false
    private var isKeyBoardShown = false
    private var signInCredentials: NSDictionary!
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardDismissToTapView();
        registerForNotification()
        initializeAppSettings ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // from iOS 9 it removes observers automatically
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addKeyboardDismissToTapView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap);
    }
    
    func registerForNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        dismissKeyboard()

        let user = SigninManager.SigninUser(username: emailTextField.text!, password: passwordTextField.text!)
        
        Util.displayActivityIndicator()
        
        let signinManager = SigninManager()
        
        signinManager.signinUser(signinUser: user) { (res, error) in
            
            Util.removeActivityIndicator()
            
            if let error = error {
                
            } else {
                self.showDetailViewController(UIStoryboard.loadTabBarViewController(), sender: nil)
            }
        }
        
    }
    
    @IBAction func signupAction(_ sender: Any) {
        dismissKeyboard()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        NSLog("%@", user.profile)
    }
    
    // Finished disconnecting |user| from the app successfully if |error| is |nil|.
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    // MARK: - TextField Delegates
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isTextFieldSelected = true
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        changeButtonState()
        isTextFieldSelected = false
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isTextFieldSelected = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        changeButtonState()
        isTextFieldSelected = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        changeButtonState()
        return true
    }
    
    func changeButtonState() {
        loginButton.isEnabled = !isTextFieldsEmpty()
    }
    
    func isTextFieldsEmpty() -> Bool {
        return emailTextField.text!.characters.count == 0 || passwordTextField.text!.characters.count == 0
    }
    
    // MARK: - Keyboard Notification
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func unbindFromKeyboard(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        isKeyBoardShown = true
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        isKeyBoardShown = false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let tempIsKeyBoardShown = isKeyBoardShown
        
        if !tempIsKeyBoardShown {
            shrinkableLogoViewHeightConstraint.constant -= 100;
            signupButtomBottomConstraint.constant += keyBoardHeightFromNotification(notification: notification)
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            if !tempIsKeyBoardShown {
                self.view.layoutIfNeeded()
            }
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let tempIsKeyBoardShown = isKeyBoardShown
        
        if tempIsKeyBoardShown {
            shrinkableLogoViewHeightConstraint.constant += 100;
            signupButtomBottomConstraint.constant -= keyBoardHeightFromNotification(notification: notification)
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            if tempIsKeyBoardShown {
                self.view.layoutIfNeeded()
            }
        })
    }
    
    func keyBoardHeightFromNotification(notification: NSNotification) -> CGFloat {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            return keyboardFrame.cgRectValue.height
        } else {
            return 216.0
        }
    }
    
    func initializeAppSettings () {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        loginButton.setTitleColor(UIColor.lightGray, for: .disabled)
        loginButton.layer.cornerRadius = 5
        
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.flatSkyBlue.cgColor
        signUpButton.layer.cornerRadius = 5
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let controller = segue.destination as? SigninOptionTableViewController {
            slideInTransitioningDelegate.direction = .bottom
            controller.transitioningDelegate = slideInTransitioningDelegate
            controller.modalPresentationStyle = .custom
        }
    }
}
