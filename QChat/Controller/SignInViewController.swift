//
//  ViewController.swift
//  QChat
//
//  Created by Vigneshraj Sekar Babu on 7/24/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//
// Icones by <div>Icons made by <a href="https://www.flaticon.com/authors/pixel-buddha" title="Pixel Buddha">Pixel Buddha</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
//Thanks to Pixel Buddha. Check out his icons at https://www.flaticon.com/authors/pixel-buddha

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var userID : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func login(_ sender: UIButton) {
        dismissKeyboard()
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        if email.isEmail && !password.isEmpty {
           loginUser(email: email, password: password)
            if userID != nil {
                performSegue(withIdentifier: segue_SignInToHomeTab , sender: userID)
            } else {
                Alert.showUserDoesNotExistAlert(on: self)
            }
            
        } else {
            Alert.showIncompleteLoginInfoAlert(on: self)
        }
    }
    
    func loginUser(email: String, password: String)  {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let Autherror = error {
                Alert.showErrorAlert(on: self, errorMessage: Autherror.localizedDescription)
                return
            }
            if let user = user?.user {
                self.userID = user.uid
            }
            //logged in code
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        performSegue(withIdentifier: "registration", sender: self)
    }
    
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
     dismissKeyboard()
    }
    
    func dismissKeyboard() {
         self.view.endEditing(true)
    }
    
}

//MARK: - extending string to validate email Regex
// https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
extension String {
    var isEmail : Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with:self)
    }
}
