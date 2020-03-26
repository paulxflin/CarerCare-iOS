//
//  AdjustViewController.swift
//  GapdarMyPages
//
//  Created by Paul Lam on 29/1/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit

class AdjustViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var callsLabel: UILabel!
    @IBOutlet weak var messagesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var scoreSlider: UISlider!
    @IBOutlet weak var instructionsView: UIView!
    @IBAction func slider(_ sender: UISlider) {
        scoreLabel.text = String(Int(sender.value))
        
    }

    @IBOutlet weak var sliderView: UIView!
    
    
    @IBOutlet weak var wellBeingLabel: UILabel!
    
    @IBOutlet weak var figuresView: UIView!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    //ln 38-49 setup UI, setup data values, get predicted score and setup slider position and score (Paul)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        stepsLabel.text = String(defaults.integer(forKey: "oneWeekSteps"))
        callsLabel.text = String(defaults.integer(forKey: "totalCalls"))
        messagesLabel.text = String(defaults.integer(forKey: "totalMessages"))
        
        let predictedScore = getPredictedScore()
        scoreSlider.value = Float(predictedScore)
        scoreLabel.text = String(predictedScore)
    }
    
    //decorate UI (Karunya)
    //maskstobound ensures that the radius will curve, corner radius allows the square button, view to curve
    func setUI(){
        sliderView.layer.masksToBounds = true
        sliderView.layer.cornerRadius = 10.0
        wellBeingLabel.layer.masksToBounds = true
        wellBeingLabel.layer.cornerRadius = 10.0
        figuresView.layer.masksToBounds = true
        figuresView.layer.cornerRadius = 10.0
        instructionsView.layer.masksToBounds = true
        instructionsView.layer.cornerRadius = 10.0
    }
    
    @IBAction func savePressed(_ sender: Any) {
    
        let score : Int = Int(scoreLabel.text!)!
        print(score)
        
        //ln 69-77 Small bit to calculate error rate, store in errorRate var (Paul)
        let predictedScore = defaults.integer(forKey: "score")
        if score != 0 {
            let error : Double = Double(abs(predictedScore - score)) / Double(score) * 100
            let intError = Int(error)
            defaults.set(intError, forKey: "errorRate")
        } else {
            let intError = abs(predictedScore - score) * 10 //assuming in case 0 is rated, divide by 10.
            defaults.set(intError, forKey: "errorRate")
        }
        
        defaults.set(score, forKey: "score")
        
        //ln 82-84 Can Call a DB Submit at this point if share is enabled (Paul)
        if defaults.bool(forKey: "allowShare") {
            HomeViewController().sendDataToDB()
        }
        
        //ln 87 This function shifts the records or steps and calls to put current week into last week
        updateArrays()
        
        //ln 90-92 Update the scoresArray with this score (Paul)
        var scoresArray : [Int] = defaults.array(forKey: "scoresArray") as! [Int]
        scoresArray[0] = defaults.integer(forKey: "score")
        defaults.set(scoresArray, forKey: "scoresArray")
        
        //ln 95-99 navigate to HomeVC with tabbar (Paul)
        let barSB : UIStoryboard = UIStoryboard(name: "MenuTabBar", bundle: nil)
        let barVC = barSB.instantiateViewController(withIdentifier: "tabBar")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = barVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
    //ln 103-136, make a score prediction (Paul)
    func getPredictedScore() -> Int {
        let VC = stepController()
        VC.getThisWeekSteps()
        
        let weekSteps = defaults.integer(forKey: "oneWeekSteps")
        print("The weekSteps appears to be: " + String(weekSteps))
        let targetSteps = Int(defaults.string(forKey: "targetSteps") ?? "1000") ?? 1000
        let weekCalls = defaults.integer(forKey: "totalCalls")
        let targetCalls = Int(defaults.string(forKey: "targetCalls") ?? "3") ?? 3
        
        let avgSteps = Double(weekSteps)/7
        let avgCalls = Double(weekCalls)/7
        
        var stepsRatio : Double = Double(avgSteps)/Double(targetSteps)
        if stepsRatio > 1 {
            stepsRatio = 1.0
        }
        
        var callsRatio : Double = Double(avgCalls)/Double(targetCalls)
        if callsRatio > 1 {
            callsRatio = 1.0
        }
        
        let score : Double = (stepsRatio + callsRatio) / 2.0 * 10.0
        
        //ln 129 Record down the predicted score, if modified will update later.
        defaults.set(score, forKey: "score")
        
        if Int(score) > 10 {
            return 10
        }
        
        return Int(score)
    }
    
    //ln 139-178 update all the relevant arrays storing data
    func updateArrays() {
        // Structure: Index 0 corresponds to last week, Index 11 corresponds to 12 weeks ago (Paul)
        var callsArray : [Int] = defaults.array(forKey: "callsArray") as! [Int]
        var stepsArray : [Int] = defaults.array(forKey: "stepsArray") as! [Int]
        var scoresArray : [Int] = defaults.array(forKey: "scoresArray") as! [Int]
        var i = 11;
        while i > 0 {
            callsArray[i] = callsArray[i-1]
            stepsArray[i] = stepsArray[i-1]
            scoresArray[i] = scoresArray[i-1]
            i = i-1
        }
        //ln 152-154 Set last week's steps and calls (Paul)
        callsArray[0] = defaults.integer(forKey: "totalCalls")
        stepsArray[0] = defaults.integer(forKey: "oneWeekSteps")
        scoresArray[0] = defaults.integer(forKey: "score")
        
        //ln 157-159 Store the arrays (Paul)
        defaults.set(callsArray, forKey: "callsArray")
        defaults.set(stepsArray, forKey: "stepsArray")
        defaults.set(scoresArray, forKey: "scoresArray")
        print(callsArray)
        print(stepsArray)
        print(scoresArray)
        
        //ln 165-167 Clear the current accumulations for steps, calls, and messages, not scores because that remains (Paul)
        defaults.set(0, forKey: "oneWeekSteps")
        defaults.set(0, forKey: "totalCalls")
        defaults.set(0, forKey: "totalMessages")
        
        //ln 170-176 Clear Network Calls and Msgs (Paul)
        var networkCallsArray = defaults.array(forKey: "networkCallsArray") as! [Int]
        networkCallsArray = [Int](repeating: 0, count: networkCallsArray.count)
        defaults.set(networkCallsArray, forKey: "networkCallsArray")
        
        var networkMessagesArray = defaults.array(forKey: "networkMessagesArray") as! [Int]
        networkMessagesArray = [Int](repeating: 0, count: networkMessagesArray.count)
        defaults.set(networkMessagesArray, forKey: "networkMessagesArray")
        
    }
    
}
