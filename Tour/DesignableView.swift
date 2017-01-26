//
//  DesignableView.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/25/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

@IBDesignable
public class DesignableView: UIView {
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
