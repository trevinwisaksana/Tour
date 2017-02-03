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
    
    @IBOutlet weak var postView: DesignableView!
    
    @IBAction func unwindToMainVC(withUnwindSegue unwindSegue: UIStoryboardSegue) {
        _ = unwindSegue.source
    }
    
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
        
        circularProfilePictureHelper(for: profilePicture)
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
    
}



// MARK: - CollectionView
// WARNING: DO NOT PUT EXTENSION IN A DIFFERENT FILE BECAUSE UNWIND SEGUE WOULD NOT WORK
// Responsible for CollectionView setup
extension MainVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // nibFile references the Main cell nib file
        let nibFile = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        // Registers the nib file
        collectionView.register(nibFile, forCellWithReuseIdentifier: "postCell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! MainCollectionViewCell
        
        return cell
        
    }
    
    // MARK: - Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Size of the cell
        return CGSize(width: self.view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Spacing between the cells
        return CGFloat(0)
    }
    
    
    
}

