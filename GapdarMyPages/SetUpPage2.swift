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
        //Make sure the layouts are initialised correctly
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        super.viewDidLoad()
        activityScrollView.layer.cornerRadius = 10.0
        postcodeTextField.delegate = self
        stepsPerDayTextField.delegate = self
        contactsPerDayTextField.delegate = self
        SupportCodeTextField.delegate = self
        
        postcodeTextField.text = defaults.string(forKey: "postcode")
        stepsPerDayTextField.text = defaults.string(forKey: "targetSteps")
        contactsPerDayTextField.text = defaults.string(forKey: "targetCalls")
        SupportCodeTextField.text = defaults.string(forKey: "reference")
        
        setActivityScroller()
        
        
    }
    
    func setActivityScroller(){
        let activityStringArray = defaults.stringArray(forKey: "activityArray") ?? []
        
        var i = 0
        while i < activityStringArray.count {
            let activity = activityStringArray[i]
            
            
            placeActivityOnScreen(activity: activity)
            
            i += 1
        }
    }
    
    @IBAction func getActivitiesButtonPressed(_ sender: Any) {
        placeActivityOnScreen(activity: "")
        
    }
    
    func placeActivityOnScreen(activity: String){
        
        let widthOfCanvas = activityScrollView.frame.width
        let heightOfCanvas = activityScrollView.frame.height
        print(heightOfCanvas)
        let label = UILabel(frame: CGRect(x:10, y:yActivityValue, width:74, height:Int(heightOfCanvas/4)))
        //label.center = CGPoint(x:44, y:146)
        label.textAlignment = .left
        label.text = "Activity: "
        activityScrollView.addSubview(label)
        
        let activityTF = UITextField(frame: CGRect(x:80, y:yActivityValue, width:(Int(widthOfCanvas - 84)), height:Int(heightOfCanvas/4)))
        activityTF.delegate = self
        activityTF.backgroundColor = .white
        activityTF.textAlignment = .left
        activityTF.borderStyle = .roundedRect
        activityTF.text = activity
        activityScrollView.addSubview(activityTF)
        activityTextFields.append(activityTF)
        yActivityValue += Int(heightOfCanvas/4) + 10
        
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
    
    @IBAction func noThanksPressed(_ sender: UIButton) {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = mainSB.instantiateViewController(withIdentifier: "Setup")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = initialVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
}

