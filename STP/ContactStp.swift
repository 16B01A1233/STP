//
//  ContactStp.swift
//  STP
//
//  Created by DVNAGARAJU on 03/03/19.
//  Copyright © 2019 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ContactStp: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var refMainDashboard:MainDashboard!
    var refContactStp:ContactStp!
    var StpNames:[String] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StpNames.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")!  as? ContactStpCustomCell
        cell?.StpLabel.text = StpNames[indexPath.row]
        return cell!
    }
    
var ref:DatabaseReference!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        var ind = 0
        ref.child("stps").observeSingleEvent(of:  .value, with: {
            snapshot in
            for i in snapshot.children.allObjects as!  [DataSnapshot] {
                let dict = i.value as? [String:Any]
                let n = dict?["name"] as? String
                self.StpNames.insert(n!, at: ind)
           }
            print(self.StpNames)
            self.tableView.reloadData()
            
      })
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ContactStpDetails", sender: nil)
    }
    
   
    
    override func prepare(for  segue: UIStoryboardSegue, sender: Any?){
        let  nextpage: ContactStpDetails = segue.destination as! ContactStpDetails
        nextpage.contactStpObj = self
       
        var  row = (tableView.indexPathForSelectedRow? .row)!
         nextpage.s = StpNames[row]
        
    }
    
}
