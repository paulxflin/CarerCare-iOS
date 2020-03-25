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
    //ln 14 setup data storing
    let defaults = UserDefaults.standard
    
    var firstName : String?
    //ln 18-31 link UI components
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    @IBOutlet weak var signoffLabel: UILabel!
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
    //ln 33-37 setup arrays to store picker options
    var nameOptions : [String] = [String]()
    var statusOptions : [String] = [String]()
    var dateOptions : [String] = [String]()
    var timeOptions : [String] = [String]()
    var activityOptions : [String] = [String]()
    //ln 39-43 setup variables to store user input
    var name : String?
    var status : String?
    var date : String?
    var time : String?
    var activity : String?
    //ln 45-48 setup index to track who to send message, phone number array, and variable to store msg
    var nameIndex : Int?
    var phoneArray : [String] = []
    var msg = ""
    //ln 49-50 initialise activity and name row tracking variables for logic later on
    var activityRow = -1
    var nameRow = -1
    //ln 52-26 connect more sb components to code
    @IBOutlet weak var msgView: UIView!
    
    @IBOutlet weak var attachSwitch: UISwitch!
    
    @IBOutlet weak var sendButton: UIButton!
    
    //ln 59-115 Setup delegates and datasources (Paul)
    override func viewDidLoad() {
        super.viewDidLoad()
        msgView.backgroundColor = .white
        msgView.layer.cornerRadius = 10.0
        msgView.clipsToBounds = true
        // Do any additional setup after loading the view.
        firstName = defaults.string(forKey: "firstName") ?? "Jo"
        signoffLabel.text! += firstName!
        
        namePV.isHidden = true
        statusPV.isHidden = true
        datePV.isHidden = true
        timePV.isHidden = true
        activityPV.isHidden = true
        
        dateTimePicker.backgroundColor = UIColor .white
        dateTimePicker.isHidden = true
        
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
    
    //ln 121-144 Format Date time data to input into textfields (Paul)
    @IBAction func dateTimePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: dateTimePicker.date)
        print("This is the strDate")
        print(strDate)
        let strArr = strDate.split(separator: ",")
        let selectedDate : String = String(strArr[0])
        print("This is the selectedDate")
        print(selectedDate)
        let selectedTime : String? = strArr.count > 1 ? String(strArr[1]).trimmingCharacters(in: .whitespacesAndNewlines) : nil
        print("This is the selectedTime")
        print(selectedTime ?? "missing selected time")
        
        date = selectedDate
        dateTF.text = selectedDate
        
        time = selectedTime
        timeTF.text = selectedTime
        
        dateTimePicker.isHidden = true
    }
    
    //ln 147-149 Number of Columns of Data for normal pickers
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //ln 152-166 Number of Rows of Data
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
    
    //ln 169-184 Data to return for the row and component (column) being passed in
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
    
    //ln 187-210 Adjust the right textfield and make picker invisible again (Paul)
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
//            date = dateOptions[row]
//            dateTF.text = date
//            datePV.isHidden = true
        } else if (pickerView == timePV) {
//            time = timeOptions[row]
//            timeTF.text = time
//            timePV.isHidden = true
        } else if (pickerView == activityPV) {
            activity = activityOptions[row]
            activityTF.text = activity
            activityRow = row
            activityPV.isHidden = true
        }
        
    }
    
    // Find the correct pickerview to show (Paul)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == nameTF) {
            namePV.isHidden = false
        } else if (textField == statusTF) {
            statusPV.isHidden = false
        } else if (textField == dateTF) {
            //datePV.isHidden = false
            dateTimePicker.isHidden = false
        } else if (textField == timeTF) {
            //timePV.isHidden = false
            dateTimePicker.isHidden = false
        } else if (textField == activityTF) {
            activityPV.isHidden = false
        }
        return false
    }
    
    //ln 233-258 Compose message + add json as appropriate (Paul)
    func composeMsg() {
        msg = ""
        msg += "Hello " + (name ?? "") + "\n"
        msg += "Just to let you know I am " + (status ?? "") + "\n"
        msg += "How about on " + (date ?? "") + "\n"
        msg += "at " + (time ?? "") + "\n"
        msg += "let's talk about " + (activity ?? "") + "\n"
        msg += "All the best, " + (firstName ?? "") + "."
        
        if attachSwitch.isOn {
            // Carer Support Ref, PostCode, StepsHistory, CallsHistory, ScoreHistory, Last Recorded Date
            let jsonParams : [String : Any] = [
                "supportCode" : defaults.string(forKey: "reference") ?? "apptest",
                "postCode" : defaults.string(forKey: "postcode") ?? "EC3R",
                "stepsHistory" : defaults.array(forKey: "stepsArray") as! [Int],
                "callsHistory" : defaults.array(forKey: "callsArray") as! [Int],
                "scoreHistory" : defaults.array(forKey: "scoresArray") as! [Int],
                "date" : defaults.string(forKey: "lastUpdateDate") ?? "01012020"
            ]
            let data = try? JSONSerialization.data(withJSONObject: jsonParams, options: JSONSerialization.WritingOptions())
            let stringJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(String(stringJson!))
            
            msg += "\n\n" + String(stringJson ?? "Json Unavailable")
        }
    }
    
    //ln 261-305 Builds appropriate message (Paul)
    @IBAction func sendPressed(_ sender: UIButton) {
        composeMsg()
        let number = phoneArray[nameIndex!]
        if MFMessageComposeViewController.canSendText()
        {
            let msgVC = MFMessageComposeViewController()
            msgVC.body = msg
            msgVC.recipients = [number]
            msgVC.messageComposeDelegate = self
            
            //Note: It's Important to present the VC to render the graph UIImages to add to attachment.
            if attachSwitch.isOn {
                let graphsSB : UIStoryboard = UIStoryboard(name: "Graphs", bundle: nil)
                let diaryVC : WellBeingDiary = graphsSB.instantiateViewController(withIdentifier: "diary") as! WellBeingDiary
                self.present(diaryVC, animated: true, completion: nil)
                let diaryData : Data = diaryVC.getDiaryImage()
                msgVC.addAttachmentData(diaryData, typeIdentifier: "public.data", filename: "diary.png")
                
                self.dismiss(animated: true) {
                    self.present(msgVC, animated: true, completion: nil)
                }
                
                //ln 284-298 The commented out section here gets the two graphs separately with their axises
                /*
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
                */
            } else {
                self.present(msgVC, animated: true, completion: nil)
            }
            
        }
    }
    
    //ln 308-314 Navigate back to home (Paul)
    @IBAction func cancelPressed(_ sender: UIButton) {
        let barSB : UIStoryboard = UIStoryboard(name: "MenuTabBar", bundle: nil)
        let barVC = barSB.instantiateViewController(withIdentifier: "tabBar")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = barVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
    
    //ln 318-333 This part is reached after the apple message view is closed.
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true) {
            //checks whether message has been sent (0: cancelled, 1: sent, 2: failed)
            if result.rawValue == 1 {
                print("nameRow: " + String(self.nameRow))
                if self.nameRow != -1 {
                    self.updateNetworkMessagesCount(self.nameRow)
                }
                
                print("activityRow: " + String(self.activityRow))
                if self.activityRow != -1 {
                    self.updateActivityCount(self.activityRow)
                }
            }
        }
    }
    
    //ln 336-346 update number of messages sent for specific person, and total messsages count
    func updateNetworkMessagesCount(_ row: Int)
    {
        var networkMessagesArray : [Int] = defaults.array(forKey: "networkMessagesArray") as! [Int]? ?? [0, 0, 0]
        networkMessagesArray[row] += 1
        defaults.set(networkMessagesArray, forKey: "networkMessagesArray")
        print("networkMessagesArray")
        print(defaults.array(forKey: "networkMessagesArray") as! [Int])
        
        let totalMessages = defaults.integer(forKey: "totalMessages") + 1
        defaults.set(totalMessages, forKey: "totalMessages")
    }
    
    //ln 349-370 update number of times an activity has been chosen, and decide whether to navigate to network message or return home
    func updateActivityCount(_ row: Int) {
        var activityCountArray = defaults.array(forKey: "activityCountArray") ?? [0, 0, 0]
        var num : Int = activityCountArray[row] as? Int ?? 0
        num += 1
        activityCountArray[row] = num
        defaults.set(activityCountArray, forKey: "activityCountArray")
        print("activityCountArray: ")
        print(activityCountArray)
        
        if num >= 2 && num <= 4 {
            let passedActivity = activity!
            defaults.set(passedActivity, forKey: "passedActivity")
            let messagesSB : UIStoryboard = UIStoryboard(name: "Messages", bundle: nil)
            let asmVC = messagesSB.instantiateViewController(withIdentifier: "asm")
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = asmVC
            appDelegate?.window??.makeKeyAndVisible()
        } else {
            returnHome()
        }
        
    }
    
    // ln 373-381 return to the homeVC
    func returnHome() {
        let barSB : UIStoryboard = UIStoryboard(name: "MenuTabBar", bundle: nil)
        let barVC = barSB.instantiateViewController(withIdentifier: "tabBar")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = barVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
}
