//
//  StatisticsViewController.swift
//  GapdarMyPages
//
//  Created by Karunya on 28/12/2019.
//  Copyright © 2019 Karunya. All rights reserved.
//

import UIKit
import Charts
import Foundation

class CallsStatisticsViewController: UIViewController{

   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var changingAxisLabel: rotateLabel!
    
    @IBOutlet weak var graphTitleLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var stepButton: UIButton!
    
    @IBOutlet weak var callButton: UIButton!
    
    //@IBOutlet weak var chartView: CombinedChartView!
    @IBOutlet weak var chartView: CombinedChartView!
    //var stepsTakenGraph: UIView!
    //var wellBeingScoreGraph: UIView!
    let weeks = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    let ITEM_COUNT = 9
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.hidesBackButton = true
        Graph(chartView: chartView, type: "callsArray").setChartData()
        setUI()
    }
    
    //sets UI (Karunya)
    func setUI(){
        chartView.backgroundColor = .white
        chartView.layer.cornerRadius = 10.0
        chartView.clipsToBounds = true
    }
    

    // Get screenshot as PNG (Paul)
    func getCallsGraphImage() -> Data{
        let image = screenshotImage()
        let imageData : Data = image.pngData()!
        return imageData
    }

    // Saves screenshot to phone images (Paul)
    @IBAction func saveGraphPressed(_ sender: Any) {
        let image = screenshotImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    // Gets Screenshot (Paul)
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
    
    //Swaps the graphs (Karunya)
    @IBAction func outdoorButtonPressed(_ sender: Any) {
        titleLabel.text = "Steps vs Well-being"
        changingAxisLabel.text = "Number of Steps"
        graphTitleLabel.text = "Outdoor steps and Well-being"
        Graph(chartView: chartView, type: "stepsArray").setChartData()
    }
    
    //Swaps the graphs (Karunya)
    @IBAction func callsButtonPressed(_ sender: Any) {
        titleLabel.text = "Calls vs Well-being"
        graphTitleLabel.text = "Calls made and Well-being"
        changingAxisLabel.text = "Number of Calls"
        Graph(chartView: chartView, type: "callsArray").setChartData()
    }
}

extension UIView
{
    func AsImage() -> UIImage
    {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image{UIGraphicsRendererContext in layer.render(in: UIGraphicsRendererContext.cgContext)}
    }
}
