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
    


}

