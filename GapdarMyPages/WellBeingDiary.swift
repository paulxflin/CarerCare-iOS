//
//  WellBeingDiary.swift
//  GapdarMyPages
//
//  Created by Karunya on 04/02/2020.
//  Copyright © 2020 Karunya. All rights reserved.
//

import Foundation
import UIKit
import Charts

class WellBeingDiary:UIViewController, UIGestureRecognizerDelegate{

    @IBOutlet weak var callsChartView: CombinedChartView!
    
    @IBOutlet weak var stepsChartView: CombinedChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapRecogniser()
        setUI()
    }
    
    //Calls the function to draw the graphs and to make it more aesthetic (Karunya)
    func setUI(){
        Graph(chartView: callsChartView, type: "callsArray").setChartData()
        callsChartView.layer.cornerRadius = 10.0
        callsChartView.backgroundColor = .white
        callsChartView.clipsToBounds = true
        
        Graph(chartView: stepsChartView, type: "stepsArray").setChartData()
        stepsChartView.layer.cornerRadius = 10.0
        stepsChartView.backgroundColor = .white
        stepsChartView.clipsToBounds = true
        
    }
    
    //Allows code to detect if one of the graphs on the well-being diary page was clicked (Karunya)
    func setTapRecogniser(){
        callsChartView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target:self, action: #selector(self.callCallsPage))
        gesture.delegate = self
        callsChartView.addGestureRecognizer(gesture)
        gesture.numberOfTapsRequired = 1
        
        stepsChartView.isUserInteractionEnabled = true
        let stepGesture = UITapGestureRecognizer(target:self, action: #selector(self.callStepsPage))
        stepGesture.delegate = self
        stepsChartView.addGestureRecognizer(stepGesture)
        stepGesture.numberOfTapsRequired = 1
        
    }
    
    //Changes page to the callsGraph page (Karunya)
    @objc func callCallsPage(_sender:UITapGestureRecognizer){
        print("it is being clicked")
        self.performSegue(withIdentifier: "callGraph", sender: self)
    }
    
    //Changes page to the stepsCall page (Karunya)
    @objc func callStepsPage(_sender:UITapGestureRecognizer){
        print("it is being clicked")
        self.performSegue(withIdentifier: "stepsCall", sender: self)
    }
    
    
    @IBAction func sharePressed(_ sender: UIButton) {
        let messagesSB : UIStoryboard = UIStoryboard(name: "Messages", bundle: nil)
        let composeVC = messagesSB.instantiateViewController(withIdentifier: "nudge")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = composeVC
        appDelegate?.window??.makeKeyAndVisible()
    }
    
    // Get Screenshot of the WBDiary (Paul)
    func getDiaryImage() -> Data {
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
        let imageData : Data = image!.pngData()!
        return imageData
    }
    
}
