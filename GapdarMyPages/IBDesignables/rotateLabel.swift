//
//  rotateLabel.swift
//  GapdarMyPages
//
//  Created by localadmin on 06/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//  Karunya

import UIKit


@IBDesignable
class rotateLabel: UILabel{
    //allows label to be rotated;17 converts degrees to radians;18 performs the transformation allowing labels to rotate
    @IBInspectable var rotation: CGFloat = 0{
        didSet{
            let radians = CGFloat(CGFloat(Double.pi)*CGFloat(rotation)/CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
    
    
    //Dynamically changes the size the text on the label (same as TextFontScreen)
    @IBInspectable var textSize: CGFloat = 0{
        didSet{
            let bounds = UIScreen.main.bounds
            let fontName = self.font!.fontName
            let newFont = UIFont(name: fontName, size: bounds.size.height * textSize )
            self.font = newFont
            let newSize = self.sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            self.frame.size = CGSize(width: max(newSize.width,self.frame.size.width), height: newSize.height)
        }
    }
    
    
    
}
