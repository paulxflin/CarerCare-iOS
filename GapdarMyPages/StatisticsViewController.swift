//
//  StatisticsViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 28/12/2019.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit



class StatisticsViewController: UIViewController {

    
    
    @IBOutlet weak var graphContainer: UIView!
    var graphViews: [UIView]!
    //var stepsTakenGraph: UIView!
    //var wellBeingScoreGraph: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphViews = [UIView]()//initialises it
        graphViews.append(StepsTakenGraph().view)
        graphViews.append(WellBeingScoreGraph().view)
        for view in graphViews{
            graphContainer.addSubview(view)
        }
        graphContainer.bringSubviewToFront(graphViews[0])
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func GraphSwitch(_ sender: UISegmentedControl) {
        self.graphContainer.bringSubviewToFront(graphViews[sender.selectedSegmentIndex])
        
        
    }
    
    
    
    
}
