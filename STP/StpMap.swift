import UIKit
import  FirebaseDatabase
import Charts

class StpMap: UIViewController {
    
    @IBOutlet weak var dateText: UITextField!
    var refStpMap:StpMap!
    var refStateReport:StateWideReports!
    var refDashboard:Dashboard!
    var refViewStpMap:ViewStpMap!
    var refStpreport:StpReports!
    var stp :String = ""
    let datePicker = UIDatePicker()
@IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var stpnameL: UILabel!
    var raw:[Double] = []
    var treated:[Double] = []
    var params:[String] = ["                        DO","                       PH","                    TDS","                         TEMPERATURE"]
//      var params:[String] = ["                        DO","                       PH","                    TDS","                         TEMPARATURE","          INFLOW","                       EC"]
    var dateS = ""
    @IBAction func displayGraph(_ sender: Any) {
        dateS = dateText.text!
        getDetails(date: dateS)
    }
    var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        stpnameL.text = stp
        stp = stp.lowercased()
        ref = Database.database().reference()
        createDatePicker()
    }
    
    func getDetails(date: String) {
       // print()
        raw.removeAll()
        treated.removeAll()
        print("raw")
        ref.child("stp").child(stp).child(dateS).child("raw").observeSingleEvent(of:  .value, with: { snapshot in
            let r = snapshot.value as! [String : Any]
            //var c = 0
          
            self.raw.append(r["do"] as! Double)
            self.raw.append(r["ph"] as! Double)
            self.raw.append(r["tds"] as! Double)
            self.raw.append(r["temperature"] as! Double)
            print("r value .....................")
            print(r)
//            self.raw.append(r["inflow"] as! Double)
//            self.raw.append(r["ec"] as! Double)
            
            print(self.raw)
        })
        print("treated")
        ref.child("stp").child(stp).child(dateS).child("treated").observeSingleEvent(of:  .value, with: { snapshot in
             let r = snapshot.value as! [String : Any]
            print("r value .....................")
            print(r)
            self.treated.append(r["do"] as! Double)
            self.treated.append(r["ph"] as! Double)
            self.treated.append(r["tds"] as! Double)
            self.treated.append(r["temperature"] as! Double)
//            self.treated.append(["volumetreated"] as! Double)
//            self.treated.append(["ec"] as! Double)
            print(self.treated)
            self.setChart(dataPoints: self.params, values: self.raw, values1: self.treated)
        })
    }
    
    func setChart(dataPoints:[String],values:[Double],values1:[Double]) {
        barChartView.noDataText = "no data available"
        var dataEntries : [BarChartDataEntry] = []
        var dataEntries1 : [BarChartDataEntry] = []
        //var counter = 0.0
        for i in 0..<dataPoints.count{
            //counter+=1.0
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i] )
            let dataEntry1 = BarChartDataEntry(x: Double(i), y: values1[i] )
            dataEntries.append(dataEntry)
            dataEntries1.append(dataEntry1)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "raw")
        let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: "treated")
        let chartData :[BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)]
        chartDataSet1.colors = [UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)]
        let chart1 = BarChartData(dataSets : chartData)
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        let groupCount = dataPoints.count
        let x = 0
        chart1.barWidth = Double(barWidth)
        barChartView.xAxis.axisMinimum = Double(x)
        
        let gg = chart1.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        
        barChartView.xAxis.axisMaximum = Double(x)+(gg)*Double(groupCount)
        
        chart1.groupBars(fromX: Double(x), groupSpace: groupSpace, barSpace: barSpace)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChartView.xAxis.labelPosition =  .bottom
        barChartView.xAxis.granularity = 1
        barChartView.notifyDataSetChanged()
        barChartView.data = chart1
        barChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0)
    }
    
    func createDatePicker() {
        datePicker.datePickerMode = .date
        dateText.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneBtn], animated: true)
        dateText.inputAccessoryView = toolbar
    }
    
    func doneClicked() {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateText.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
}
