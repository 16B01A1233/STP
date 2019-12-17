//
//  QualityReports.swift
//  STP
//
//  Created by DVNAGARAJU on 02/03/19.
//  Copyright © 2019 SVECW-5. All rights reserved.
//

import UIKit
import Charts
class QualityReports: UIViewController {
    var refMainDashboard:MainDashboard!
    var refQualityReports:QualityReports!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let days = ["mon","tues","wed","thur","fri","sat","sun"]
        let tasks = [9.0,2.0,3.0,2.0,5.0,6.0,7.0]
        let tasks1 = [10.0,12.0,13.0,12.0,15.01,16.0,17.0]
        setChart(dataPoints:days,values:tasks,values1:tasks1)
        
    }
    
    func setChart(dataPoints:[String],values:[Double],values1:[Double]) {
        
        lineChartView.noDataText = "no data available"
        var dataEntries : [ChartDataEntry] = []
        var dataEntries1 : [ChartDataEntry] = []
        for i in 0..<dataPoints.count{
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            let dataEntry1 = ChartDataEntry(x: Double(i), y: values1[i] )
            dataEntries.append(dataEntry)
            dataEntries1.append(dataEntry1)
        }
        let set1  = LineChartDataSet(values: dataEntries, label: "Raw")
        set1.axisDependency = .left
        set1.setColor(UIColor.red.withAlphaComponent(0.5))
        set1.setCircleColor(UIColor.red)
        set1.lineWidth = 2.0
        set1.circleRadius = 3.0
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.red
        set1.highlightColor = UIColor.white
        set1.drawCircleHoleEnabled = true
        
        
        let set2: LineChartDataSet = LineChartDataSet(values: dataEntries1, label:"Treated")
        set2.axisDependency = .left // Line will correlate with left axis values
        set2.setColor(UIColor.green.withAlphaComponent(0.5))
        set2.setCircleColor(UIColor.green)
        set2.lineWidth = 2.0
        set2.circleRadius = 3.0
        set2.fillAlpha = 65 / 255.0
        set2.fillColor = UIColor.green
        set2.highlightColor = UIColor.white
        set2.drawCircleHoleEnabled = true
        
        
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)
        
        // let data: LineChartData = LineChartData(xVals:dataPoints, dataSets: dataSets)
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.white)
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.lineChartView.data = data
        
    }

}
