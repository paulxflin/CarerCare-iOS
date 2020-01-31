//
//  ViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 07/12/2019.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
//    let label = UILabel()
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var displayedScoreLabel: UILabel!
    
    @IBOutlet weak var btSendJSON: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayedScoreLabel.text = String(defaults.integer(forKey: "score"))
    }
    
    func foundationToJSON(object:Any) -> Data {
        if !JSONSerialization.isValidJSONObject(object)
        {
            print("invalid01")
            return Data.init()
        }
        return try! JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
    }
    
    func JSONToFoundation(object:Data) -> Any {
        if JSONSerialization.isValidJSONObject(object)
        {
            print("invalid02")
            return NSNull.init()
        }
        return try! JSONSerialization.jsonObject(with: object, options:.mutableContainers)
    }
    
    @IBAction func btSendJSONPressed(_ sender: Any) {
        let Dictionary = ["postcode": defaults.string(forKey: "postcode") , "score": defaults.string(forKey: "score") , "errorRate": "errorRate_example"]
        let JSON = self.foundationToJSON(object: Dictionary)
        let Foundation = self.JSONToFoundation(object: JSON)
        print(Foundation)
    }
}

