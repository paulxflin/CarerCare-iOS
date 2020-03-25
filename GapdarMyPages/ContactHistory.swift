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
    
    //ln 15 setup variable to store data
    let defaults = UserDefaults.standard
    
    //ln 18-20 link UI components
    @IBOutlet weak var historyScroller: UIScrollView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var callsImage: UIImageView!
    
    //ln 23-25 arrays to store data
    var nameArray : [String] = []
    var networkCallsArray : [Int] = []
    var networkMessagesArray : [Int] = []
    
    //ln 28-29 arrays to store labels displaying data
    var callLabelArray : [UILabel]  = []
    var messageLabelArray : [UILabel]  = []
    
    //ln 32 set starting height of scrollview
    var yposition : Int = 60
    
    //ln 35-43 Get info and update data each time view opened (Paul)
    override func viewWillAppear(_ animated: Bool) {
        let width = self.view.frame.width - 30
        messageImage.frame = CGRect(x: width - 50, y:8, width:50, height:50)
        
        callsImage.frame = CGRect(x: width - 110, y:8, width:50, height:50)
        print("willAppear reached")
        getInfo()
        updateTF()
    }
    
    //ln 46-50 setup UI
    override func viewDidLoad() {
        super.viewDidLoad()
        historyScroller.layer.masksToBounds = true
        historyScroller.layer.cornerRadius = 10.0
    }
    
    
    //ln 54-72 Get data and store in arrays (Paul)
    func getInfo(){
        nameArray = defaults.stringArray(forKey: "nameArray") ?? []
        
        if defaults.array(forKey: "networkCallsArray") == nil || defaults.array(forKey: "networkCallsArray")!.count == 0 {
            networkCallsArray = [Int](repeating: 0, count: nameArray.count)
            defaults.set(networkCallsArray, forKey: "networkCallsArray")
            print(networkCallsArray)
        }
        networkCallsArray = defaults.array(forKey: "networkCallsArray") as! [Int]
        
        if defaults.array(forKey: "networkMessagesArray") == nil || defaults.array(forKey: "networkMessagesArray")!.count == 0 {
            networkMessagesArray = [Int](repeating: 0, count: nameArray.count)
            defaults.set(networkMessagesArray, forKey: "networkMessagesArray")
            print(networkMessagesArray)
        }
        networkMessagesArray = defaults.array(forKey: "networkMessagesArray") as! [Int]
    }
    
    //ln 75-88 Update the text fields with data (Paul)
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
    
    //ln 91-118 Update Calls, messages number labels (Paul)
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
}
