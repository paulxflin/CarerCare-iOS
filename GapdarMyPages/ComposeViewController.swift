//
//  ComposeViewController.swift
//  GapdarMyPages
//
//  Created by Paul Lam on 8/1/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    @IBOutlet weak var msgLabel: UILabel!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        nameOptions = ["Paul", "Karunya", "Lishen", "Joseph"]
        statusOptions = ["Unwell", "OK", "Well"]
        dateOptions = ["10/01", "11/01"]
        timeOptions = ["10am", "3pm"]
        activityOptions = ["Coffee at the Hub", "Shop", "Walk"]
        

        // Do any additional setup after loading the view.
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
    
    @IBAction func composePressed(_ sender: Any) {
        var msg = "";
        msg += "Hello " + name! + "\n"
        msg += "Just to let you know I am " + status! + "\n"
        msg += "How about on " + date! + "\n"
        msg += "at " + time! + "\n"
        msg += "we meet for a " + activity! + "\n"
        msg += "All the best, Jo."
        msgLabel.text = msg
    }
    

}
