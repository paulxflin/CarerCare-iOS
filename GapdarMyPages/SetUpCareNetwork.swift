//
//  SetUpCareNetwork.swift
//  GapdarMyPages
//
//  Created by localadmin on 17/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//  Contributors: Paul

import Foundation
import UIKit
import ContactsUI

class SetUpCareNetwork: UIViewController, UITextFieldDelegate, CNContactPickerDelegate {
    
    
    let defaults = UserDefaults.standard
    var yContactsValue = 10
    var nameTextFields : [UITextField] = []
    var phoneNumberTextFields: [UITextField] = []
    var phoneNumberString : [String] = []
    var nameString : [String] = []
    var callsArray : [Int] = []
    var messagesArray : [Int] = []
   
    
    @IBOutlet weak var contactsScrollView: UIScrollView!
    
    @IBOutlet weak var nameField: UITextField!
    
    
    //Make sure the layouts are initialised correctly, and existing data is added (Paul)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        setupContactSV()
        contactsScrollView.layer.cornerRadius = 10.0
        nameField.delegate = self
        nameField.text = defaults.string(forKey: "firstName")
        
    }
    
    func setupContactSV() {
        // TODO: Add a for loop to add in the saved contacts.
//        view.addSubview(contactsScrollView)
        addExistingContacts()
    }
    
    
    //places existing contacts (Karunya)
    func addExistingContacts() {
        let phoneNumberStringArray = defaults.stringArray(forKey: "phoneArray") ?? []
        let nameStringArray = defaults.stringArray(forKey: "nameArray") ?? []
        var i = 0
        print(contactsScrollView.frame.height)
        while i < nameStringArray.count {
            let name = nameStringArray[i]
            let phone = phoneNumberStringArray[i]
            
            placeContactOnScreen(name: name, phone: phone)
            
            i += 1
        }
        
    }
    
    // Calls a the phone contacts view to select a contact to add (Paul)
    @IBAction func addMoreContacts(_ sender: Any) {
        print(contactsScrollView.frame.height)
        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    
    //UI for placing contacts on the screen (Karunya) Same as ContactsViewController
    func placeContactOnScreen(name: String, phone: String){
        
        let widthOfCanvas = contactsScrollView.frame.width
        let heightOfCanvas = self.view.frame.height * 0.25
        let label = UILabel(frame: CGRect(x:10, y:yContactsValue, width:66, height: Int(heightOfCanvas/8)))
        label.textAlignment = .left
        label.text = "Name: "
        contactsScrollView.addSubview(label)
        
        let nameTF = UITextField(frame: CGRect(x:74, y:yContactsValue, width:(Int(widthOfCanvas - 80)), height: Int(heightOfCanvas/8)))
        nameTF.delegate = self
        nameTF.textAlignment = .left
        nameTF.text = name
        nameTF.backgroundColor = .white
        nameTF.borderStyle = .roundedRect
        contactsScrollView.addSubview(nameTF)
        
        nameTextFields.append(nameTF)
        yContactsValue += Int(heightOfCanvas/8) + 5
        
        let label2 = UILabel(frame: CGRect(x:10, y:yContactsValue, width:166, height:Int(heightOfCanvas/8)))
        label2.textAlignment = .left
        label2.text = "Contact Number: "
        contactsScrollView.addSubview(label2)
        
        let numTF = UITextField(frame: CGRect(x:156, y:yContactsValue, width:Int(widthOfCanvas - 160), height:Int(heightOfCanvas/8)))
        numTF.delegate = self
        numTF.text = phone
        numTF.textAlignment = .left
        numTF.backgroundColor = .white
        numTF.borderStyle = .roundedRect
        contactsScrollView.addSubview(numTF)
        phoneNumberTextFields.append(numTF)
        yContactsValue += Int(heightOfCanvas/8) + 5
        
        
        contactsScrollView.contentSize.height = CGFloat(yContactsValue)
        
    }
    
    
    //User picks contact (Karunya)
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        var familyName = ""
        var phoneNumber = ""
        for data in contact.phoneNumbers{
            let phoneNo = data.value
            familyName = contact.givenName + " "+contact.familyName
            phoneNumber = phoneNo.stringValue
            
        }
        //131 places newly selected contact onto screen
        placeContactOnScreen(name: familyName, phone: phoneNumber)
        
        //133-136 checks whether the defaults arrays are empty, if not, calls the current array
        if defaults.array(forKey: "networkCallsArray") != nil {
            callsArray = defaults.array(forKey: "networkCallsArray") as! [Int]
            messagesArray = defaults.array(forKey: "networkMessagesArray") as! [Int]
        }
        
        //140-141 appends the value 0 to calls and messages assigning them call and messages history value; 142/3 updates the defaults array of arrays with those names
        callsArray.append(0)
        messagesArray.append(0)
        defaults.set(callsArray, forKey: "networkCallsArray")
        defaults.set(messagesArray, forKey: "networkMessagesArray")
        
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("It cancelled the contact picker view controller when the cancel button is pressed")
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        for phoneNumber in phoneNumberTextFields{
            phoneNumberString.append(phoneNumber.text ?? "-")
            
        }
        
        for name in nameTextFields{
            nameString.append(name.text ?? "-")
        }
        print(phoneNumberString)
        print(nameString)
      
        defaults.set(phoneNumberString, forKey: "phoneArray")
        defaults.set(nameString, forKey: "nameArray")
        
        defaults.set(nameField.text, forKey: "firstName")

        self.performSegue(withIdentifier: "ToSetUp2", sender: self)
        
    }
    
    // Hide the keyboard after return is pressed (Paul)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Navigate back to first page (Paul)
    @IBAction func noThanksPressed(_ sender: UIButton) {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = mainSB.instantiateViewController(withIdentifier: "Setup")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = initialVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
    
}
