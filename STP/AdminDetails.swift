//
//  AdminDetails.swift
//  STP
//
//  Created by DVNAGARAJU on 03/03/19.
//  Copyright © 2019 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseDatabase
class AdminDetails: UIViewController {
    var refMainDashboard:MainDashboard!
    var refAdminDetails:AdminDetails!
    var s = ""
    @IBOutlet weak var AdminName: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var phnno: UILabel!
    
    var phncall:String!
    
    
    
    @available(iOS 10.0, *)
    @IBAction func callbb(_ sender: UIButton) {
        phncall = String(phnno.text!)
        sender.setTitle(phncall, for: .normal)
        guard let num = sender.titleLabel?.text , let url = URL(string : "tel://\(num)") else {
            return
        }
        UIApplication.shared.open(url)
        
    }
    @IBOutlet weak var callb: UIButton!
    
    
    
    
    var ref: DatabaseReference!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("stps").observeSingleEvent(of:  .value, with: {
            snapshot in
            for i in snapshot.children.allObjects as!  [DataSnapshot] {
                let dict = i.value as? [String:Any]
                
                let n = dict?["admin"] as? String
                if n == "stp2"{
                    print(dict)
                    self.AdminName.text = n
                    let u = dict?["user"] as? String
                    self.user.text = u
                    let p = dict?["phnno"] as? String
                    print(p)
                    self.phnno.text = p
                    self.phncall = p
                }
            }
        })
        
    }
    }
