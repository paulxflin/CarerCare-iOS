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
        
        activityOptions = defaults.stringArray(forKey: "activityArray") ?? ["Coffee at the Hub", "Shop", "Walk"]
        choiceOptions = ["Yes", "No"]
        
        firstName = defaults.string(forKey: "firstName") ?? "Jo"
    }
    
    // MARK: Actions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numRows = 0
        if (pickerView == activityPV) {
            numRows = activityOptions.count
        } else if (pickerView == choicePV) {
            numRows = choiceOptions.count
        }
        return numRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var option = "";
        if (pickerView == activityPV) {
            option = activityOptions[row]
        } else if (pickerView == choicePV) {
            option = choiceOptions[row]
        }
        return option
    }
    
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == activityTF) {
            activityPV.isHidden = false
        } else if (textField == choiceTF) {
            choicePV.isHidden = false
        }
        return false
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        let phoneArray = defaults.stringArray(forKey: "phoneArray") ?? []
        let number = phoneArray[2] //Arbitrarily determined by Joseph 3rd contact is carer
        
        var msg : String = ""
        msg += "Name: " + firstName! + "\n"
        msg += "Activity: " + activity! + "\n"
        msg += "Interested in Joining A Group: " + choice!
        
        if MFMessageComposeViewController.canSendText()
        {
            let msgVC = MFMessageComposeViewController()
            msgVC.body = msg
            msgVC.recipients = [number]
            msgVC.messageComposeDelegate = self
            self.present(msgVC, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
}
