//
//  SignupViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/6/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var signupButtonBottomConstraint: NSLayoutConstraint!
    
    private var isTextFieldSelected = false
    private var isKeyBoardShown = false

    override func viewDidLoad() {
        super.viewDidLoad()

        addKeyboardDismissToTapView();
        registerForNotification()
        initializeAppSettings ()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupAction(_ sender: Any) {
        dismissKeyboard()
        Util.displayActivityIndicator()
        
        let manager = SignupManager()
        manager.signupWith(email: emailTextField.text!.trimmingCharacters(in: .whitespaces),
                           password: passwordTextField.text!.trimmingCharacters(in: .whitespaces),
                           onCompletion: { (success, error) in
                            
                            Util.removeActivityIndicator()
                            
                            if error == nil {
                                self.showDetailViewController(UIStoryboard.loadTabBarViewController(), sender: nil)
                            }
        })
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
    
    // MARK:
    
    func initializeAppSettings() {
        signupButton.setTitleColor(UIColor.lightGray, for: .disabled)
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor.flatSkyBlue.cgColor
        signupButton.layer.cornerRadius = 5
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
        signupButton.isEnabled = !isTextFieldsEmpty() && isPasswordMatch()
    }
    
    func isTextFieldsEmpty() -> Bool {
        return emailTextField.text!.count == 0 || passwordTextField.text!.count == 0 || confirmPasswordTextField.text!.count == 0
    }
    
    func isPasswordMatch() -> Bool {
        return confirmPasswordTextField.text == passwordTextField.text
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
            signupButtonBottomConstraint.constant += keyBoardHeightFromNotification(notification: notification)
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
            signupButtonBottomConstraint.constant -= keyBoardHeightFromNotification(notification: notification)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
