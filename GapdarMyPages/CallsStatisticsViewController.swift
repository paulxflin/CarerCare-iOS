//
//  StatisticsViewController.swift
//  GapdarMyPages
//
//  Created by localadmin on 28/12/2019.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
import Charts
import Foundation

class CallsStatisticsViewController: UIViewController, ChartViewDelegate{

    
    let defaults = UserDefaults.standard
    
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
        self.navigationItem.hidesBackButton = true
        
        // MARK: General
        chartView.delegate = self
        chartView.drawGridBackgroundEnabled = false
        chartView.drawBordersEnabled = false
        chartView.drawBarShadowEnabled      = false
        chartView.highlightFullBarEnabled   = false
        chartView.drawOrder                 = [DrawOrder.bar.rawValue,  DrawOrder.line.rawValue]
        
        // MARK: xAxis
        let xAxis                           = chartView.xAxis
        xAxis.labelPosition                 = .bothSided
        xAxis.axisMinimum                   = 0.0
        xAxis.granularity                   = 1.0
        
        xAxis.centerAxisLabelsEnabled = true
        xAxis.setLabelCount( 9, force: true)
        
        // MARK: leftAxis
        let leftAxis                        = chartView.leftAxis
        leftAxis.drawGridLinesEnabled       = false
        leftAxis.axisMinimum                = 0.0
        
        
        // MARK: rightAxis
        let rightAxis                       = chartView.rightAxis
        rightAxis.drawGridLinesEnabled      = false
        rightAxis.axisMinimum               = 0.0
       
        
        
        // MARK: legend
        let legend                          = chartView.legend
        legend.wordWrapEnabled              = true
        legend.horizontalAlignment          = .center
        legend.verticalAlignment            = .bottom
        legend.orientation                  = .horizontal
        legend.drawInside                   = false
        
        // MARK: description
        chartView.chartDescription?.enabled = false
        
        setChartData()
        chartView.backgroundColor = .white
        chartView.layer.cornerRadius = 10.0
        chartView.clipsToBounds = true
    }
    
    func setChartData()
    {
        let data = CombinedChartData()
        data.lineData = generateLineData()
        data.barData = generateBarData()
        chartView.xAxis.axisMaximum = data.xMax + 0.25
        chartView.data = data
    }
    
    func getSubArray(_ array : [Int], _ numElems : Int) -> [Int] {
        var finalArr = [Int](repeating: 0, count: numElems)
        var i = 0
        while i < numElems {
            finalArr[i] = array[i]
            i += 1
        }
        return finalArr
    }
    
    
    func generateLineData() -> LineChartData
    {
        // MARK: ChartDataEntry
        var entries = [ChartDataEntry]()
        
        let scoresArray : [Int] = defaults.array(forKey: "scoresArray") as! [Int]
        let n = 9
        let wellBeingValues : [Int] = getSubArray(scoresArray, n)
        
        //var wellBeingValues: [Int]=[3,5,4,4,9,4,7,6,8]
        
        for index in 0..<ITEM_COUNT
        {
            entries.append(ChartDataEntry(x: Double(index) + 0.5, y: Double(wellBeingValues[index])))
        }
        
        // MARK: LineChartDataSet
        let set = LineChartDataSet(values: entries, label: "Well-being score")
        set.colors = [#colorLiteral(red: 0.941176470588235, green: 0.933333333333333, blue: 0.274509803921569, alpha: 1.0)]
        set.lineWidth = 2.5
        set.circleColors = [#colorLiteral(red: 0.941176470588235, green: 0.933333333333333, blue: 0.274509803921569, alpha: 1.0)]
        set.circleHoleRadius = 2.5
        set.fillColor = #colorLiteral(red: 0.941176470588235, green: 0.933333333333333, blue: 0.274509803921569, alpha: 1.0)
        set.drawValuesEnabled = true
        set.valueFont = NSUIFont.systemFont(ofSize: CGFloat(10.0))
        set.valueTextColor = #colorLiteral(red: 0.941176470588235, green: 0.933333333333333, blue: 0.274509803921569, alpha: 1.0)
        set.axisDependency = .left
        
        // MARK: LineChartData
        let data = LineChartData()
        data.addDataSet(set)
        
        
        return data
    }
    
    func generateBarData() -> BarChartData
    {
        // MARK: BarChartDataEntry
        var entries1 = [BarChartDataEntry]()
        
        let callsArray : [Int] = defaults.array(forKey: "callsArray") as! [Int]
        let n = 9
        let callsData : [Int] = getSubArray(callsArray, n)
        print("Calls Data: ")
        print(callsData)
        
        //var callsData: [Int] = [4,10,7,15,20,23,20,13,21]
        
        for index in 0..<ITEM_COUNT
        {
            entries1.append(BarChartDataEntry(x: Double(index) + 0.5, y: Double(callsData[index])))
            
        }
        
        // MARK: BarChartDataSet
        let set1            = BarChartDataSet(values: entries1, label: "Calls made")
        set1.colors         = [#colorLiteral(red: 0.5224176645, green: 0.5228312612, blue: 0.5224817395, alpha: 1)]
        set1.valueTextColor = #colorLiteral(red: 0.5208604336, green: 0.5208604336, blue: 0.5208604336, alpha: 1)
        set1.valueFont      = NSUIFont.systemFont(ofSize: CGFloat(10.0))
        set1.axisDependency = .right
        
        
        
        // MARK: BarChartData
        
        let barWidth = 0.46
        
        // x2 dataset
        // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
        let data = BarChartData(dataSet: set1)
        data.barWidth = barWidth
        
        return data
    }
    
    
    
    
    
    
    
    
}

