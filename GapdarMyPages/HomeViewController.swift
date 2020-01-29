//
//  ViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 07/12/2019.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let label = UILabel()
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var sharingSwitch: UISwitch!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func slider(_ sender: UISlider) {
        scoreLabel.text = String(Int(sender.value))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func sharingSwitchPressed(_ sender: Any) {
        defaults.set(sharingSwitch.isOn, forKey: "allowShare")
        //Debugging
        //print(defaults.bool(forKey: "allowShare"))
        
    }
    
    @IBAction func trackingPressed(_ sender: Any) {
        setupHistory()
        let setup = true
        defaults.set(setup, forKey: "setup")
        
    }
    
    func setupHistory() {
        if defaults.array(forKey: "callsArray") == nil {
            let callsArray = [Int](repeating: 0, count: 12)
            defaults.set(callsArray, forKey: "callsArray")
            print(callsArray)
        }
        if defaults.array(forKey: "stepsArray") == nil {
            let stepsArray = [Int](repeating: 0, count: 12)
            defaults.set(stepsArray, forKey: "stepsArray")
            print(stepsArray)
        }
    }
    

}

