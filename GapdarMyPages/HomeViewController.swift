//
//  ViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 07/12/2019.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scoreView: UIView!
    //    let label = UILabel()
    
    @IBOutlet weak var figuresView: UIView!
    
    @IBOutlet weak var btSendJSON: UIButton!
    
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var displayedScoreLabel: UILabel!
    
    @IBOutlet weak var wellBeingLabel: UILabel!
    
    @IBOutlet weak var backgroundLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreView.layer.masksToBounds = true
        scoreView.layer.cornerRadius = 10.0
        wellBeingLabel.layer.cornerRadius = 10.0
        wellBeingLabel.layer.masksToBounds = true
        figuresView.layer.masksToBounds = true
        figuresView.layer.cornerRadius = 10.0
                backgroundLabel.layer.cornerRadius = backgroundLabel.layer.bounds.height / 2
                backgroundLabel.layer.masksToBounds = true
                let newLayer = CAGradientLayer()
                newLayer.frame = backgroundLabel.bounds
                newLayer.colors = [UIColor(red: 164/255.0, green: 200/255.0, blue: 255/255.0, alpha: 1.0).cgColor, UIColor(red: 17/255.0, green: 40/255.0, blue: 123/255.0, alpha: 1.0).cgColor]
                newLayer.locations = [0.0, 1.0]
                newLayer.startPoint = CGPoint(x:1.0, y:0.0)
                newLayer.endPoint = CGPoint(x:0.0, y:0.0)
                backgroundLabel.layer.addSublayer(newLayer)        // Do any additional setup after loading the view, typically from a nib.
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
        //order of json does not matter, All String Data
        //double quotes for strings don't usually show up, but it is there.
        let Dictionary : [String: String] = ["supportCode": defaults.string(forKey: "reference")! , "wellBeingScore": defaults.string(forKey: "score")! , "weeklySteps": defaults.string(forKey: "oneWeekSteps")! , "weeklyCalls": defaults.string(forKey: "totalCalls")! , "errorRate": "errorRate_example" ,  "postCode": defaults.string(forKey: "postcode")! , "date" : "01012020"]
        
        
        let JSON = self.foundationToJSON(object: Dictionary)
        let Foundation = self.JSONToFoundation(object: JSON)
        print(Foundation)
        debugPrint(Foundation)
        
        
        Alamofire.request("http://", method: .post, parameters: Dictionary as Parameters, encoding: JSONEncoding.default, headers: [:])
        
        
    }
    
}

