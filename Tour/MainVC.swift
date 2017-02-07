//
//  MainVC.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/24/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var postView: DesignableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func unwindToMainVC(withUnwindSegue unwindSegue: UIStoryboardSegue) {}
    
    // MARK: - User objects
    var listOfPosts: [PostStatus] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Allows the profile picture view to insantiate view controller
        // Tap gesture used to open the profile view
        // Tap gesture has to be placed here
        let profileTapGesture = UITapGestureRecognizer(target: self,
                                                       action: #selector(profileTapGestureHelper(gesture:)))
        // Add gesture for the profile image
        profilePicture.addGestureRecognizer(profileTapGesture)
        
        // Post view tap gesture with selector
        let postViewTapGesture = UITapGestureRecognizer(target: self,
                                                        action: #selector(postViewTapGestureHelper(gesture:)))
        // Adds gesture for the postView
        postView.addGestureRecognizer(postViewTapGesture)
        
        // Circular profile picture
        circularProfilePictureHelper(for: profilePicture)
        
        // Retreiving user posts
        retrievePostHelper()
    }
    
    // Instantiates the message view controller
    @IBAction func messageButtonAction(_ sender: UIButton) {
        self.instantiateViewController(file: "Main",
                                       identifier: "MessageVC")
    }
    
    // Adds the tap gesture onto the post profile picture
    func circularProfilePictureHelper(for image: UIImageView) {
        // Allows user interaction
        image.isUserInteractionEnabled = true
        // Creating a circular profile image
        image.layer.cornerRadius = image.frame.width / 2
        // Crops the image from the circular border
        image.layer.masksToBounds = true
    }
    
    // Profile gesture recognizer setup
    func profileTapGestureHelper(gesture: UITapGestureRecognizer) {
        self.instantiateViewController(file: "Profile",
                                       identifier: "ProfileVC")
    }
    
    // View gesture recognizer setup
    func postViewTapGestureHelper(gesture: UITapGestureRecognizer) {
        self.instantiateViewController(file: "Main",
                                       identifier: "PostVC")
    }
    
    // Retreive post
    private func retrievePostHelper() {
        // User ID
        let uid = FIRAuth.auth()?.currentUser?.uid
        // Firebase Database Reference
        let reference = FIRDatabase.database().reference()
        // Retrieves the user status
        reference.child("status").queryOrderedByKey().observeSingleEvent(of: .value, with: { [unowned self](snapshot) in
            
            // Prevents duplicated values
            self.listOfPosts.removeAll()
            
            /// Swift doesn't know what snapshot is so we have to cast it into its data type
            // - String is going to be the key
            // - AnyObject is going to be the data
            let post = snapshot.value as! [String : AnyObject]
            
            for (_, value) in post {
                // Checks if the user data is complete
                guard let userStatus = value["status"] as? String, let author = value["author"] as? String, let likes = value["likes"] as? Int, let uid = value["uid"] as? String, let postID = value["postID"] as? String else {
                    return
                }
                
                // Adds the status onto the list
                self.listOfPosts.append(PostStatus(userStatus: userStatus, author: author, likes: likes, userID: uid, postID: postID))
            }
            
            // Refreshes the collection view
            self.collectionView.reloadData()
            
        })
        
        // Prevents memory leak
        // Even though we're already using unowned self, so it automatically deallocates the reference it's still good practice
        reference.removeAllObservers()
        
    }
    
}




