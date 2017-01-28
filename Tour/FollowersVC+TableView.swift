//
//  ListOfFollowers+TableView.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/27/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Firebase

extension FollowersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reference to the nib file
        let nibFile = UINib(nibName: "FollowersTableViewCell", bundle: nil)
        // Registering the nib file as the cell of the table view
        tableView.register(nibFile, forCellReuseIdentifier: "followerCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "followerCell") as! FollowersTableViewCell
        
        // Storing the element item from each row at the elementAtIndex
        let elementAtIndex = listOfUsers[indexPath.row]
        
        // Assigns name of the users
        cell.userNameLabel.text = elementAtIndex.fullName
        cell.userID = elementAtIndex.userID
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Unique ID of the user
        let uid = FIRAuth.auth()?.currentUser?.uid
        // Reference of the Firebase database
        let reference = FIRDatabase.database().reference()
        // Key is something unique everytime its called
        let key = reference.child("users").childByAutoId().key
        
        // Check if the current user is currently following the user selected
        var isFollower = false
        
        // Observes the value of whether the user is following the person or not
        reference.child("users").child(uid!).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            
            guard let following = snapshot.value as? [String : AnyObject] else {
                // No followers
                
            }
            
            // Checks throught the dictionary
            for (key, value) in following {
                if value as? String == self.user[indexPath.row].userID {
                    
                    // Making it easier to read
                    let userReference = reference.child("users")
                    
                    // Changes to a follower
                    isFollower = true
                    
                    // Removing the user that we're following
                    userReference.child(uid).child("following/\(key)").removeValue()
                    // Removing the follower
                    userReference.child(self.user[indexPath.row].userID).child("followers/\(key)").removeValue()
                    
                    // TODO: Make the check mark
                }
            }
            
            
            
        })
        
        
    }
    
}
