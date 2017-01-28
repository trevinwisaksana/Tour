//
//  UIView+RetrieveImage.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/27/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func retrieveImage(from imageURL: String) {
        // Creating a URL request using the image URL
        let url = URLRequest(url: URL(string: imageURL)!)
        // Creating a session to download the image
        let task = URLSession.shared.dataTask(with: url) { [weak self](data, response, error) in
            
            // Checks an error exists
            if error != nil {
                fatalError(error as! String)
            }
            
            // Places it into an asynchronous download to not prevent the main thread to be blocked
            DispatchQueue.main.async {
                // The image is the data
                self?.image = UIImage(data: data!)
            }
            
        }
        
        // Resumes the task
        task.resume()
    }
    
}
