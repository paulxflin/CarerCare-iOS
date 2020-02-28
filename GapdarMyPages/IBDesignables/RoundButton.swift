//
//  RoundButton.swift
//  GapdarMyPages
//
//  Created by localadmin on 02/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import Foundation
import  UIKit

@IBDesignable
class RoundButton: UIButton{
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var textSize: CGFloat = 0{
        didSet{
            let bounds = UIScreen.main.bounds
            let fontName = self.titleLabel!.font.fontName
            let newFont = UIFont(name: fontName, size: bounds.size.height * textSize )
            self.titleLabel!.font = newFont
            //let newSize = self.sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            //self.frame.size = CGSize(width: max(newSize.width,self.frame.size.width), height: newSize.height)
        }
    }
    
   
    @IBInspectable var circleButton: Bool = false{
        didSet{
            
            if (circleButton == true){
            let height = self.frame.height
            let width = self.frame.width
                
            if (height != width){
                self.frame.size = CGSize(width: height, height: height)
                self.layer.cornerRadius = height/2
                self.clipsToBounds = true
            }
            
            
            let height2 = self.frame.height
            let width2 = self.frame.width
                
            if (width2 != height2){
                self.frame.size = CGSize(width: width2, height: width2)
                    
                self.layer.cornerRadius = width2/2
                self.clipsToBounds = true
            }
            }
                
            
        }
    }
    
    
}
