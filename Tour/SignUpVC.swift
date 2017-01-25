//
//  SignUpViewController.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/24/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // User storage instance
    fileprivate var userStorage: FIRStorageReference!
    // Storage Refernce is safely secured into the file
    fileprivate let storageReference: String = ""
    // Creating an instance of the Firebase Database referece
    fileprivate var databaseReference: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Reference to storage
        let storage = FIRStorage.storage().reference(forURL: storageReference)
        // Creating a new folder in our Firebase storage called users
        userStorage = storage.child("users")
        databaseReference = databaseReference.database.reference()
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        // Checks if the any of the text fields are empty
        guard nameTextField.text?.isEmpty == false, emailTextField.text?.isEmpty == false, passwordTextField.text?.isEmpty == false, confirmPasswordTextField.text?.isEmpty == false else {
            return
        }
        
        // Checks if the password matches the confirm password
        if passwordTextField.text == confirmPasswordTextField.text {
            
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                // Uploading user to the database
                if let user = user {
                    // User info is the data model for each user's information
                    let userInfo: [String: Any] = ["uid" : user.uid,
                                                   "name" : self.nameTextField.text!,
                                                   "email" : self.emailTextField.text!]
                    
                }
            })
            
        } else {
            return
        }
    }
}
