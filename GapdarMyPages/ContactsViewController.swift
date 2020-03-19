//
//  ContactsViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 09/01/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit
import ContactsUI

class ContactsViewController: UIViewController, UITextFieldDelegate, CNContactPickerDelegate {
    
    
    let defaults = UserDefaults.standard
    
    var yContactsValue = 10
    var phoneArray : [String] = []
    var nameArray : [String] = []
    var i = 0
    var phoneNumberTextFields: [UITextField] = []
    var nameTextFields : [UITextField] = []
    var callsArray : [Int] = []
    var messagesArray : [Int] = []
    
    @IBOutlet weak var contactSV: UIScrollView!
    
    
    @IBOutlet weak var weblink01: RoundButton!
    

    @IBOutlet weak var weblink02: UIButton!
    
  
    @IBOutlet weak var weblink03: UIButton!
    
    @IBOutlet weak var weblink04: UIButton!
    
    @IBOutlet weak var weblink05: UIButton!
    
    @IBOutlet weak var weblink06: UIButton!
    
    @IBOutlet weak var weblink07: UIButton!
    
    @IBOutlet weak var weblink08: UIButton!
    
    @IBOutlet weak var weblink09: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var subviews = self.contactSV.subviews
        subviews.removeAll()
        
        //Make sure the layouts are initialised correctly
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        contactSV.layer.cornerRadius = 15.0
        // Do any additional setup after loading the view, typically from a nib.
        phoneArray = defaults.stringArray(forKey: "phoneArray") ?? []
        nameArray = defaults.stringArray(forKey: "nameArray") ?? []
        // Note this is already setup during the settings phase
        callsArray = defaults.array(forKey: "networkCallsArray") as? [Int] ?? []
        print(phoneArray)
        print(nameArray)
        setupContactSV()
    }
    
    @IBAction func weblinkButPressed01(_ sender: Any) {
        guard let url = URL(string: "https://www.torfaen.gov.uk/en/HealthSocialCare/Keeping-Active-and-Getting-Out/Torfaen-Community-Connectors/Torfaen-Community-Connectors.aspx") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func weblinkButPressed02(_ sender: Any) {
        guard let url = URL(string: "https://www.ctsew.org.uk/care-services") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func weblinkButPressed03(_ sender: Any) {
        guard let url = URL(string: "https://www.dewis.wales") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func weblinkButPressed04(_ sender: Any) {
        guard let url = URL(string: "http://www.wales.nhs.uk/sitesplus/866/page/87422") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func weblinkButPressed05(_ sender: Any) {
        guard let url = URL(string: "https://www.ageconnectstorfaen.org.uk/services") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func weblinkButPressed06(_ sender: Any) {
        guard let url = URL(string: "https://www.ffrindimi.co.uk") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func weblinkButPressed07(_ sender: Any) {
        guard let url = URL(string: "whatsapp://") else {return}
        guard let urlAppStore = URL(string: "https://itunes.apple.com/app/id310633997") else {return}
        if UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
        else
        {
            UIApplication.shared.open(urlAppStore)
        }
        
    }
    
    @IBAction func weblinkButPressed08(_ sender: Any) {
        guard let url = URL(string: "https://www.alzheimers.org.uk") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func weblinkButPressed09(_ sender: Any) {
        guard let url = URL(string: "headspace://") else {return}
        guard let urlAppStore = URL(string: "https://itunes.apple.com/app/id493145008") else {return}
        if UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
        else
        {
            UIApplication.shared.open(urlAppStore)
        }
    }
    
    
    //places contacts that are already on the screen (Karunya)
    func setupContactSV() {
        // TODO: Add a for loop to add in the saved contacts.
        view.addSubview(contactSV)
        
        addExistingContacts()
    }
    
    
    //Goes through previously added contacts (Karunya)
    func addExistingContacts() {
        
        while i < nameArray.count {
            let name = nameArray[i]
            let phone = phoneArray[i]
            placeContactOnScreen(name: name, phone: phone, i: i)
            
            i += 1
        }
        
    }
    

    
    //Allows user to get another contact (Karunya)
    @IBAction func getNumber(_ sender: Any) {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    
    //Gets the contact and places it on the screen (Karunya)
    //Appends the new contact to the defaults storage
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        var familyName = ""
        var phoneNumber = ""
        for data in contact.phoneNumbers{
            let phoneNo = data.value
            familyName = contact.givenName + " "+contact.familyName
            phoneNumber = phoneNo.stringValue
            
        }
        
        phoneArray.append(phoneNumber)
        nameArray.append(familyName)
        
        defaults.set(phoneArray, forKey: "phoneArray")
        defaults.set(nameArray, forKey: "nameArray")
        print(phoneArray)
        print(nameArray)
        placeContactOnScreen(name: familyName, phone: phoneNumber, i:i)
        i += 1
        
        
        //retrieves network calls array
        if defaults.array(forKey: "networkCallsArray") != nil {
            callsArray = defaults.array(forKey: "networkCallsArray") as! [Int]
            messagesArray = defaults.array(forKey: "networkMessagesArray") as! [Int]
        }
        
        //adds network array to all of the new contacts
        callsArray.append(0)
        messagesArray.append(0)
        defaults.set(callsArray, forKey: "networkCallsArray")
        defaults.set(messagesArray, forKey: "networkMessagesArray")
    }
    
    
    
    //UI For placing the contacts on the screen (Karunya)
    func placeContactOnScreen(name: String, phone: String, i: Int){
        let swidth = self.view.frame.width - 30
        print("this is swidth")
        print(swidth)
        let height = self.view.frame.height * 0.25
        let adjustedHeight = swidth * 0.57
        print("this is the adjustedHeight")
        print(adjustedHeight)
        
        let label = UILabel(frame: CGRect(x:10, y:yContactsValue, width:66, height: Int(height/8)))
        label.textAlignment = .left
        label.text = "Name: "
        contactSV.addSubview(label)
        
        let nameTF = UITextField(frame: CGRect(x:74, y:yContactsValue, width:(Int(swidth - 80)), height:Int(height/8)))
        nameTF.delegate = self
        nameTF.textAlignment = .left
        nameTF.text = name
        nameTF.backgroundColor = .white
        nameTF.borderStyle = .roundedRect
        nameTF.tag = i
        contactSV.addSubview(nameTF)
        
        
        yContactsValue += Int(height/8) + 5
        
        let label2 = UILabel(frame: CGRect(x:10, y:yContactsValue, width:166, height:Int(height/8)))
        label2.textAlignment = .left
        label2.text = "Contact Number: "
        contactSV.addSubview(label2)
        let buttonDimension = Int (height/8)
        
        let numTF = UITextField(frame: CGRect(x:156, y:yContactsValue, width:Int(Int(swidth ) - 2 * buttonDimension - 5 - 160), height:Int(height/8)))
        numTF.delegate = self
        numTF.text = phone
        numTF.textAlignment = .left
        numTF.backgroundColor = .white
        numTF.borderStyle = .roundedRect
        //Note 100 here is an arbitrary large number to differentiate nameTF and numTF.
        numTF.tag = i + 100
        contactSV.addSubview(numTF)
        
        
        
        let image = UIImage(named: "icons8-call-32.png") as UIImage?
        let button = UIButton.init(type: .roundedRect)
        button.frame = CGRect(x:Int(Int(swidth ) - 2 * buttonDimension - 5), y:yContactsValue, width:buttonDimension, height:buttonDimension)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(callPressed(_ :)), for: .touchUpInside)
        button.tag = i
        contactSV.addSubview(button)
        
        // Adding a message button
        let image2 = UIImage(named: "icons8-messaging-50.png") as UIImage?
        let button2 = UIButton.init(type: .roundedRect)
        button2.frame = CGRect(x:Int(Int(swidth ) - buttonDimension), y:yContactsValue, width:buttonDimension, height:buttonDimension)
        button2.setImage(image2, for: .normal)
        button2.addTarget(self, action: #selector(messagePressed(_ :)), for: .touchUpInside)
        button2.tag = i
        contactSV.addSubview(button2)
        
        
        yContactsValue += Int(height/8) + 5
        contactSV.contentSize.height = CGFloat(yContactsValue)
        
    }
    
    
    
    @objc func callPressed(_ sender: UIButton) {
        // Debug: print(sender.tag)
        let phone = phoneArray[sender.tag]
        let number = String(phone.filter {!" \n\t\r".contains($0)})
        print(number)
        var totalCalls = defaults.integer(forKey: "totalCalls")
        totalCalls += 1
        defaults.set(totalCalls, forKey: "totalCalls")
        print(defaults.integer(forKey: "totalCalls"))
        
        callsArray[sender.tag] += 1
        print("callsArray")
        print(callsArray)
        defaults.set(callsArray, forKey: "networkCallsArray")
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func messagePressed(_ sender: UIButton) {
        print("message pressed")
        let messagesSB : UIStoryboard = UIStoryboard(name: "Messages", bundle: nil)
        let composeVC = messagesSB.instantiateViewController(withIdentifier: "compose")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = composeVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
    
    
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("It cancelled the contact picker view controller when the cancel button is pressed")
    }
    
//    @IBAction func resetStart(_ sender: Any) {
//        defaults.set(false, forKey: "setup")
//        let activityCountArray = [0, 0, 0]
//        defaults.set(activityCountArray, forKey: "activityCountArray")
//        defaults.set(0, forKey: "totalCalls")
//        defaults.set(0, forKey: "totalMessages")
//    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Modify the phoneArray or nameArray here
        let tag = textField.tag
        if tag < 100 {
            //modify nameArray
            nameArray[tag] = textField.text!
            defaults.set(nameArray, forKey: "nameArray")
        }
        else {
            phoneArray[tag-100] = textField.text!
            defaults.set(phoneArray, forKey: "phoneArray")
        }
    }
    
}
