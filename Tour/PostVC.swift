//
//  PostVC.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/30/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Firebase

class PostVC: UIViewController {

    // Place to put use status
    @IBOutlet weak var userStatusTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Button to post the status
    @IBAction private func postButtonAction(_ sender: UIButton) {
        // The user unique ID
        let uid = FIRAuth.auth()!.currentUser!.uid
        
        // Databse reference
        let reference = FIRDatabase.database().reference()
        
        // Users status reference
        let statusReference = reference.child("status")
        
        // Unique string for each post
        let key = statusReference.childByAutoId().key
        
        // For status reference, each status has a unique key
        let userStatusReference = statusReference.child(key)
        
        // User status
        guard let status = userStatusTextView.text else {
            return
        }
        
        userStatusReference.setValue(status) { (error, reference) in
            // if there is an error
            if error != nil {
                print(error!)
            }
            
        }
        
    }
    
}
