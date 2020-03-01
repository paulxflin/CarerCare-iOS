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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderView.layer.masksToBounds = true
        sliderView.layer.cornerRadius = 10.0
        wellBeingLabel.layer.masksToBounds = true
        wellBeingLabel.layer.cornerRadius = 10.0
        figuresView.layer.masksToBounds = true
        figuresView.layer.cornerRadius = 10.0
        
        instructionsView.layer.masksToBounds = true
        
        instructionsView.layer.cornerRadius = 10.0
        let predictedScore = defaults.integer(forKey: "score")
        scoreSlider.value = Float(predictedScore)
        scoreLabel.text = String(predictedScore)
        
        

        // Do any additional setup after loading the view.
        stepsLabel.text = String(defaults.integer(forKey: "oneWeekSteps"))
        callsLabel.text = String(defaults.integer(forKey: "totalCalls"))
        messagesLabel.text = String(defaults.integer(forKey: "totalMessages"))
    }
    
    @IBAction func savePressed(_ sender: Any) {
    
        let score : Int = Int(scoreLabel.text!)!
        print(score)
        
        //Small bit to calculate error rate, store in errorRate var.
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
        
        //Can Call a DB Submit at this point
        HomeViewController().sendDataToDB()
        
        //Update the scoresArray with this score.
        var scoresArray : [Int] = defaults.array(forKey: "scoresArray") as! [Int]
        scoresArray[0] = defaults.integer(forKey: "score")
        defaults.set(scoresArray, forKey: "scoresArray")
        
        let barSB : UIStoryboard = UIStoryboard(name: "MenuTabBar", bundle: nil)
        let barVC = barSB.instantiateViewController(withIdentifier: "tabBar")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = barVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
