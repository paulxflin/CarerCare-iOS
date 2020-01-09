//
//  ContactsViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 09/01/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit
import ContactsUI

class ContactsViewController: UIViewController, CNContactPickerDelegate {
    
    
    var yContactsValue = 145
    
    
    
    
    
    
    
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
        
        yContactsValue += 40
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("It cancelled the contact picker view controller when the cancel button is pressed")
    }


}
