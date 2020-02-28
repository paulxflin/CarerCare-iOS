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
        
        contactSV.layer.cornerRadius = 15.0
        // Do any additional setup after loading the view, typically from a nib.
        phoneArray = defaults.stringArray(forKey: "phoneArray") ?? []
        nameArray = defaults.stringArray(forKey: "nameArray") ?? []
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
        guard let url = URL(string: "https://www.wales.nhs.uk/sitesplus/866/page/81903") else {return}
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
    
    
    
    func setupContactSV() {
        // TODO: Add a for loop to add in the saved contacts.
        view.addSubview(contactSV)
        
        addExistingContacts()
    }
    
    func addExistingContacts() {
        
        while i < nameArray.count {
            let name = nameArray[i]
            let phone = phoneArray[i]
            placeContactOnScreen(name: name, phone: phone, i: i)
            
            i += 1
        }
        
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
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
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
        i += 1
        defaults.set([], forKey: "phoneArray")
        defaults.set([], forKey: "nameArray")
        //empties
        
        print(phoneArray)
        print(nameArray)
        phoneArray.append(phoneNumber)
        nameArray.append(familyName)
        
        defaults.set(phoneArray, forKey: "phoneArray")
        defaults.set(nameArray, forKey: "nameArray")
        print(phoneArray)
        print(nameArray)
        placeContactOnScreen(name: familyName, phone: phoneNumber, i:i)
        
        if defaults.array(forKey: "networkCallsArray") != nil {
            callsArray = defaults.array(forKey: "networkCallsArray") as! [Int]
            messagesArray = defaults.array(forKey: "networkMessagesArray") as! [Int]
        }
        
        
        callsArray.append(0)
        messagesArray.append(0)
        defaults.set([], forKey: "networkCallsArray")
        defaults.set([], forKey: "networkMessagesArray")
        defaults.set(callsArray, forKey: "networkCallsArray")
        defaults.set(messagesArray, forKey: "networkMessagesArray")
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("It cancelled the contact picker view controller when the cancel button is pressed")
    }
    
    @IBAction func resetStart(_ sender: Any) {
        defaults.set(false, forKey: "setup")
        let activityCountArray = [0, 0, 0]
        defaults.set(activityCountArray, forKey: "activityCountArray")
    }
    
    
    func placeContactOnScreen(name: String, phone: String, i: Int){
        
        let widthOfCanvas = contactSV.frame.width
        
        let label = UILabel(frame: CGRect(x:10, y:yContactsValue, width:66, height: 33))
        label.textAlignment = .left
        label.text = "Name: "
        contactSV.addSubview(label)
        
        let nameTF = UITextField(frame: CGRect(x:74, y:yContactsValue, width:(Int(widthOfCanvas - 80)), height:33))
        nameTF.delegate = self
        nameTF.textAlignment = .left
        nameTF.text = name
        nameTF.backgroundColor = .white
        nameTF.borderStyle = .roundedRect
        contactSV.addSubview(nameTF)
        

        yContactsValue += 30 + 10
        
        let label2 = UILabel(frame: CGRect(x:10, y:yContactsValue, width:166, height:33))
        label2.textAlignment = .left
        label2.text = "Contact Number: "
        contactSV.addSubview(label2)
        
        let numTF = UITextField(frame: CGRect(x:156, y:yContactsValue, width:Int(widthOfCanvas - 160), height:33))
        numTF.delegate = self
        numTF.text = phone
        numTF.textAlignment = .left
        numTF.backgroundColor = .white
        numTF.borderStyle = .roundedRect
        contactSV.addSubview(numTF)
        
        let image = UIImage(named: "icons8-call-32.png") as UIImage?
        let button = UIButton.init(type: .roundedRect)
        button.frame = CGRect(x:310, y:yContactsValue, width:32, height:32)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(callPressed(_ :)), for: .touchUpInside)
        button.tag = i
        contactSV.addSubview(button)
        

        yContactsValue += 40
        contactSV.contentSize.height = CGFloat(yContactsValue)
        
    }
    
}
