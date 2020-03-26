//
//  PermissionsViewController.swift
//  GapdarMyPages
//
//  Created by Paul Lam on 29/1/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit

class PermissionsViewController: UIViewController {
    //ln 13 set up defaults to store data
    let defaults = UserDefaults.standard
    //ln 15-24 link ui components from storyboard to code
    @IBOutlet weak var startTracking: UIButton!
    
    @IBOutlet weak var viewTracking: UIView!
    
    
    @IBOutlet weak var viewScoreShare: UIView!
    
    @IBOutlet weak var sharingSwitch: UISwitch!
    
    @IBOutlet weak var saveBT: RoundButton!
    
    let newLayer = CAGradientLayer()
    
    //ln 29-31 setup variables to track user interactions
    var tracking = false
    var willResetHistory = false
    var trackingChanged = false
    
    //ln 34-44 Set up state of "Start tracking" button based on saved state (Paul)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
            // Do any additional setup after loading the view.
        tracking = defaults.bool(forKey: "tracking") // Returns false if tracking doesn't exist
        if !tracking {
            saveBT.isEnabled = false
        } else {
            //Case where is app is already tracking
            sharingSwitch.isOn = defaults.bool(forKey: "allowShare")
        }
        

    }
    
    
    //ln 51-57 sets ui (Karunya)
    func setUI(){
        view.setGradientBackground()
        viewTracking.layer.cornerRadius = 15.0
        viewScoreShare.layer.cornerRadius = 15.0
        viewScoreShare.layer.borderWidth = 5.0
        viewScoreShare.layer.borderColor = UIColor.white.cgColor
    }
    
    //ln 60-65 Ensures the buttton is circular (Karunya)
    override func viewWillLayoutSubviews() {
        let width = startTracking.frame.width
        startTracking.layer.cornerRadius = width/2
        setTrackingButton(isTracking: tracking)
        
    }
    
    
    // ln 69-83 Changes the tracking button to stop or to start (Karunya and Paul)
    @IBAction func trackingPressed(_ sender: Any) {
        if !tracking{
            tracking = true
            trackingChanged = true
        }
        else{
            tracking = false
            willResetHistory = true
        }
        defaults.set(tracking, forKey: "tracking")
        saveBT.isEnabled = tracking
        setTrackingButton(isTracking: tracking)
        
        
    }
    
    //ln 86-104 Navigate to rate WB page or home page (Paul)
    @IBAction func saveButtonPressed(_ sender: Any) {
        setupHistory()
        let setup = true
        defaults.set(setup, forKey: "setup")
        
        //ln 92 save sharing state here
        defaults.set(sharingSwitch.isOn, forKey: "allowShare")
        
        let barSB : UIStoryboard = UIStoryboard(name: "MenuTabBar", bundle: nil)
        var VC = barSB.instantiateViewController(withIdentifier: "tabBar")
        if trackingChanged {
            let homeSB : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            VC = homeSB.instantiateViewController(withIdentifier: "adjust")
        }
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = VC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
    //ln 106-154 setup or clear arrays storing data as appropriate (Paul)
    func setupHistory() {
        if defaults.array(forKey: "callsArray") == nil || willResetHistory {
            let callsArray = [Int](repeating: 0, count: 12)
            defaults.set(callsArray, forKey: "callsArray")
            print(callsArray)
        }
        if defaults.array(forKey: "stepsArray") == nil || willResetHistory{
            let stepsArray = [Int](repeating: 0, count: 12)
            defaults.set(stepsArray, forKey: "stepsArray")
            print(stepsArray)
        }
        if defaults.array(forKey: "scoresArray") == nil || willResetHistory {
            let scoresArray = [Int](repeating: 0, count: 12)
            defaults.set(scoresArray, forKey: "scoresArray")
            print(scoresArray)
        }
        
        let activityArray = defaults.array(forKey: "activityArray")
        let size = activityArray?.count
        var activityCountArray = defaults.array(forKey: "activityCountArray")
        
        if activityCountArray == nil || willResetHistory {
            activityCountArray = [Int](repeating: 0, count: size ?? 0)
            defaults.set(activityCountArray, forKey: "activityCountArray")
        }
        print("activity count array")
        print(activityCountArray ?? "This array doesn't exist")
        
        //ln 135-149 Reset more stored data here
        if willResetHistory {
            //Clear the current accumulations for steps, calls, and messages
            defaults.set(0, forKey: "oneWeekSteps")
            defaults.set(0, forKey: "totalCalls")
            defaults.set(0, forKey: "totalMessages")
            
            //ln 142-148 Clear Network Calls and Msgs
            var networkCallsArray = defaults.array(forKey: "networkCallsArray") as! [Int]
            networkCallsArray = [Int](repeating: 0, count: networkCallsArray.count)
            defaults.set(networkCallsArray, forKey: "networkCallsArray")
            
            var networkMessagesArray = defaults.array(forKey: "networkMessagesArray") as! [Int]
            networkMessagesArray = [Int](repeating: 0, count: networkMessagesArray.count)
            defaults.set(networkMessagesArray, forKey: "networkMessagesArray")
        }
        
        //ln 152-153 Do a quick update of weekly Steps Here.
        let VC = stepController()
        VC.getThisWeekSteps()
    }
    
    
    //ln 158-179 sets tracking button colour to blue or green (Karunya)
    func setTrackingButton(isTracking: Bool){
        //160 checks removes current colour; 161 ensures that the gradient background covers all of the button; 162-172 checks what state tracking is and sets the texts and colours accordingly
        startTracking.layer.sublayers?[0].removeFromSuperlayer()
        newLayer.frame = startTracking.bounds
        if tracking{
            startTracking.setTitle("Stop tracking", for: .normal)
            newLayer.colors = [UIColor(red: 164/255.0, green: 200/255.0, blue: 255/255.0, alpha: 1.0).cgColor, UIColor(red: 17/255.0, green: 40/255.0, blue: 123/255.0, alpha: 1.0).cgColor]
            
        }
        else{
            startTracking.setTitle("Start tracking", for: .normal)
            newLayer.colors = [UIColor(red: 16/255.0, green: 94/255.0, blue: 103/255.0, alpha: 1.0).cgColor, UIColor(red: 26/255.0, green: 154/255.0, blue: 169/255.0, alpha: 1.0).cgColor]
            
        }
        
        //174 sets position of the button to the center, endpoint changes the direction the gradient goes down; 178-180 adds the updated colour on
        newLayer.locations = [0.0, 1.0]
        newLayer.startPoint = CGPoint(x:0.0, y:0.0)
        newLayer.endPoint = CGPoint(x:0.0, y:1.0)
        
        startTracking.layer.masksToBounds = true
        startTracking.layer.insertSublayer(newLayer, at: 0)
        startTracking.setNeedsDisplay()
        
    }
    
    //ln 182-186 navigate to privacy policy site when link pressed
    @IBAction func privacyLinkPressed(_ sender: Any) {
        
        guard let url = URL(string: "https://www.torfaen.gov.uk/en/AboutTheCouncil/DataProtectionFreedomofInformation/DataProtection/Privacy-Notice/PrivacyNotice.aspx") else {return}
        UIApplication.shared.open(url)
    }
    
    //ln 189-195 navigate to initial setup page when No Thanks button is pressed
    @IBAction func noThanksPressed(_ sender: UIButton) {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = mainSB.instantiateViewController(withIdentifier: "Setup")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = initialVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
    
}
