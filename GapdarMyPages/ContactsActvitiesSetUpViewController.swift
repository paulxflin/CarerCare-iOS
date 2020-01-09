//
//  ContactsViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 07/12/2019.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
import ContactsUI

class ContactsActvitiesSetUpViewController: UIViewController, CNContactPickerDelegate {
    
    
 
    var yContactsValue = 145
    var yActivityValue = 535
    
    
    var phoneNumberTextFields: [UITextField] = []
    var nameTextFields : [UITextField] = []
    var activityTextFields : [UITextField] = []
    
    
    var phoneNumberString : [String] = []
    var nameString : [String] = []
    var activityString : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
  
    
    @IBAction func getNumber(_ sender: Any) {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
   
    
   
    
    
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        var familyName = ""
        var phoneNumber = ""
        for data in contact.phoneNumbers{
            let phoneNo = data.value
            familyName = contact.givenName + " "+contact.familyName
            phoneNumber = phoneNo.stringValue

        }
        let label = UILabel(frame: CGRect(x:44, y:yContactsValue, width:66, height:33))
        //label.center = CGPoint(x:44, y:146)
        label.textAlignment = .center
        label.text = "Name: "
        self.view.addSubview(label)
        
        let namelabel = UITextField(frame: CGRect(x:118, y:yContactsValue, width:272, height:33))
        //namelabel.center = CGPoint(x:118, y:152)
        namelabel.textAlignment = .center
        namelabel.text = familyName
        namelabel.backgroundColor = .white
        self.view.addSubview(namelabel)
        nameTextFields.append(namelabel)
        yContactsValue += 40
        
        let label2 = UILabel(frame: CGRect(x:44, y:yContactsValue, width:166, height:33))
        //label.center = CGPoint(x:44, y:146)
        label2.textAlignment = .center
        label2.text = "Contact Number: "
        self.view.addSubview(label2)
        
        let numlabel = UITextField(frame: CGRect(x:200, y:yContactsValue, width:150, height:33))
        //namelabel.center = CGPoint(x:118, y:152)
        
        numlabel.text = phoneNumber
        numlabel.backgroundColor = .white
        self.view.addSubview(numlabel)
        phoneNumberTextFields.append(numlabel)
        yContactsValue += 40
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("It cancelled the contact picker view controller when the cancel button is pressed")
    }
    
    
    
    
    
    @IBAction func activityButtonPressed(_ sender: Any) {
        let label = UILabel(frame: CGRect(x:44, y:yActivityValue, width:74, height:33))
        //label.center = CGPoint(x:44, y:146)
        label.textAlignment = .center
        label.text = "Activity: "
        self.view.addSubview(label)
        
        let activityLabel = UITextField(frame: CGRect(x:120, y:yActivityValue, width:231, height:33))
        //label.center = CGPoint(x:44, y:146)
       activityLabel.backgroundColor = .white
        
        
        //createToolBar(textField: activityLabel)
        //label.text = "Name: "
        self.view.addSubview(activityLabel)
        activityTextFields.append(activityLabel)
        yActivityValue += 40
        
    }
    
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        print("I am in here")
        for phoneNumber in phoneNumberTextFields{
            phoneNumberString.append(phoneNumber.text ?? "-")
        }
        
        for name in nameTextFields{
            nameString.append(name.text ?? "-")
        }
        
        for activity in activityTextFields{
            activityString.append(activity.text ?? "-")
        }
        print(phoneNumberString)
        print(nameString)
        print(activityString)
        self.performSegue(withIdentifier: "startTrackingSegue", sender: self)
    }
    
  
}







