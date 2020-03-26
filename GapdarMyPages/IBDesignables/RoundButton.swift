//
//  RoundButton.swift
//  GapdarMyPages
//
//  Created by localadmin on 02/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//  Karunya

import Foundation
import  UIKit

@IBDesignable
class RoundButton: UIButton{
    //Sets corner radius size
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    //dynamically changes the size of text on buttons. gets current font, and then changes the size by multiplying the value with the height of the screen
    @IBInspectable var textSize: CGFloat = 0{
        didSet{
            let bounds = UIScreen.main.bounds
            let fontName = self.titleLabel!.font.fontName
            let newFont = UIFont(name: fontName, size: bounds.size.height * textSize )
            self.titleLabel!.font = newFont
    
        }
    }
    
    
}
