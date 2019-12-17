//
//  StateWideReports.swift
//  STP
//
//  Created by DVNAGARAJU on 02/03/19.
//  Copyright © 2019 SVECW-5. All rights reserved.
//
import UIKit
import FirebaseDatabase
class StateWideReports: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{
    
    var ref:DatabaseReference!
    var states:[String] = []
    var districts:[String] = []
    var stps:[String] = ["stp1","stp2","stp3","stp4","stp5"]
    var refMainDashboard:MainDashboard!
    var refStateWideReport:StateWideReports!
    var lbl = ""
    var flag = 0;
    @IBOutlet weak var districtspicker: UIPickerView!
    @IBOutlet weak var districtslabel: UILabel!
    @IBOutlet weak var statespicker: UIPickerView!
    @IBOutlet weak var stateslabel: UILabel!
    @IBOutlet weak var stplabel: UILabel!
    @IBOutlet weak var stpspicker: UIPickerView!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func ShowDetails(_ sender: Any) {
        if flag == 1{
        self.performSegue(withIdentifier: "showdetails", sender: nil)
        }
        else{
            errorLabel.text = "select states,districts and stps..."
            errorLabel.textColor = UIColor.red
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let x:StpMap = segue.destination as! StpMap
    x.refStateReport = self
        x.stp = stplabel.text!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        stateData()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var cnt = stps.count
        if pickerView == districtspicker{
            cnt = districts.count
        }
        else if pickerView == statespicker{
            cnt = states.count
        }
        return cnt
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statespicker{
            return states[row]
        }
        else if pickerView == districtspicker{
            return districts[row]
        }
        else{
            return stps[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statespicker{
            districtData(state: states[row])
            stateslabel.text = states[row]
            stateslabel.font = stateslabel.font.withSize(10)
        }
        else if pickerView == districtspicker{
            flag = 1
            self.stpspicker.isHidden = false
             stpspicker.reloadAllComponents()
            districtslabel.text = districts[row]
            districtslabel.font = districtslabel.font.withSize(10)
        }
        else{
            stplabel.text = stps[row]
            stplabel.font = stplabel.font.withSize(10)
        }
    }
    
  
    func districtData(state: String) {
        districts.removeAll()
        var ind = 0
        ref.child("states").queryOrdered(byChild: "state").queryEqual(toValue: state).observeSingleEvent(of:  .value, with: { snapshot in
            for i in snapshot.children.allObjects as! [DataSnapshot] {
                for rest in i.children.allObjects as! [DataSnapshot] {
                  
                    for x in rest.children.allObjects as! [DataSnapshot] {
                        print(x.value)
                        self.districts.append(x.value! as! String)
                    }
                }
            }
            self.districtspicker.isHidden = false
            self.districtspicker.reloadAllComponents()
//            self.stpspicker.reloadAllComponents()
        })
    }
    
    
    func stateData() {
        states.removeAll()
        ref.child("states").queryOrdered(byChild: "state").observeSingleEvent(of:  .value, with: { snapshot in
            for i in snapshot.children.allObjects as! [DataSnapshot] {
                let dict = i.value as? [String:Any]
                print(dict?["state"])
                let s = dict?["state"] as? String
                self.states.append(s!)
            }
            print(self.states)
            self.statespicker.reloadAllComponents()
            print("after reloading ....")
        })
    }
    
}
