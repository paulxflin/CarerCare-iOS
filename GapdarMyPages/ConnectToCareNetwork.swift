//
//  connectToCareNetwork.swift
//  GapdarMyPages
//
//  Created by localadmin on 30/01/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import Foundation
import UIKit

class ConnectToCareNetwork: UIViewController {
    //ln 14 link the tick cross view from sb to code
    @IBOutlet weak var viewTickCros: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ln 19-20 setup UI
        viewTickCros.layer.masksToBounds = true
        viewTickCros.layer.cornerRadius = 10.0
    }
    
    //ln 25-31 Navigate back to home when X pressed (Paul)
    @IBAction func crossPressed(_ sender: UIButton) {
        let barSB : UIStoryboard = UIStoryboard(name: "MenuTabBar", bundle: nil)
        let barVC = barSB.instantiateViewController(withIdentifier: "tabBar")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = barVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
}
