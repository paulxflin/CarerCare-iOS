//
//  StepsStatisticsViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 04/02/2020.
//  Copyright © 2020 localadmin. All rights reserved.
//

import UIKit
import Charts
import Foundation

class StepsStatisticsViewController:UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var graphTitleLabel: UILabel!
    
    @IBOutlet weak var chartView: CombinedChartView!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var changingLabel: rotateLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.hidesBackButton = true
        Graph(chartView: chartView, type: "stepsArray").setChartData()
        chartView.backgroundColor = .white
        chartView.layer.cornerRadius = 10.0
        chartView.clipsToBounds = true
    }
    
    

    
  
    @IBAction func callsButtonPressed(_ sender: Any) {
        titleLabel.text = "Calls vs Well-being"
        graphTitleLabel.text = "Calls made and Well-being"
        changingLabel.text = "Number of Calls"
        Graph(chartView: chartView, type: "callsArray").setChartData()
    }
    
    @IBAction func outdoorButtonPressed(_ sender: Any) {
        titleLabel.text = "Steps vs Well-being"
        graphTitleLabel.text = "Outdoor steps and Well-being"
        changingLabel.text = "Number of Steps"
        Graph(chartView: chartView, type: "stepsArray").setChartData()
    }
    
    
    @IBAction func saveGraphPressed(_ sender: Any) {
        let image = self.chartView.AsImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

