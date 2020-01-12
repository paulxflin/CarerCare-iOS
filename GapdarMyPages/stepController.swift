//
//  stepController.swift
//  steps
//
//  Created by Mac Mini on 12/28/19.
//  Copyright © 2019 Mac Mini. All rights reserved.
//

import UIKit
import HealthKit


class stepController: UIViewController {
    let healthStore = HKHealthStore()
    
    
    @IBOutlet weak var lbStep: UILabel!
    @IBOutlet weak var btUpdate: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.lbStep.text = "None"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getStepsCount(forSpecificDate:Date,completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
    }
    
    
    @IBAction func btPressed(_ sender: Any) {
        self.getStepsCount(forSpecificDate: Date()) { (steps) in
            if steps == 0.0 {
                self.lbStep.text =  "\(steps)"
            }
            else {
                DispatchQueue.main.async {
                    self.lbStep.text =  "\(steps)"
                }
            }
        }
    }
}
