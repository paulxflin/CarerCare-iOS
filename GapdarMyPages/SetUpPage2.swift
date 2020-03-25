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
    
    //ln 16-18 set initial scroller height and arrays to store textfields and activities
    var yActivityValue = 10
    var activityTextFields : [UITextField] = []
    var activityArray : [String] = []
    
    //ln 21 set defaults variable to store data
    let defaults = UserDefaults.standard
    
    //ln 24-34 link up UI Components
    @IBOutlet weak var activityScrollView: UIScrollView!
    
    
    @IBOutlet weak var postcodeTextField: UITextField!
    
    @IBOutlet weak var stepsPerDayTextField: UITextField!
    
    @IBOutlet weak var contactsPerDayTextField: UITextField!
    
    
    @IBOutlet weak var SupportCodeTextField: UITextField!
    
    override func viewDidLoad() {
        //ln 36-38 Make sure the layouts are initialised correctly
        super.viewDidLoad()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        activityScrollView.layer.cornerRadius = 10.0
        
        //ln 41-44 Give UI Component Control as this class
        postcodeTextField.delegate = self
        stepsPerDayTextField.delegate = self
        contactsPerDayTextField.delegate = self
        SupportCodeTextField.delegate = self
        
        //ln 47-48 Fill Fields and Existing Activites
        fillFieldsWithPreviousData()
        setActivityScroller()
    }
    
    
    //ln 53-58 Gets the data previously filled and places the text in the text fields (Karunya)
    func fillFieldsWithPreviousData(){
        postcodeTextField.text = defaults.string(forKey: "postcode")
        stepsPerDayTextField.text = defaults.string(forKey: "targetSteps")
        contactsPerDayTextField.text = defaults.string(forKey: "targetCalls")
        SupportCodeTextField.text = defaults.string(forKey: "reference")
    }
    
    //ln 61-70 places previous activities on scroller (Karunya)
    func setActivityScroller(){
        let activityStringArray = defaults.stringArray(forKey: "activityArray") ?? []
        
        var i = 0
        while i < activityStringArray.count {
            let activity = activityStringArray[i]
            placeActivityOnScreen(activity: activity)
            i += 1
        }
    }
    
    //ln 73-75 Links UI to add a blank activity textfield onto screen (Paul)
    @IBAction func getActivitiesButtonPressed(_ sender: Any) {
        placeActivityOnScreen(activity: "")
    }
    
    
    //ln 79-101 places the activities on the screen (Karunya)
    func placeActivityOnScreen(activity: String){
        let widthOfCanvas = activityScrollView.frame.width
        let heightOfCanvas = self.view.frame.height * 0.15
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
        yActivityValue += Int(heightOfCanvas/4) + 5
        
        activityScrollView.contentSize.height = CGFloat(yActivityValue)
        
    }
    
    //ln 104-122 Save the textfield data (Paul)
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
        //ln 126 Hide the keyboard after hitting return
        textField.resignFirstResponder()
        return true
    }
    
    //ln 131-140 Limits the postcode textfield to 4 characters (Paul)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == postcodeTextField {
            let maxLength = 4
            let currentString : NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    //ln 143-149 Navigate back to first page (Paul)
    @IBAction func noThanksPressed(_ sender: UIButton) {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = mainSB.instantiateViewController(withIdentifier: "Setup")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = initialVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
}

