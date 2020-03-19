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
    
    
    @IBOutlet weak var titleLabel: rotateLabel!
    
    
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
    
    func getStepsGraphImage() -> Data {
        let image = screenshotImage()
        let imageData : Data = image.pngData()!
        return imageData
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
        let image = screenshotImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    func screenshotImage() -> UIImage {
        var image : UIImage?
        //To get a strict screenshot of keyView: UIApplication.shared.keyWindow!.layer
        //The current version gets an image of the ViewController
        let layer = self.view.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        layer.render(in: context!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //Use Screenshot (and if that doesn't exist use graph drawing)
        return image ?? self.chartView.AsImage()
    }
}

