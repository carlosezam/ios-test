//
//  DesignableView.swift
//  Playground
//
//  Created by Mobile 02 on 16/03/21.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet{
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable var shadowOffsetY: CGFloat = 0 {
        didSet{
            layer.shadowOffset.height = shadowOffsetY
        }
    }
}
