//
//  ViewController.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/24/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonAction(_ sender: UIButton) {
        
        guard emailTextField.text?.isEmpty == false, passwordTextField.text?.isEmpty == false else {
            return
        }
        
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        
    }
}

