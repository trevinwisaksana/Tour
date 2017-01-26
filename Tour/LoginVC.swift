//
//  ViewController.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/24/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButtonAction(_ sender: UIButton) {
        // Checks if the text fields are empty
        guard emailTextField.text?.isEmpty == false, passwordTextField.text?.isEmpty == false else {
            return
        }
        
        // Logins in with the user email and password
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [weak self](user, error) in
            // If there is an error
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Instantiate the main view controller
                self?.instantiateViewController(file: "Main", identifier: "MainVC")
            }
            
        })
        
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        // Instantiate the main view controller
        self.instantiateViewController(file: "Entry", identifier: "SignUpVC")
    }
}

