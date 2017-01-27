//
//  MainVC.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/24/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Tap gesture used to open the profile view
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(tapGestureHelper(gesture:)))
        
        profilePicture.addGestureRecognizer(tapGesture)
        
        // Allows the profile picture view to insantiate view controller
        profilePictureSetup()
        
    }
    
    // Instantiates the message view controller
    @IBAction func messageButtonAction(_ sender: UIButton) {
        self.instantiateViewController(file: "Main",
                                       identifier: "MessageVC")
    }
    
    // Adds the tap gesture onto the profile picture
    func profilePictureSetup() {
        
        // Allows user interaction
        profilePicture.isUserInteractionEnabled = true
        
        // Creating a circular profile image
        profilePicture.layer.cornerRadius = profilePicture.frame.width / 2
        // Crops the image from the circular border
        profilePicture.layer.masksToBounds = true
    }
    
    // Gesture recognizer setup
    func tapGestureHelper(gesture: UITapGestureRecognizer) {
        self.instantiateViewController(file: "Profile",
                                       identifier: "ProfileVC")
    }

}
