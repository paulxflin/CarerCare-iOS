//
//  ActivitySupportMessage.swift
//  GapdarMyPages
//
//  Created by localadmin on 06/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit
import MessageUI

class ActivitySupportMessage:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, MFMessageComposeViewControllerDelegate {
    
    let defaults = UserDefaults.standard
    
    var firstName : String?
    
    @IBOutlet weak var activityTF: UITextField!
    @IBOutlet weak var choiceTF: UITextField!
    
    @IBOutlet weak var activityPV: UIPickerView!
    @IBOutlet weak var choicePV: UIPickerView!
    
    var activityOptions : [String] = [String]()
    var choiceOptions : [String] = [String]()
    
    var activity : String?
    var choice : String?
    
    @IBOutlet weak var messageView: UIView!
    
    override func viewDidLoad() {
        messageView.layer.masksToBounds = true
        messageView.layer.cornerRadius = 10
        
        activityPV.isHidden = true
        choicePV.isHidden = true
        
        self.activityPV.delegate = self
        self.choicePV.delegate = self
        
        self.activityPV.dataSource = self
        self.choicePV.dataSource = self
        
        activityTF.delegate = self
        choiceTF.delegate = self
        
        activity = defaults.string(forKey: "passedActivity") ?? ""
        activityTF.text = activity!
        
        activityOptions = defaults.stringArray(forKey: "activityArray") ?? ["Coffee at the Hub", "Shop", "Walk"]
        choiceOptions = ["Yes", "No"]
        
        firstName = defaults.string(forKey: "firstName") ?? "Jo"
    }
    
    // MARK: Actions
    
    // Set picker columns (Paul)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Set picker rows (Paul)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numRows = 0
        if (pickerView == activityPV) {
            numRows = activityOptions.count
        } else if (pickerView == choicePV) {
            numRows = choiceOptions.count
        }
        return numRows
    }
    
    // Set picker option to display (Paul)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var option = "";
        if (pickerView == activityPV) {
            option = activityOptions[row]
        } else if (pickerView == choicePV) {
            option = choiceOptions[row]
        }
        return option
    }
    
    // Put data in textfield (Paul)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == activityPV) {
            activity = activityOptions[row]
            activityTF.text = activity
            activityPV.isHidden = true
        } else if (pickerView == choicePV) {
            choice = choiceOptions[row]
            choiceTF.text = choice
            choicePV.isHidden = true
        }
    }
    
    // Show appropriate picker (Paul)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == activityTF) {
            activityPV.isHidden = false
        } else if (textField == choiceTF) {
            choicePV.isHidden = false
        }
        return false
    }
    
    // Generate message, and call imessages (Paul)
    @IBAction func sendPressed(_ sender: UIButton) {
        let phoneArray = defaults.stringArray(forKey: "phoneArray") ?? []
        let number = phoneArray[0] //Arbitrarily determined by Joseph 1st contact is carer
        
        // Beware nil unwrapping during compose breaks app
        var msg : String = ""
        msg += "Name: " + (firstName ?? "") + "\n"
        msg += "Activity: " + (activity ?? "") + "\n"
        msg += "Interested in Joining A Group: " + (choice ?? "Yes")
        
        if MFMessageComposeViewController.canSendText()
        {
            let msgVC = MFMessageComposeViewController()
            msgVC.body = msg
            msgVC.recipients = [number]
            msgVC.messageComposeDelegate = self
            self.present(msgVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        returnHome()
    }
    
    //Dismiss messages view after sent, and navigate home (Paul)
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
        //checks whether message has been sent (0: cancelled, 1: sent, 2: failed)
        if result.rawValue == 1 {
            returnHome()
        }
        
    }
    
    func returnHome() {
        let barSB : UIStoryboard = UIStoryboard(name: "MenuTabBar", bundle: nil)
        let barVC = barSB.instantiateViewController(withIdentifier: "tabBar")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = barVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
    
}
