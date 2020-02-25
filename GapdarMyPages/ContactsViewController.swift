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
    var networkCallsArray : [Int] = []
    
    var phoneNumberTextFields: [UITextField] = []
    var nameTextFields : [UITextField] = []
    
    var i : Int = 0
    
    @IBOutlet weak var contactSV: UIScrollView!
    
    @IBOutlet weak var weblink01: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactSV.layer.cornerRadius = 15.0
        // Do any additional setup after loading the view, typically from a nib.
        phoneArray = defaults.stringArray(forKey: "phoneArray") ?? []
        nameArray = defaults.stringArray(forKey: "nameArray") ?? []
        
        //Create array to track number of calls made per person.
        if defaults.array(forKey: "networkCallsArray") == nil {
            networkCallsArray = [Int](repeating: 0, count: nameArray.count)
            defaults.set(networkCallsArray, forKey: "networkCallsArray")
            print(networkCallsArray)
        }
        networkCallsArray = defaults.array(forKey: "networkCallsArray") as! [Int]
        
        setupContactSV()
        setupWebLink01()
    }
    
    func setupWebLink01()
    {
        weblink01.isUserInteractionEnabled = true;
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(webLinkButPressed01))
        weblink01.addGestureRecognizer(tapGestureRecognizer)
        weblink01.image = UIImage(named: "web.png")
    }
    
    @objc func webLinkButPressed01()
    {
        guard let url = URL(string: "https://google.com") else {return}
        UIApplication.shared.open(url)
    }
    
    func setupContactSV() {
        // TODO: Add a for loop to add in the saved contacts.
        view.addSubview(contactSV)
        
        addExistingContacts()
    }
    
    func addExistingContacts() {
        let heightOfCanvas = contactSV.frame.height
        let widthOfCanvas = contactSV.frame.width
        
        //var i = 0
        while i < nameArray.count {
            let name = nameArray[i]
            let phone = phoneArray[i]
            
            let label = UILabel(frame: CGRect(x:10, y:yContactsValue, width:66, height: Int(heightOfCanvas/8)))
            label.textAlignment = .left
            label.text = "Name: "
            contactSV.addSubview(label)
            
            let nameTF = UITextField(frame: CGRect(x:74, y:yContactsValue, width: (Int(widthOfCanvas - 50)), height:Int(heightOfCanvas/8)))
            nameTF.delegate = self
            nameTF.textAlignment = .center
            nameTF.text = name
            nameTF.backgroundColor = .white
            nameTF.borderStyle = .roundedRect
            contactSV.addSubview(nameTF)
            
            nameTextFields.append(nameTF)
            yContactsValue += Int(heightOfCanvas/8) + 10
            
            let label2 = UILabel(frame: CGRect(x:10, y:yContactsValue, width:100, height:Int(heightOfCanvas/8)))
            label2.textAlignment = .left
            label2.text = "Contact No: "
            contactSV.addSubview(label2)
            
            let numTF = UITextField(frame: CGRect(x:110, y:yContactsValue, width:Int(widthOfCanvas - 160), height:Int(heightOfCanvas/8)))
            numTF.delegate = self
            numTF.text = phone
            numTF.textAlignment = .center
            numTF.backgroundColor = .white
            numTF.borderStyle = .roundedRect
            contactSV.addSubview(numTF)
            
            // TODO: Add a button to make calls(God DAMMIT)
            let image = UIImage(named: "icons8-call-32.png") as UIImage?
            let button = UIButton.init(type: .roundedRect)
            button.frame = CGRect(x:300, y:yContactsValue, width:32, height:32)
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(callPressed(_ :)), for: .touchUpInside)
            button.tag = i
            contactSV.addSubview(button)
            
            // Adding a message button
            let image2 = UIImage(named: "icons8-messaging-50.png") as UIImage?
            let button2 = UIButton.init(type: .roundedRect)
            button2.frame = CGRect(x:335, y:yContactsValue, width:32, height:32)
            button2.setImage(image2, for: .normal)
            button2.addTarget(self, action: #selector(messagePressed(_ :)), for: .touchUpInside)
            button2.tag = i
            contactSV.addSubview(button2)
            
            phoneNumberTextFields.append(numTF)
            yContactsValue += Int(heightOfCanvas/8) + 10
            
            contactSV.contentSize.height = CGFloat(yContactsValue)
            
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
        
        networkCallsArray[sender.tag] += 1
        defaults.set(networkCallsArray, forKey: "networkCallsArray")
        print("No. Calls per person")
        print(defaults.array(forKey: "networkCallsArray") as! [Int])
        
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
    
    
    @IBAction func getNumber(_ sender: Any) {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        // This is where the processing is done after contact is picked
        // This code is legacy and needs to be changed.
        
        // Setting up the variables to collect data
        var familyName = ""
        var phoneNumber = ""
        for data in contact.phoneNumbers{
            let phoneNo = data.value
            familyName = contact.givenName + " "+contact.familyName
            phoneNumber = phoneNo.stringValue
            
        }
        
        nameArray.append(familyName)
        defaults.set(nameArray, forKey: "nameArray")
        phoneArray.append(phoneNumber)
        defaults.set(phoneArray, forKey: "phoneArray")
        
        networkCallsArray.append(0)
        defaults.set(networkCallsArray, forKey: "networkCallsArray")
        
        
        let heightOfCanvas = contactSV.frame.height
        let widthOfCanvas = contactSV.frame.width
        
        let name = familyName  //nameArray[i]
        let phone = phoneNumber  //phoneArray[i]
        
        let label = UILabel(frame: CGRect(x:10, y:yContactsValue, width:66, height: Int(heightOfCanvas/8)))
        label.textAlignment = .left
        label.text = "Name: "
        contactSV.addSubview(label)
        
        let nameTF = UITextField(frame: CGRect(x:74, y:yContactsValue, width: (Int(widthOfCanvas - 90)), height:Int(heightOfCanvas/8)))
        nameTF.delegate = self
        nameTF.textAlignment = .center
        nameTF.text = name
        nameTF.backgroundColor = .white
        nameTF.borderStyle = .roundedRect
        contactSV.addSubview(nameTF)
        
        nameTextFields.append(nameTF)
        yContactsValue += Int(heightOfCanvas/8) + 10
        
        let label2 = UILabel(frame: CGRect(x:10, y:yContactsValue, width:100, height:Int(heightOfCanvas/8)))
        label2.textAlignment = .left
        label2.text = "Contact No: "
        contactSV.addSubview(label2)
        
        let numTF = UITextField(frame: CGRect(x:110, y:yContactsValue, width:Int(widthOfCanvas - 200), height:Int(heightOfCanvas/8)))
        numTF.delegate = self
        numTF.text = phone
        numTF.textAlignment = .center
        numTF.backgroundColor = .white
        numTF.borderStyle = .roundedRect
        contactSV.addSubview(numTF)
        
        // TODO: Add a button to make calls(God DAMMIT)
        let image = UIImage(named: "icons8-call-32.png") as UIImage?
        let button = UIButton.init(type: .roundedRect)
        button.frame = CGRect(x:300, y:yContactsValue, width:32, height:32)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(callPressed(_ :)), for: .touchUpInside)
        button.tag = i
        contactSV.addSubview(button)
        
        // Adding a message button
        let image2 = UIImage(named: "icons8-messaging-50.png") as UIImage?
        let button2 = UIButton.init(type: .roundedRect)
        button2.frame = CGRect(x:335, y:yContactsValue, width:32, height:32)
        button2.setImage(image2, for: .normal)
        button2.addTarget(self, action: #selector(messagePressed(_ :)), for: .touchUpInside)
        button2.tag = i
        contactSV.addSubview(button2)
        
        phoneNumberTextFields.append(numTF)
        yContactsValue += Int(heightOfCanvas/8) + 10
        
        contactSV.contentSize.height = CGFloat(yContactsValue)
        
        i += 1
        
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("It cancelled the contact picker view controller when the cancel button is pressed")
    }

    @IBAction func resetStart(_ sender: Any) {
        defaults.set(false, forKey: "setup")
        defaults.set(0, forKey: "totalCalls")
        defaults.set(nil, forKey: "networkCallsArray")
        defaults.set(nil, forKey: "networkMessagesArray")
        let activityCountArray = [0, 0, 0]
        defaults.set(activityCountArray, forKey: "activityCountArray")
    }
    
}
