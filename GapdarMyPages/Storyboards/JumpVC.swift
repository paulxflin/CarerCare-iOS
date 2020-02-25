//
//  JumpVC.swift
//  GapdarMyPages
//
//  Created by Paul Lam on 25/2/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit

class JumpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = mainSB.instantiateViewController(withIdentifier: "Setup")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = initialVC
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
