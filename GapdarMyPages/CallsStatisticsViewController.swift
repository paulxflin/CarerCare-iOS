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

class CallsStatisticsViewController: UIViewController{

    
    
    
    //@IBOutlet weak var chartView: CombinedChartView!
    @IBOutlet weak var chartView: CombinedChartView!
    //var stepsTakenGraph: UIView!
    //var wellBeingScoreGraph: UIView!
    let weeks = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let ITEM_COUNT = 12
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: General
        chartView.delegate = self
        chartView.drawGridBackgroundEnabled = false
        chartView.drawBarShadowEnabled      = false
        chartView.highlightFullBarEnabled   = false
        chartView.drawOrder                 = [DrawOrder.bar.rawValue,  DrawOrder.line.rawValue]
        
        // MARK: xAxis
        let xAxis                           = chartView.xAxis
        xAxis.labelPosition                 = .bothSided
        xAxis.axisMinimum                   = 0.0
        xAxis.granularity                   = 1.0
        xAxis.valueFormatter                = BarChartFormatter()
        xAxis.centerAxisLabelsEnabled = true
        xAxis.setLabelCount( 12, force: true)
        
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
    }
    
    func setChartData()
    {
        let data = CombinedChartData()
        data.lineData = generateLineData()
        data.barData = generateBarData()
        chartView.xAxis.axisMaximum = data.xMax + 0.25
        chartView.data = data
    }
    
    
    func generateLineData() -> LineChartData
    {
        // MARK: ChartDataEntry
        var entries = [ChartDataEntry]()
        for index in 0..<ITEM_COUNT
        {
            entries.append(ChartDataEntry(x: Double(index) + 0.5, y: (Double(arc4random_uniform(15) + 5))))
        }
        
        // MARK: LineChartDataSet
        let set = LineChartDataSet(values: entries, label: "Line DataSet")
        set.colors = [#colorLiteral(red: 0.941176470588235, green: 0.933333333333333, blue: 0.274509803921569, alpha: 1.0)]
        set.lineWidth = 2.5
        set.circleColors = [#colorLiteral(red: 0.941176470588235, green: 0.933333333333333, blue: 0.274509803921569, alpha: 1.0)]
        set.circleHoleRadius = 2.5
        set.fillColor = #colorLiteral(red: 0.941176470588235, green: 0.933333333333333, blue: 0.274509803921569, alpha: 1.0)
        set.mode = .cubicBezier
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
        var entries2 = [BarChartDataEntry]()
        
        for _ in 0..<ITEM_COUNT
        {
            entries1.append(BarChartDataEntry(x: 0.0, y: (Double(arc4random_uniform(25) + 25))))
            // stacked
            entries2.append(BarChartDataEntry(x: 0.0, yValues: [Double(arc4random_uniform(13) + 12), Double(arc4random_uniform(13) + 12)]))
        }
        
        // MARK: BarChartDataSet
        let set1            = BarChartDataSet(values: entries1, label: "Bar 1")
        set1.colors         = [#colorLiteral(red: 0.235294117647059, green: 0.862745098039216, blue: 0.305882352941176, alpha: 1.0)]
        set1.valueTextColor = #colorLiteral(red: 0.235294117647059, green: 0.862745098039216, blue: 0.305882352941176, alpha: 1.0)
        set1.valueFont      = NSUIFont.systemFont(ofSize: CGFloat(10.0))
        set1.axisDependency = .left
        
        let set2            = BarChartDataSet(values: entries2, label: "Bar 2")
        set2.stackLabels    = ["Stack 1", "Stack 2"]
        set2.colors         = [#colorLiteral(red: 0.23921568627451, green: 0.647058823529412, blue: 1.0, alpha: 1.0),  #colorLiteral(red: 0.090196078431373, green: 0.772549019607843, blue: 1.0, alpha: 1.0)]
        set2.valueTextColor = #colorLiteral(red: 0.23921568627451, green: 0.647058823529412, blue: 1.0, alpha: 1.0)
        set2.valueFont      = NSUIFont.systemFont(ofSize: CGFloat(10.0))
        set2.axisDependency = .left
        
        // MARK: BarChartData
        let groupSpace = 0.06
        let barSpace = 0.01
        let barWidth = 0.46
        
        // x2 dataset
        // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
        let data = BarChartData(dataSets: [set1, set2])
        data.barWidth = barWidth
        // make this BarData object grouped
        data.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)     // start at x = 0
        return data
    }
    
    @IBAction func zoomAll(_ sender: AnyObject)
    {
        chartView.fitScreen()
    }
    
    @IBAction func zoomIn(_ sender: AnyObject)
    {
        chartView.zoomToCenter(scaleX: 1.5, scaleY: 1)
    }
    
    @IBAction func zoomOut(_ sender: AnyObject)
    {
        chartView.zoomToCenter(scaleX: 2/3, scaleY: 1)
    }
    
    
    
    
}

// MARK: - ChartViewDelegate
extension CallsStatisticsViewController: ChartViewDelegate
{
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        //       chartView.highlightValue(x: 0, dataSetIndex: 1)
        print("chartValueSelected : x = \(highlight.x)")
    }
    
    public func chartValueNothingSelected(_ chartView: ChartViewBase)
    {
        print("chartValueNothingSelected")
    }
    
    public class BarChartFormatter: NSObject, IAxisValueFormatter
    {
        var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String
        {
            let modu =  Double(value).truncatingRemainder(dividingBy: Double(months.count))
            return months[ Int(modu) ]
        }
    }
}
