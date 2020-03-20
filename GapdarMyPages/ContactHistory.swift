//
//  ContactHistory.swift
//  GapdarMyPages
//
//  Created by localadmin on 06/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import Foundation
import UIKit

class ContactHistory:UIViewController{
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var historyScroller: UIScrollView!
    
    @IBOutlet weak var messageImage: UIImageView!
    
    @IBOutlet weak var callsImage: UIImageView!
    
    var nameArray : [String] = []
    var networkCallsArray : [Int] = []
    var networkMessagesArray : [Int] = []
    
    var callLabelArray : [UILabel]  = []
    var messageLabelArray : [UILabel]  = []
    
    var yposition : Int = 60
    
    // Get info and update data each time view opened (Paul)
    override func viewWillAppear(_ animated: Bool) {
        let width = self.view.frame.width - 30
        messageImage.frame = CGRect(x: width - 50, y:8, width:50, height:50)
        
        callsImage.frame = CGRect(x: width - 110, y:8, width:50, height:50)
        print("willAppear reached")
        getInfo()
        updateTF()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyScroller.layer.masksToBounds = true
        historyScroller.layer.cornerRadius = 10.0
        
//        getInfo()
//        callLabelArray = [UILabel](repeating: UILabel.init(), count: nameArray.count)
//        messageLabelArray = [UILabel](repeating: UILabel.init(), count: nameArray.count)
//
//        print("0..............hi")
//        placeInfo()
    }
    
    
    // Get data and store in arrays (Paul)
    func getInfo(){
        nameArray = defaults.stringArray(forKey: "nameArray") ?? []
        
        //Potential Error Hiding
        if defaults.array(forKey: "networkCallsArray") == nil || defaults.array(forKey: "networkCallsArray")!.count == 0 {
            networkCallsArray = [Int](repeating: 0, count: nameArray.count)
            defaults.set(networkCallsArray, forKey: "networkCallsArray")
            print(networkCallsArray)
        }
        networkCallsArray = defaults.array(forKey: "networkCallsArray") as! [Int]
        
        //Potential Error Hiding
        if defaults.array(forKey: "networkMessagesArray") == nil || defaults.array(forKey: "networkMessagesArray")!.count == 0 {
            networkMessagesArray = [Int](repeating: 0, count: nameArray.count)
            defaults.set(networkMessagesArray, forKey: "networkMessagesArray")
            print(networkMessagesArray)
        }
        networkMessagesArray = defaults.array(forKey: "networkMessagesArray") as! [Int]
        
    }
    
    // Update the text fields with data (Paul)
    func updateTF() {
        if callLabelArray.count < nameArray.count {
            updateLabel(callLabelArray.count)
        }
        var i = 0
        while i < nameArray.count {
            let callLabel = callLabelArray[i]
            callLabel.text = String(networkCallsArray[i])
            
            let messageLabel = messageLabelArray[i]
            messageLabel.text = String(networkMessagesArray[i])
            i += 1
        }
    }
    
    // Update Calls, messages number labels (Paul)
    func updateLabel(_ start : Int) {
        var i = start
        let width = self.view.frame.width - 30
        while i < nameArray.count {
            let nameLabel = UILabel(frame:CGRect(x:15, y:yposition, width: 130, height:33))
            nameLabel.textAlignment = .left
            nameLabel.text = nameArray[i]
            historyScroller.addSubview(nameLabel)
            
            let callLabel = UILabel(frame:CGRect(x:Int(width - 91), y:yposition, width: 50, height:33))
            callLabel.textAlignment = .left
            callLabel.text = String(networkCallsArray[i])
            historyScroller.addSubview(callLabel)
            callLabelArray.append(callLabel)
            
            
            let messageLabel = UILabel(frame:CGRect(x:Int(width - 33), y:yposition, width: 50, height:33))
            messageLabel.textAlignment = .left
            messageLabel.text = String(networkMessagesArray[i])
            historyScroller.addSubview(messageLabel)
            messageLabelArray.append(messageLabel)
            
            yposition += 40
            
            i += 1
        }
        historyScroller.contentSize.height = CGFloat(yposition)
    }
    
//    func placeInfo(){
////        var yposition = 60
//        var i = 0
//        while i < nameArray.count{
//            print(i)
//
//            let nameLabel = UILabel(frame:CGRect(x:44, y:yposition, width: 130, height:33))
//            nameLabel.textAlignment = .left
//            nameLabel.text = nameArray[i]
//            historyScroller.addSubview(nameLabel)
//
//            let callLabel = UILabel(frame:CGRect(x:210, y:yposition, width: 50, height:33))
//            callLabel.textAlignment = .left
//            print("Debugging temp")
//            print(networkCallsArray)
//            print(i)
//            callLabel.text = String(networkCallsArray[i])
//            historyScroller.addSubview(callLabel)
//            callLabelArray[i] = callLabel
//
//
//            let messageLabel = UILabel(frame:CGRect(x:274, y:yposition, width: 50, height:33))
//            messageLabel.textAlignment = .left
//            messageLabel.text = String(networkMessagesArray[i])
//            historyScroller.addSubview(messageLabel)
//            messageLabelArray[i] = messageLabel
//
//            yposition += 40
//
//            i += 1
//        }
        
        
        
        
        
        
        //        let label = UILabel(frame: CGRect(x:44, y:yContactsValue, width:66, height:33))
//        //label.center = CGPoint(x:44, y:146)
//        label.textAlignment = .center
//        label.text = "Name: "
//        self.view.addSubview(label)
//
//        let namelabel = UITextField(frame: CGRect(x:118, y:yContactsValue, width:272, height:33))
//        //namelabel.center = CGPoint(x:118, y:152)
//        namelabel.textAlignment = .center
//        namelabel.text = familyName
//        namelabel.backgroundColor = .white
//        self.view.addSubview(namelabel)
//
//        yContactsValue += 40
//
//        let label2 = UILabel(frame: CGRect(x:44, y:yContactsValue, width:166, height:33))
//        //label.center = CGPoint(x:44, y:146)
//        label2.textAlignment = .center
//        label2.text = "Contact Number: "
//        self.view.addSubview(label2)
//
//        let numlabel = UITextField(frame: CGRect(x:200, y:yContactsValue, width:150, height:33))
//        //namelabel.center = CGPoint(x:118, y:152)
//
//        numlabel.text = phoneNumber
//        numlabel.backgroundColor = .white
//        self.view.addSubview(numlabel)
//
//        yContactsValue += 40
//
//    }
    
}
