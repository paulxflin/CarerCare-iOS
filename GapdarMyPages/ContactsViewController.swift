//
//  ContactsViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 07/12/2019.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
import ContactsUI

class ContactsViewController: UIViewController, CNContactPickerDelegate {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func getNumberPressed(_ sender: Any) {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }

    
    
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        //for data in contact.phoneNumbers{
            //let phoneNo = data.value
            //numberLabel.text = phoneNo.stringValue
        //}
        contacts.forEach { (contact) in
            for data in contact.phoneNumbers{
                let phoneNo = data.value
                numberLabel.text = phoneNo.stringValue
            }
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("It cancelled the contact picker view controller when the cancel button is pressed")
    }
    
}

