//
//  UIViewController + InstantiateVC.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/24/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
     A method that instantiates a view controller (changes displayed view controller to a new view controller specified.
     - parameter name: File name of the storyboard file.
     - parameter identifier: Storyboard idenitifier of the View Controller.
    */
    func instantiateViewController(file name: String, identifier: String) {
        // Instantiate view controller
        let viewController = UIStoryboard.init(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
        self.present(viewController, animated: true, completion: nil)
    }
    
}
