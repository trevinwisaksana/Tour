//
//  ProfileVC.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/26/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func followersButtonAction(_ sender: Any) {
        self.instantiateViewController(file: "Profile", identifier: "ListOfFollowersVC")
    }
    
    
}
