//
//  Alert.swift
//  QChat
//
//  Created by Vigneshraj Sekar Babu on 7/25/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
   
    
    private static func showAlert(on vc: UIViewController, title: String, alertMessage: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            //do nothing
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    private static func showAlertAndDismissController(on vc: UIViewController, title: String, alertMessage: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            vc.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    private static func showAlertAndDismissTwoControllers(on vc: UIViewController, title: String, alertMessage: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            vc.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
           
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    private static func showAlertAndPresentViewController(on vc: UIViewController, title: String, alertMessage: String, actionTitle: String, to identifier: String, sender uid: String) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            vc.performSegue(withIdentifier: identifier, sender: uid)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    static func showIncompleteLoginInfoAlert(on vc: UIViewController){
        showAlert(on: vc, title: "Incomplete Login info", alertMessage: "Enter valid Email and password", actionTitle: "Retry")
    }
    
    static func showPasswordMismatchAlert(on vc: UIViewController){
        showAlert(on: vc, title: "Re-enter passwords", alertMessage: "Passwords entered does not match", actionTitle: "Retry")
    }
    
    static func showPasswordLengthInsufficientAlert(on vc: UIViewController){
        showAlert(on: vc, title: "Password Length", alertMessage: "Password should be atleast 6 characters", actionTitle: "Retry")
    }
    
    static func showUserDoesNotExistAlert(on vc: UIViewController){
        showAlert(on: vc, title: "Failed Sign in", alertMessage: "No Existing user found with this email and password combination", actionTitle: "Try Again")
        
    }
    
    static func showRegistrationSuccessAlert(on vc: UIViewController, sender uid: String){
        //showAlertAndDismissController(on: vc, title: "Registered", alertMessage: "You've succesfully registered, Ready to meet users?", actionTitle: "Yes")
        showAlertAndPresentViewController(on: vc, title: "Signed up!", alertMessage: "Successfully registered. Now let's create your profile", actionTitle: "Yes", to: segue_CreateProfileIdentifier, sender: uid)
    }
    
    static func showRegistrationUnsuccessfulAlert(on vc: UIViewController){
        showAlert(on: vc, title: "Registration Failed", alertMessage: "Registration not complete. Check your network connection", actionTitle: "OK")
    }
    
    static func showIncompleteFormAlert(on vc: UIViewController){
        showAlert(on: vc, title: "Incomplete Form", alertMessage: "Please fill all the fields", actionTitle: "OK")
    }
    
    static func showProfileCreationSuccessAlert(on vc: UIViewController){
        showAlertAndDismissTwoControllers(on: vc, title: "Profile Created", alertMessage: "All set to start chatting!", actionTitle: "Done")
    }
    
    static func showErrorAlert(on vc: UIViewController, errorMessage: String) {
        showAlert(on: vc, title: "Error", alertMessage: errorMessage, actionTitle: "OK")
    }
    
}
