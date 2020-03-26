//
//  TextFontScreen.swift
//  GapdarMyPages
//
//  Created by localadmin on 24/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//  Karunya

import Foundation
import  UIKit

@IBDesignable
class TextFontScreen: UITextView{
    //this enables the text to change dynamically, i.e. text gets larger as screen gets larger; 18-20 gets current font and uses that to create a new font, however with a size that is larger;21-22 adjusts the frame size, i.e. ensures that the larger text will fully display on the screen;23 ensures that the text is fully visible on the screen and not scrollable within a small area
    @IBInspectable var textSize: CGFloat = 0{
        didSet{
            let bounds = UIScreen.main.bounds
            let fontName = self.font!.fontName
            let newFont = UIFont(name: fontName, size: bounds.size.height * textSize )
            self.font = newFont
            let newSize = self.sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            self.frame.size = CGSize(width: max(newSize.width,self.frame.size.width), height: newSize.height)
            self.isScrollEnabled = false
            
        }
    }
    
    
    
}
