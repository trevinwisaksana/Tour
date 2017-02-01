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
        
        // Makes sure the check mark works with persistency
        checkFollowing(indexPath: indexPath)
        
        // Checks if the follow button is which
        if isFollowing {
            cell.followerStateButton.titleLabel?.text = "Follow"
        } else {
            cell.followerStateButton.titleLabel?.text = "Unfollow"
        }
        
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
        
        // Resets the follow button state
        isFollowing = false
      
        // Observes the value of whether the user is following the person or not
        reference.child("users").child(uid!).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            
            if let following = snapshot.value as? [String : AnyObject] {
                // Checks throught the dictionary
                for (_key, value) in following {
                    if value as? String == self?.listOfUsers[indexPath.row].userID {
                        
                        // Making it easier to read
                        let userReference = reference.child("users")
                        let userID = self?.listOfUsers[indexPath.row].userID
                        
                        // Changes to a follower
                        self?.isFollowing = true
                        
                        // Removing the user that we're following
                        userReference.child(uid!).child("following/\(_key)").removeValue()
                        // Removing the follower
                        userReference.child(userID!).child("followers/\(_key)").removeValue()
                       
                        // Removes the check mark if unfollowed
                        tableView.cellForRow(at: indexPath)?.accessoryType = .none
                        
                    }
                }

            }
            
            // Follow the user
            if (self?.isFollowing)! == false {
                let following = ["following/\(key)" : self?.listOfUsers[indexPath.row].userID]
                let followers = ["followers/\(key)" : uid]
                let _userID = self?.listOfUsers[indexPath.row].userID
                
                // Update the value
                reference.child("users").child(uid!).updateChildValues(following)
                reference.child("users").child(_userID!).updateChildValues(followers)
                
                // Shows the check mark if followed
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
        
        })
        
        reference.removeAllObservers()
        
    }
    
    // TODO: Not DRY code
    func checkFollowing(indexPath: IndexPath) {
        // Unique ID of the user
        let uid = FIRAuth.auth()?.currentUser?.uid
        // Reference of the Firebase database
        let reference = FIRDatabase.database().reference()
        // Observes the value of whether the user is following the person or not
        reference.child("users").child(uid!).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            
            if let following = snapshot.value as? [String : AnyObject] {
                // Checks throught the dictionary
                for (_, value) in following {
                    if value as? String == self?.listOfUsers[indexPath.row].userID {
                        self?.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                    }
                }
            }
        })
        
        reference.removeAllObservers()
    
    }
    
}
