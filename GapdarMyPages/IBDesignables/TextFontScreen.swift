//
//  TextFontScreen.swift
//  GapdarMyPages
//
//  Created by localadmin on 24/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import Foundation
import  UIKit

@IBDesignable
class TextFontScreen: UITextView{
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
