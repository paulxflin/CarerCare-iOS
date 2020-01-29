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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let instance = AppDelegate()
        instance.window?.rootViewController = self
        instance.window?.makeKeyAndVisible()
        displayedScoreLabel.text = String(defaults.integer(forKey: "score"))
    }
    
}

