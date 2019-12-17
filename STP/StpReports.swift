//
//  StpReports.swift
//  STP
//
//  Created by DVNAGARAJU on 02/03/19.
//  Copyright © 2019 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseDatabase
class StpReports: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var refMainDashboard:MainDashboard!
    var refStpReports:StpReports!
    var count: Int = 0
    
    @IBOutlet weak var collView: UICollectionView!
    var ref:DatabaseReference!
    var s: String = ""
    var stpstat:[String] = []
    var stpname:[String] = []
    var flag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        collView.delegate = self
        collView.dataSource = self
        ref = Database.database().reference()
        flag = 0
        getDetails()
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: "gridCellId", for: indexPath) as! StpReportsCustomCell
        cell.nameStp.text = stpname[indexPath.item]
        if(stpstat[indexPath.row]=="1"){
            cell.nameStp.backgroundColor = UIColor.green
        }
            
        else{
            cell.nameStp.backgroundColor = UIColor.red
        }
        return cell
    }
    
    func getDetails() {
        var ind = 0
        ref.child("stps").observeSingleEvent(of:  .value, with: { snapshot in
            self.count = Int(snapshot.childrenCount)
            for i in snapshot.children.allObjects as!  [DataSnapshot]
            {
                let dict = i.value as?  [String:Any]
                let name = dict?["name"]as! String
                let status = dict?["status"]as!String
                self.stpname.insert(name, at: ind)
                self.stpstat.insert(status, at: ind)
                print(self.stpname)
                print(status)
                ind = ind+1
                self.collView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            let detPage:StpMap = segue.destination as! StpMap
            detPage.refStpreport = self
            detPage.stp = s
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
        print(stpname[indexPath.item])
        s = stpname[indexPath.item]
        
        performSegue(withIdentifier: "stpreports", sender: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    var count: Int = 0
//
//
//    @IBOutlet weak var collView: UICollectionView!
//    var ref:DatabaseReference!
//    var s: String = ""
//    var stpstat:[String] = []
//    var stpname:[String] = []
//    var flag = 0
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collView.delegate = self
//        collView.dataSource = self
//        ref = Database.database().reference()
//        flag = 0
//        getDetails()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collView.dequeueReusableCell(withReuseIdentifier: "gridCellId", for: indexPath) as! StpReportsCustomCell
//
//        cell.nameStp.text = stpname[indexPath.item]
//        if(stpstat[indexPath.row]=="1"){
//            cell.nameStp.backgroundColor = UIColor.green
//            //    cell.nameStp.textColor  = UIColor.green
//        }
//        else{
//            cell.nameStp.backgroundColor = UIColor.red
//            //  cell.nameStp.textColor  = UIColor.red
//        }
//        return cell
//    }
//
//    func getDetails() {
//        var ind = 0
//        ref.child("stps").observeSingleEvent(of:  .value, with: { snapshot in
//            self.count = Int(snapshot.childrenCount)
//            for i in snapshot.children.allObjects as!  [DataSnapshot]
//            {
//                let dict = i.value as?  [String:Any]
//                let name = dict?["name"]as! String
//                let status = dict?["status"]as!String
//                self.stpname.insert(name, at: ind)
//                self.stpstat.insert(status, at: ind)
//                print(self.stpname)
//                print(status)
//                ind = ind+1
//                self.collView.reloadData()
//            }
//        })
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//            let detPage:StpMap = segue.destination as! StpMap
//           detPage.refStpreport = self
//            detPage.stp = s
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(stpname[indexPath.item])
//        s = stpname[indexPath.item]
//        performSegue(withIdentifier: "DashDetails", sender: nil)
//    }

}
