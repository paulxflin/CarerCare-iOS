//
//  SetUpViewController.swift
//  GapdarMyPages
//
//  Created by Paul Lam on 20/1/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var refTF: UITextField!
    @IBOutlet weak var postcodeTF: UITextField!
    @IBOutlet weak var stepsTF: UITextField!
    @IBOutlet weak var callsTF: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var persistLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 15.0 
        view.setGradientBackground()
        nameTF.delegate = self
        refTF.delegate = self
        postcodeTF.delegate = self
        stepsTF.delegate = self
        callsTF.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == nameTF) {
            defaults.set(textField.text, forKey: "firstName")
        } else if (textField == refTF) {
            defaults.set(textField.text, forKey: "reference")
        } else if (textField == postcodeTF) {
            defaults.set(textField.text, forKey: "postcode")
        } else if (textField == stepsTF) {
            defaults.set(textField.text, forKey: "targetSteps")
        } else if (textField == callsTF) {
            defaults.set(textField.text, forKey: "targetCalls")
        }
        
    }
    
    @IBAction func showPersistedPressed(_ sender: Any) {
        var msg: String
        msg = defaults.string(forKey: "firstName") ?? "No Name"
        msg += " "
        msg += defaults.string(forKey: "reference") ?? "No Ref"
        msg += " "
        msg += defaults.string(forKey: "postcode") ?? "No Postcode"
        msg += " "
        msg += defaults.string(forKey: "targetSteps") ?? "No Steps"
        msg += " "
        msg += defaults.string(forKey: "targetCalls") ?? "No Calls"
        persistLabel.text = msg
        
        
//        persistLabel.text = defaults.string(forKey: "firstName") + " " + defaults.string(forKey: "reference") + " " + defaults.string(forKey: "postcode") + " " + defaults.string(forKey: "targetSteps") + " " + defaults.string(forKey: "targetCalls")
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
