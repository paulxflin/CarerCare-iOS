//
//  NewSetUpVC.swift
//  GapdarMyPages
//
//  Created by Paul Lam on 24/2/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit
import HealthKit
import UserNotifications

class NewSetUpVC: UIViewController {
    
    let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Request Permissions for Healthkit Steps (Paul)
        let readType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        healthStore.requestAuthorization(toShare: [], read: [readType]) { _, _ in }
        
        //Request Permission for Notifications (Paul)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})

        // Do any additional setup after loading the view.
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
