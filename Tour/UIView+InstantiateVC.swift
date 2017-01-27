//
//  UIView+InstantiateVC.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/26/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension UIView {
    
    func instantiateViewControllerFromView(file name: String, identifier: String) {
        // Instantiate view controller
        let viewController = UIStoryboard.init(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
}
