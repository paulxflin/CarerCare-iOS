//
//  SetUpPage2.swift
//  GapdarMyPages
//
//  Created by localadmin on 17/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import Foundation
import UIKit
import ContactsUI

class SetUpPage2: UIViewController, UITextFieldDelegate, CNContactPickerDelegate {
    var yActivityValue = 10
    var activityTextFields : [UITextField] = []
    var activityArray : [String] = []
    
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var activityScrollView: UIScrollView!
    
    
    @IBOutlet weak var postcodeTextField: UITextField!
    
    @IBOutlet weak var stepsPerDayTextField: UITextField!
    
    @IBOutlet weak var contactsPerDayTextField: UITextField!
    
    
    @IBOutlet weak var SupportCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityScrollView.layer.cornerRadius = 10.0
        postcodeTextField.delegate = self
        stepsPerDayTextField.delegate = self
        contactsPerDayTextField.delegate = self
        SupportCodeTextField.delegate = self
        
    }
    
    @IBAction func getActivitiesButtonPressed(_ sender: Any) {
        let label = UILabel(frame: CGRect(x:10, y:yActivityValue, width:74, height:33))
        //label.center = CGPoint(x:44, y:146)
        label.textAlignment = .left
        label.text = "Activity: "
        activityScrollView.addSubview(label)
        
        let activityTF = UITextField(frame: CGRect(x:80, y:yActivityValue, width:231, height:33))
        activityTF.delegate = self
        activityTF.backgroundColor = .white
        activityTF.textAlignment = .left
        activityTF.borderStyle = .roundedRect
        
        activityScrollView.addSubview(activityTF)
        activityTextFields.append(activityTF)
        yActivityValue += 40
        
        activityScrollView.contentSize.height = CGFloat(yActivityValue)
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        for activity in activityTextFields{
            activityArray.append(activity.text ?? "-")
        }
        
        defaults.set(activityArray, forKey: "activityArray")
        
        defaults.set(SupportCodeTextField.text, forKey: "reference")
        
        defaults.set(postcodeTextField.text, forKey: "postcode")
        
        defaults.set(stepsPerDayTextField.text, forKey: "targetSteps")
        
        defaults.set(contactsPerDayTextField.text, forKey: "targetCalls")
        
        self.performSegue(withIdentifier: "ToStartTrackingPage", sender: self)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    
}

