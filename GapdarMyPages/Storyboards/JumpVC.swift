//
//  JumpVC.swift
//  GapdarMyPages
//
//  Created by Paul Lam on 25/2/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit

//ln 12-23 VC created for sole purpose to redirect the flow to intended VC, kind of hacky workaround.
class JumpVC: UIViewController {

    //ln 15-22 Immediately naviate to initial setup VC
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = mainSB.instantiateViewController(withIdentifier: "Setup")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = initialVC
        appDelegate?.window??.makeKeyAndVisible()
    }
}
