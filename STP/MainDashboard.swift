//
//  MainDashboard.swift
//  STP
//
//  Created by DVNAGARAJU on 02/03/19.
//  Copyright © 2019 SVECW-5. All rights reserved.
//

import UIKit

class MainDashboard: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var dashbordNames = ["View Status","State Wide Reports","Quality Reports","STP Reports","Contact STP","Contact Admin"]
  
    
   
    var s = ""
    @IBOutlet weak var MainCollCell: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       MainCollCell.dataSource = self
        MainCollCell.delegate = self
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dashcell = MainCollCell.dequeueReusableCell(withReuseIdentifier: "maindashcellid", for: indexPath) as! MainDashCustomCell
        dashcell.dashLabels.text = dashbordNames[indexPath.item]
    
        dashcell.dashLabels.font = UIFont(name: dashbordNames[indexPath.item], size: 30)

        dashcell.dashLabels.font = dashcell.dashLabels.font.withSize(10)
        return dashcell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if s == "State Wide Reports"{
        let  stateReport:StateWideReports = segue.destination as! StateWideReports
            stateReport.refMainDashboard = self
             stateReport.lbl = s
        }
        else if s == "View Status"{
            let viewstatus:ViewStatus = segue.destination as! ViewStatus
            viewstatus.refMainDashboard = self
        }
        else if s == "Quality Reports"{
            let qualityreports:DatePickerTry = segue.destination as! DatePickerTry
            qualityreports.refMainDashboard = self
        }
        else if s == "STP Reports"{
            let stpreports:StpReports = segue.destination as! StpReports
            stpreports.refMainDashboard = self
        }
        else if s == "Contact STP"{
            let contactstp:ContactStp = segue.destination as! ContactStp
            contactstp.refMainDashboard = self
        }
        else{
            let st:AdminDetails = segue.destination as! AdminDetails
            st.refMainDashboard = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("in didselectitemat")
        s  = dashbordNames[indexPath.item]
        if s == "State Wide Reports"{
                performSegue(withIdentifier: "statereports", sender: nil)
        }
        else if s == "View Status"{
             performSegue(withIdentifier: "viewstatus", sender: nil)
        }
        else if s == "Quality Reports"{
             performSegue(withIdentifier: "qualityreports", sender: nil)
        }
        else if s == "STP Reports"{
             performSegue(withIdentifier: "stpreports", sender: nil)
        }
        else if s=="Contact STP"{
            performSegue(withIdentifier: "contactstp", sender: nil)
        }
        else{
            performSegue(withIdentifier: "admindetails", sender: nil)
        }
    }
 
}
