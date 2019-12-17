import UIKit
import FirebaseDatabase


class PickerTry: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{
    var refMainDashboard:MainDashboard!
    var refPickerTry:PickerTry!
    
    @IBAction func showdetails(_ sender: Any) {
        print(label1.text)
        print(label2.text)
    }
    var arr1 = ["AP","Kerala","Telangana"]
    var arr2:[String] = []
    var states:[String] = []
    var districts:[String] = []
    var ref:DatabaseReference!
   // var arr2 = ["initial"]
    //var arr2 = ["apple","bat","cat","aeroplane","ball","carrot"]
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
//         districtData()
        stateData()
        // Do any additional setup after loading the view.
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var cnt = states.count
        if pickerView == picker2{
            cnt = districts.count
        }
        return cnt
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker1{
//            print("loadig elements here...arr1")
            return states[row]
        }
        else{
//            print("loadig elements here...")
            return districts[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker1{
            districtData(state: states[row])
            label1.text = states[row]

        }
        else{
            label2.text = districts[row]
        }
    }
    func districtData(state: String) {
        districts.removeAll()
        var ind = 0
        ref.child("states").queryOrdered(byChild: "state").queryEqual(toValue: state).observeSingleEvent(of:  .value, with: { snapshot in
                //print(snapshot.value(forKey: "districts"))
            for i in snapshot.children.allObjects as! [DataSnapshot] {
                for rest in i.children.allObjects as! [DataSnapshot] {
//                    var r = rest as? [String: Any]
                    for x in rest.children.allObjects as! [DataSnapshot] {
                        print(x.value)
                        self.districts.append(x.value! as! String)
                    }
                }
            }
            self.picker2.isHidden = false
            self.picker2.reloadAllComponents()
//            let rest = snapshot as? [String :Any]
//            print(rest)
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
            self.picker1.reloadAllComponents()
        })
    }
}

