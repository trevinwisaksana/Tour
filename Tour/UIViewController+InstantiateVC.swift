//
//  UIViewController + InstantiateVC.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/24/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func instantiateViewController(file name: String, identifier: String) {
        // Instantiate the main view controller
        let viewController = UIStoryboard.init(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
        self.present(viewController, animated: true, completion: nil)
    }
    
}
