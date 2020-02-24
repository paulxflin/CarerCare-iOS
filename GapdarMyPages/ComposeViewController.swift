//
//  ComposeViewController.swift
//  GapdarMyPages
//
//  Created by Paul Lam on 8/1/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit
import MessageUI

class ComposeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, MFMessageComposeViewControllerDelegate {

    let defaults = UserDefaults.standard
    
    var firstName : String?
    
    @IBOutlet weak var signoffLabel: UILabel!
    @IBOutlet weak var msgTextView: UITextView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var statusTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var activityTF: UITextField!
    
    @IBOutlet weak var namePV: UIPickerView!
    @IBOutlet weak var statusPV: UIPickerView!
    @IBOutlet weak var datePV: UIPickerView!
    @IBOutlet weak var timePV: UIPickerView!
    @IBOutlet weak var activityPV: UIPickerView!
    
    var nameOptions : [String] = [String]()
    var statusOptions : [String] = [String]()
    var dateOptions : [String] = [String]()
    var timeOptions : [String] = [String]()
    var activityOptions : [String] = [String]()
    
    var name : String?
    var status : String?
    var date : String?
    var time : String?
    var activity : String?
    
    var nameIndex : Int?
    var phoneArray : [String] = []
    var msg = ""
    
    var activityRow = -1
    var nameRow = -1
    
    @IBOutlet weak var msgView: UIView!
    
    @IBOutlet weak var composeButton: UIButton!
    
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        msgView.backgroundColor = .white
        msgView.layer.cornerRadius = 10.0
        
        msgTextView.layer.cornerRadius = 10.0
        msgView.clipsToBounds = true
        // Do any additional setup after loading the view.
        firstName = defaults.string(forKey: "firstName") ?? "Jo"
        signoffLabel.text! += firstName!
        
        namePV.isHidden = true
        statusPV.isHidden = true
        datePV.isHidden = true
        timePV.isHidden = true
        activityPV.isHidden = true
        
        self.namePV.delegate = self
        self.statusPV.delegate = self
        self.datePV.delegate = self
        self.timePV.delegate = self
        self.activityPV.delegate = self
        
        
        self.namePV.dataSource = self
        self.statusPV.dataSource = self
        self.datePV.dataSource = self
        self.timePV.dataSource = self
        self.activityPV.dataSource = self
        
        nameTF.delegate = self
        statusTF.delegate = self
        dateTF.delegate = self
        timeTF.delegate = self
        activityTF.delegate = self
        
        self.view.bringSubviewToFront(namePV)
        self.view.bringSubviewToFront(statusPV)
        self.view.bringSubviewToFront(datePV)
        self.view.bringSubviewToFront(timePV)
        self.view.bringSubviewToFront(activityPV)
        
        nameOptions = defaults.stringArray(forKey: "nameArray") ?? ["Paul", "Karunya", "Lishen", "Joseph"]
        statusOptions = ["Unwell", "OK", "Well"]
        dateOptions = ["10/01", "11/01"]
        timeOptions = ["10am", "3pm"]
        activityOptions = defaults.stringArray(forKey: "activityArray") ?? ["Coffee at the Hub", "Shop", "Walk"]
        phoneArray = defaults.stringArray(forKey: "phoneArray") ?? []
        
        if defaults.array(forKey: "networkMessagesArray") == nil {
            let networkMessagesArray = [Int](repeating: 0, count: nameOptions.count)
            defaults.set(networkMessagesArray, forKey: "networkMessagesArray")
            print(networkMessagesArray)
        }
        
    }
    
    // MARK: Actions
    
    //Number of Columns of Data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of Rows of Data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numRows = 0
        if (pickerView == namePV) {
            numRows = nameOptions.count
        } else if (pickerView == statusPV) {
            numRows = statusOptions.count
        } else if (pickerView == datePV) {
            numRows = dateOptions.count
        } else if (pickerView == timePV) {
            numRows = timeOptions.count
        } else if (pickerView == activityPV) {
            numRows = activityOptions.count
        }
        return numRows
    }
    
    // Data to return for the row and component (column) being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var option = "";
        if (pickerView == namePV) {
            option = nameOptions[row]
            nameIndex = row
        } else if (pickerView == statusPV) {
            option = statusOptions[row]
        } else if (pickerView == datePV) {
            option = dateOptions[row]
        } else if (pickerView == timePV) {
            option = timeOptions[row]
        } else if (pickerView == activityPV) {
            option = activityOptions[row]
        }
        return option
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == namePV) {
            name = nameOptions[row]
            nameTF.text = name
            nameRow = row
            namePV.isHidden = true
        } else if (pickerView == statusPV) {
            status = statusOptions[row]
            statusTF.text = status
            statusPV.isHidden = true
        } else if (pickerView == datePV) {
            date = dateOptions[row]
            dateTF.text = date
            datePV.isHidden = true
        } else if (pickerView == timePV) {
            time = timeOptions[row]
            timeTF.text = time
            timePV.isHidden = true
        } else if (pickerView == activityPV) {
            activity = activityOptions[row]
            activityTF.text = activity
            activityRow = row
            activityPV.isHidden = true
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == nameTF) {
            namePV.isHidden = false
        } else if (textField == statusTF) {
            statusPV.isHidden = false
        } else if (textField == dateTF) {
            datePV.isHidden = false
        } else if (textField == timeTF) {
            timePV.isHidden = false
        } else if (textField == activityTF) {
            activityPV.isHidden = false
        }
        return false
    }
    
    // Beware nil unwrapping during compose breaks app
    @IBAction func composePressed(_ sender: Any) {
        msg = ""
        msg += "Hello " + (name ?? "") + "\n"
        msg += "Just to let you know I am " + (status ?? "") + "\n"
        msg += "How about on " + (date ?? "") + "\n"
        msg += "at " + (time ?? "") + "\n"
        msg += "we meet for a " + (activity ?? "") + "\n"
        msg += "All the best, " + (firstName ?? "") + "."
        msgTextView.text = msg
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        let number = phoneArray[nameIndex!]
        if MFMessageComposeViewController.canSendText()
        {
            let msgVC = MFMessageComposeViewController()
            msgVC.body = msg
            msgVC.recipients = [number]
            msgVC.messageComposeDelegate = self
            
            //Note: It's Important to present the VC to render the graph UIImages to add to attachment. 
            let graphsSB : UIStoryboard = UIStoryboard(name: "Graphs", bundle: nil)
            let callsVC : CallsStatisticsViewController = graphsSB.instantiateViewController(withIdentifier: "callsStats") as! CallsStatisticsViewController
            self.present(callsVC, animated: true, completion: nil)
            let callsData : Data = callsVC.getCallsGraphImage()
            msgVC.addAttachmentData(callsData, typeIdentifier: "public.data", filename: "callsGraph.png")
            
            self.dismiss(animated: true) {
                let stepsVC : StepsStatisticsViewController = graphsSB.instantiateViewController(withIdentifier: "stepsStats") as! StepsStatisticsViewController
                self.present(stepsVC, animated: true, completion: nil)
                let stepsData : Data = stepsVC.getStepsGraphImage()
                msgVC.addAttachmentData(stepsData, typeIdentifier: "public.data", filename: "stepsGraph.png")
                self.dismiss(animated: true) {
                    self.present(msgVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        let barSB : UIStoryboard = UIStoryboard(name: "MenuTabBar", bundle: nil)
        let barVC = barSB.instantiateViewController(withIdentifier: "tabBar")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = barVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
    
    //This part is reached after the apple message view is closed.
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
        
        print("activityRow: " + String(activityRow))
        if activityRow != -1 {
            updateActivityCount(activityRow)
        }
        
        print("nameRow: " + String(nameRow))
        if nameRow != -1 {
            updateNetworkMessagesCount(nameRow)
        }
        
        print("I have reached the didFinish method for message")
    }
    
    func updateNetworkMessagesCount(_ row: Int)
    {
        var networkMessagesArray : [Int] = defaults.array(forKey: "networkMessagesArray") as! [Int]? ?? [0, 0, 0]
        networkMessagesArray[row] += 1
        defaults.set(networkMessagesArray, forKey: "networkMessagesArray")
        print("networkMessagesArray")
        print(defaults.array(forKey: "networkMessagesArray") as! [Int])
    }
    
    func updateActivityCount(_ row: Int) {
        var activityCountArray = defaults.array(forKey: "activityCountArray") ?? [0, 0, 0]
        var num : Int = activityCountArray[row] as? Int ?? 0
        num += 1
        activityCountArray[row] = num
        defaults.set(activityCountArray, forKey: "activityCountArray")
        print("activityCountArray: ")
        print(activityCountArray)
        
        if num == 2 {
            let passedActivity = activity!
            defaults.set(passedActivity, forKey: "passedActivity")
            let messagesSB : UIStoryboard = UIStoryboard(name: "Messages", bundle: nil)
            let asmVC = messagesSB.instantiateViewController(withIdentifier: "asm")
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = asmVC
            appDelegate?.window??.makeKeyAndVisible()
        }
        
    }
    
}
