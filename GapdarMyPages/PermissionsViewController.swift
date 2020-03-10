//
//  PermissionsViewController.swift
//  GapdarMyPages
//
//  Created by Paul Lam on 29/1/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit

class PermissionsViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var startTracking: UIButton!
    
    @IBOutlet weak var viewTracking: UIView!
    
    
    @IBOutlet weak var viewScoreShare: UIView!
    
    @IBOutlet weak var sharingSwitch: UISwitch!
    
    var tracking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        viewTracking.layer.cornerRadius = 15.0
        viewScoreShare.layer.cornerRadius = 15.0
        viewScoreShare.layer.borderWidth = 5.0
        viewScoreShare.layer.borderColor = UIColor.white.cgColor
        
        startTracking.layer.masksToBounds = true
        let newLayer = CAGradientLayer()
        newLayer.frame = startTracking.bounds
        //newLayer.colors = [UIColor(red: 16/255.0, green: 94/255.0, blue: 103/255.0, alpha: 1.0).cgColor, UIColor(red: 26/255.0, green: 154/255.0, blue: 169/255.0, alpha: 1.0).cgColor]
         newLayer.colors = [UIColor(red: 164/255.0, green: 200/255.0, blue: 255/255.0, alpha: 1.0).cgColor, UIColor(red: 17/255.0, green: 40/255.0, blue: 123/255.0, alpha: 1.0).cgColor]
        newLayer.locations = [0.0, 1.0]
        newLayer.startPoint = CGPoint(x:0.0, y:1.0)
        newLayer.endPoint = CGPoint(x:0.0, y:0.0)
        startTracking.layer.insertSublayer(newLayer, at: 0)
        
        
        
        
            // Do any additional setup after loading the view.
    }
    
    
    override func viewWillLayoutSubviews() {
        startTracking.layer.masksToBounds = true
        let width = startTracking.frame.width
        
        startTracking.frame.size = CGSize(width: width, height:  width )
        let height = startTracking.frame.height
        
        
        print("width:", width, "height", height)
        startTracking.layer.cornerRadius = width/2


    }
    
    @IBAction func trackingPressed(_ sender: Any) {
        setupHistory()
        let setup = true
        defaults.set(setup, forKey: "setup")
        
        let homeSB : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let VC = homeSB.instantiateViewController(withIdentifier: "adjust")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = VC
        appDelegate?.window??.makeKeyAndVisible()
        
    }
    
    @IBAction func sharingSwitchPressed(_ sender: Any) {
        defaults.set(sharingSwitch.isOn, forKey: "allowShare")
        
        let height = startTracking.frame.height
        
        let width = startTracking.frame.width
        
        print("width:", width, "height", height)
        //Debugging
        //print(defaults.bool(forKey: "allowShare"))
        
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
        if defaults.array(forKey: "scoresArray") == nil {
            let scoresArray = [Int](repeating: 0, count: 12)
            defaults.set(scoresArray, forKey: "scoresArray")
            print(scoresArray)
        }
        
        let activityArray = defaults.array(forKey: "activityArray")
        let size = activityArray?.count
        var activityCountArray = defaults.array(forKey: "activityCountArray")
        if activityCountArray == nil {
            activityCountArray = [Int](repeating: 0, count: size ?? 0)
            defaults.set(activityCountArray, forKey: "activityCountArray")
        }
        print("activity count array")
        print(activityCountArray ?? "This array doesn't exist")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func privacyLinkPressed(_ sender: Any) {
        
        guard let url = URL(string: "https://www.torfaen.gov.uk/en/AboutTheCouncil/DataProtectionFreedomofInformation/DataProtection/Privacy-Notice/PrivacyNotice.aspx") else {return}
        UIApplication.shared.open(url)
    }
    
    
}
