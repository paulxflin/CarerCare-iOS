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
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func slider(_ sender: UISlider) {
        scoreLabel.text = String(Int(sender.value))
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePressed(_ sender: Any) {
        let score : Int = Int(scoreLabel.text!)!
        print(score)
        defaults.set(score, forKey: "score")
        
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
