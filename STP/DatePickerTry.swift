//
//  DatePickerTry.swift
//  STP
//
//  Created by DVNAGARAJU on 02/03/19.
//  Copyright © 2019 SVECW-5. All rights reserved.
//

import UIKit
import Charts

class DatePickerTry: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    var refMainDashboard:MainDashboard!
    var refDatePickerTry:DatePickerTry!
    
    let from = UIDatePicker()
    let to = UIDatePicker()
    let param = ["DO","PH","TDS","TEMP"]
    var tasks:[Double] = []
    var tasks1:[Double] = []
    var tasks2:[Double] = []
    var flag = 0;
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var parameterName: UILabel!
    @IBAction func DisplayGraph(_ sender: Any) {
        if flag == 0{
            errorLabel.text = "Select All Parameters!"
            errorLabel.textColor = UIColor.red
            
        }
        else{
//        let days = ["24/02","25/02","26/02","27/02","28/02","01/03","02/03"]
        let days = ["02/03/19","03/03/19"]
        if paramLabel.text == "DO"{
//             tasks = [14.0,13.30,13.0,12.0,15.0,16.0,11.0]
//             tasks1 = [9.0,9.05,8.80,9.04,9.01,8.20,8.20]
//             tasks2 = [10.0,10.0,10.0,10.0,10.0,10.0,10.0]
            tasks = [14.0,13.30,13.0,12.0,15.0,16.0,11.0]
            tasks1 = [9.0,9.05,8.80,9.04,9.01,8.20,8.20]
            tasks2 = [10.0,10.0,10.0,10.0,10.0,10.0,10.0]
            parameterName.text = "DO"
        }
        else if paramLabel.text == "PH"{
            tasks1 = [9.0,2.0,3.0,2.0,5.0,6.0,7.0]
            tasks = [10.0,12.0,13.0,12.0,15.01,16.0,17.0]
            tasks2 = [7.87,7.87,7.87,7.87,7.87,7.87,7.87]
              parameterName.text = "PH"
        }
        else if paramLabel.text == "TDS"{
            tasks = [19.0,12.0,13.0,12.0,15.0,16.0,17.0]
            tasks1 = [4.0,2.0,3.0,2.0,5.01,6.0,7.0]
            tasks2 = [7.87,7.87,7.87,7.87,7.87,7.87,7.87]
              parameterName.text = "TDS"
        }
        else{
            tasks = [9.0,2.0,3.0,2.0,5.0,6.0,7.0]
            tasks1 = [10.0,12.0,13.0,12.0,15.01,16.0,17.0]
            tasks2 = [7.87,7.87,7.87,7.87,7.87,7.87,7.87]
              parameterName.text = "TEMP"
        }
        setChart(dataPoints:days,values:tasks,values1:tasks1,values2:tasks2)
        }
        
    }
    
    @IBOutlet weak var paramLabel: UILabel!
    
    @IBOutlet weak var paramPicker: UIPickerView!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
      @IBOutlet weak var lineChartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createFromDatePicker()
        createToDatePicker()
    }
    
    func createFromDatePicker() {
        from.datePickerMode = .date
        fromDate.inputView = from
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickedFrom))
        toolbar.setItems([doneBtn], animated: true)
        fromDate.inputAccessoryView = toolbar
    }
    
    
    func createToDatePicker() {
       to.datePickerMode = .date
      toDate.inputView = to
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickedTo))
        toolbar.setItems([doneBtn], animated: true)
        toDate.inputAccessoryView = toolbar
    }
    
    
    func doneClickedFrom() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        fromDate.text = dateFormatter.string(from: from.date)
        self.view.endEditing(true)
        
    }
    
    
    func doneClickedTo() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
       toDate.text = dateFormatter.string(from: to.date)
        self.view.endEditing(true)
        paramPicker.reloadAllComponents()
        flag = 1
    }
    
    
    
    func setChart(dataPoints:[String],values:[Double],values1:[Double],values2:[Double]) {
        
        lineChartView.noDataText = "no data available"
        var dataEntries : [ChartDataEntry] = []
        var dataEntries1 : [ChartDataEntry] = []
        var dataEntries2 : [ChartDataEntry] = []
        for i in 0..<dataPoints.count{
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            let dataEntry1 = ChartDataEntry(x: Double(i), y: values1[i] )
            let dataEntry2 = ChartDataEntry(x: Double(i), y: values2[i])
            dataEntries.append(dataEntry)
            dataEntries1.append(dataEntry1)
            dataEntries2.append(dataEntry2)
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
        set2.axisDependency = .left
        // Line will correlate with left axis values
        set2.setColor(UIColor.green.withAlphaComponent(0.5))
        set2.setCircleColor(UIColor.green)
        set2.lineWidth = 2.0
        set2.circleRadius = 3.0
        set2.fillAlpha = 65 / 255.0
        set2.fillColor = UIColor.green
        set2.highlightColor = UIColor.white
        set2.drawCircleHoleEnabled = true
        
        
        let set3: LineChartDataSet = LineChartDataSet(values: dataEntries2, label:"Threshold")
        set3.axisDependency = .left
        
        set3.setColor(UIColor.blue.withAlphaComponent(0.5))
        set3.setCircleColor(UIColor.blue)
        set3.lineWidth = 2.0
        set3.circleRadius = 3.0
        set3.fillAlpha = 65 / 255.0
        set3.fillColor = UIColor.blue
        set3.highlightColor = UIColor.white
        set3.drawCircleHoleEnabled = true
        
        
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)
        dataSets.append(set3)
    
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.white)
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.lineChartView.data = data
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return param[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paramLabel.text = param[row]
    }
}
