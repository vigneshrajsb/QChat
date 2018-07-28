//
//  ProfileSetupViewController.swift
//  QChat
//
//  Created by Vigneshraj Sekar Babu on 7/26/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore


class ProfileSetupViewController: UIViewController {
    
    var userID : String? = nil
    var userEmail: String = ""
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet var tapAvatarImage: UITapGestureRecognizer!
    
    @IBOutlet weak var profileViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileViewTopConstraint: NSLayoutConstraint!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(userID)
        let user = Auth.auth().currentUser
        if let user = user {
            if let email = user.email  {
                userEmail = email
            }
           // print(user.email)
           // print(user.displayName)
           // print(user.providerData)
        }
        
        avatarImageView.addGestureRecognizer(tapAvatarImage)

    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    

    
    @IBAction func setUpLaterButtonTapped(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func createProfileinFirebase(_ userID: String, _ dictionary: [String : Any]) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(qUsers).child(userID).setValue(dictionary)
    }
    
    @IBAction func createProfileTapped(_ sender: UIButton) {
        hideKeyboard()
        guard let userID = userID else { fatalError("User ID not found.") }
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let country = countryTextField.text, let city = cityTextField.text, let mobile = mobileTextField.text, let avatarImage = avatarImageView.image else {
            Alert.showIncompleteFormAlert(on: self)
            return
        }
        
        if !firstName.isEmpty && !lastName.isEmpty && !country.isEmpty && !city.isEmpty && !mobile.isEmpty && userEmail != "" {
      
        let dictionary  : [String: Any] = [qEmail: userEmail,
                                           qRegisteredDate : getCurrentTimeAsString(),
                                           qlastUpdatedDate : getCurrentTimeAsString(),
                                           qFirstName: firstName,
                                           qHasProfile : true ,
                                           qIsOnline : true,
                                           qLastName : lastName,
                                           qCity : city,
                                           qCountry : country,
                                           qMobile : mobile,
                                           qAvatar: convertImageToString(image: avatarImage)]
        
            createProfileinFirebase(userID, dictionary)
            
            
            Alert.showProfileCreationSuccessAlert(on: self)
        } else {
            Alert.showIncompleteFormAlert(on: self)
        }
        
    }
    
    //MARK: - View updates for Keyboard events
    
    @IBAction func onTapHideKeyboard(_ sender: UITapGestureRecognizer) {
        
       hideKeyboard()
    }
    

    
    
    func hideKeyboard() {
         self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        profileViewBottomConstraint.constant = 90.0
        profileViewTopConstraint.constant = 51
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        profileViewBottomConstraint.constant = 0.0
        profileViewTopConstraint.constant = 141
    }
    
    func goBackToHomePage() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}


extension ProfileSetupViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBAction func handleAvatarTap(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
        self.avatarImageView.image = image
        }
        dismiss(animated: true, completion: nil)
        
    }
}
