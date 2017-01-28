//
//  ListOfFollowersVC.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/26/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Firebase

class FollowersVC: UIViewController {
    
    // Reference to the table view
    @IBOutlet weak var tableView: UITableView!
    
    // List of users array
    var listOfUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUsers()
        
    }
    
    private func retrieveUsers() {
        let reference = FIRDatabase.database().reference()
        reference.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            
            // Prevents duplicated values
            self?.listOfUsers.removeAll()
            
            /// Swift doesn't know what snapshot is so we have to cast it into its data type
            // - String is going to be the key
            // - AnyObject is going to be the data
            let users = snapshot.value as! [String : AnyObject]
            
            // Get all the user ID's
            // Used to check all the user ID so that the user's own doesn't show
            for (_, value) in users {
                // Checks if the user data is complete
                guard let uid = value["uid"] as? String, let name = value["name"] as? String, let email = value["email"] as? String else {
                    fatalError("Value not found in database")
                }
                
                // Checks if the user querried is not the current user, append it
                if uid != FIRAuth.auth()?.currentUser?.uid {
                    let user = User(userID: uid, fullName: name, imagePath: nil, email: email)
                    self?.listOfUsers.append(user)
                }
                
            }
            
            // Refreshes the table view
            self?.tableView.reloadData()
            
        })
        
        // Prevents memory leak
        // Even though we're already using weak self, it's still good practice
        reference.removeAllObservers()
        
    }
    
}
