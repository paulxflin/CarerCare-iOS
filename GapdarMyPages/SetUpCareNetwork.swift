//
//  SetUpCareNetwork.swift
//  GapdarMyPages
//
//  Created by localadmin on 17/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

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
    
    
    
    @IBOutlet weak var contactsScrollView: UIScrollView!
    
    @IBOutlet weak var nameField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsScrollView.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func addMoreContacts(_ sender: Any) {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let heightOfCanvas = contactsScrollView.frame.height
        let widthOfCanvas = contactsScrollView.frame.width
        
    
        
        print("the height is",heightOfCanvas)
        var familyName = ""
        var phoneNumber = ""
        for data in contact.phoneNumbers{
            let phoneNo = data.value
            familyName = contact.givenName + " "+contact.familyName
            phoneNumber = phoneNo.stringValue
            
        }
        
        let label = UILabel(frame: CGRect(x:10, y:yContactsValue, width:66, height: Int(heightOfCanvas/8)))
        label.textAlignment = .left
        label.text = "Name: "
        contactsScrollView.addSubview(label)
        
        let nameTF = UITextField(frame: CGRect(x:74, y:yContactsValue, width:(Int(widthOfCanvas - 80)), height:Int(heightOfCanvas/8)))
        nameTF.delegate = self
        nameTF.textAlignment = .left
        nameTF.text = familyName
        nameTF.backgroundColor = .white
        nameTF.borderStyle = .roundedRect
        contactsScrollView.addSubview(nameTF)
        
        nameTextFields.append(nameTF)
        yContactsValue += Int(heightOfCanvas/8) + 10
        
        let label2 = UILabel(frame: CGRect(x:10, y:yContactsValue, width:166, height:Int(heightOfCanvas/8)))
        label2.textAlignment = .left
        label2.text = "Contact Number: "
        contactsScrollView.addSubview(label2)
        
        let numTF = UITextField(frame: CGRect(x:156, y:yContactsValue, width:Int(widthOfCanvas - 160), height:Int(heightOfCanvas/8)))
        numTF.delegate = self
        numTF.text = phoneNumber
        numTF.textAlignment = .left
        numTF.backgroundColor = .white
        numTF.borderStyle = .roundedRect
        contactsScrollView.addSubview(numTF)
        phoneNumberTextFields.append(numTF)
        yContactsValue += Int(heightOfCanvas/8) + 10
        
        contactsScrollView.contentSize.height = CGFloat(yContactsValue)
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
        
      
        defaults.set(phoneNumberString, forKey: "phoneArray")
        defaults.set(nameString, forKey: "nameArray")
        
        defaults.set(nameField.text, forKey: "firstName")

        self.performSegue(withIdentifier: "ToSetUp2", sender: self)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
}
