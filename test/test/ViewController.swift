//
//  ViewController.swift
//  test
//
//  Created by Mac Mini on 12/7/19.
//  Copyright © 2019 Mac Mini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var label03: UILabel!
    @IBOutlet weak var label04: UILabel!
    @IBOutlet weak var text01: UITextField!
    @IBOutlet weak var text02: UITextField!
    @IBOutlet weak var text03: UITextField!
    @IBOutlet weak var switch01: UISwitch!
    @IBOutlet weak var upload: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let decoded = UserDefaults.standard.object(forKey: "encodedData") as! userData
        let decodedUser = NSKeyedUnarchiver.unarchivedObject(ofClasses: userData, from: decoded)
        label01.text = "Ref1:"
        label02.text = "Ref2:"
        label03.text = "PostCode:"
        label04.text = "L.D.P"
        text01.text = "please enter ref1"
        text02.text = "please enter ref2"
        text03.text = "please enter postcode"
        upload.setTitle("upload", for: UIControl.State.normal)
        
        
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        let userdata = userData.init(x: label01.text ?? "ref1", y: label02.text ?? "ref2", z: label03.text ?? "postcode")
        do{
            let encoded = try NSKeyedArchiver.archivedData(withRootObject: userdata, requiringSecureCoding: false)
            UserDefaults.standard.set(encoded, forKey: "encodedData")
        }
        catch{print(error)}
    }
}

