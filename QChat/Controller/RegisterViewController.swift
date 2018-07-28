//
//  RegisterViewController.swift
//  QChat
//
//  Created by Vigneshraj Sekar Babu on 7/25/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordReentryTextField: UITextField!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var acceptedTerms : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.isEnabled = false
        registerButton.backgroundColor = customButtonDisabledBG
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       // clearTextFields()
    }
    
    @IBAction func checkboxTapped(_ sender: UIButton) {
        acceptedTerms = !acceptedTerms
        checkboxButton.setImage(setAcceptedTerms(forstate: acceptedTerms), for: .normal)
    }
    
    @IBAction func register(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let passwordReentry = passwordReentryTextField.text else { return }
        
        dimissKeyboard()
        
        if email.isEmail && !password.isEmpty && !passwordReentry.isEmpty && password == passwordReentry && password.count > 5  {
            registerUser(email: email, password: password)
        }
        else if email.isEmail && password != passwordReentry {
            Alert.showPasswordMismatchAlert(on: self)
        }
        else if email.isEmail && password.count < 6 {
            Alert.showPasswordLengthInsufficientAlert(on: self)
        }
        else {
            Alert.showIncompleteLoginInfoAlert(on: self)
        }
        
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let auth = authResult else {
                Alert.showRegistrationUnsuccessfulAlert(on: self)
                return
            }
            //LOGGED IN
            print(auth)
            Alert.showRegistrationSuccessAlert(on: self, sender: auth.user.uid)
            self.clearTextFields()
        }
    }
    
    @IBAction func backToSignIn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        dimissKeyboard()
    }
    
    func dimissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setAcceptedTerms(forstate state : Bool) -> UIImage {
        registerButton.isEnabled = state
        registerButton.backgroundColor = state ? customButtonActiveBG : customButtonDisabledBG
        guard  let image = state ? UIImage(named: "checkbox_ticked") : UIImage(named: "checkbox_unticked")  else {fatalError("Images not found")}
        return image
    }
    
    func clearTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        passwordReentryTextField.text = ""
        acceptedTerms = false
        checkboxButton.setImage(setAcceptedTerms(forstate: acceptedTerms), for: .normal)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segue_CreateProfileIdentifier {
            if let profileSetupVC = segue.destination as? ProfileSetupViewController {
                guard let userID = sender as? String else { fatalError("user id is not string")}
                profileSetupVC.userID = userID
            }
        }
    }
    
    
}
