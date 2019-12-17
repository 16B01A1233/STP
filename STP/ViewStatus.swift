//
//  ViewStatus.swift
//  STP
//
//  Created by DVNAGARAJU on 02/03/19.
//  Copyright © 2019 SVECW-5. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class ViewStatus: UIViewController,MKMapViewDelegate {
    var refMainDashboard:MainDashboard!
    var refViewStatus:ViewStatus!
    @IBOutlet weak var map: MKMapView!
    
    var latArr = [16.566969,16.568,16.564,16.562,16.567]
    var longArr = [81.525895,81.525895,81.523995,81.523995, 81.523995]
    var titleArr = ["Bhimavaram","Hyd","Surat","1","0"]
    var imageArr = ["greenLoc","RedLoc","img","we","we"]
    var subTitArr = ["1","0","1","1","0"]
    var latArr1:[Double] = []
    var longArr1:[Double] = []
    var titleArr1:[String] = []
    //var imageArr1:[] = []
    var stpSelected:String!
    var subTitArr1:[String] = []
    var place = ""
    var ref:DatabaseReference!
    class customPin:NSObject,MKAnnotation{
        var coordinate: CLLocationCoordinate2D
        var title: String?
        var subtitle: String?
        
        init(pinTitle:String,pinSubTitle:String,location:CLLocationCoordinate2D) {
            self.title = pinTitle
            self.subtitle = pinSubTitle
            self.coordinate = location
        }
        
    }
    
    func showOnMap(lat: Double,long: Double,title: String,c: String, ind: String) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        print(title)
        self.map.setRegion(region, animated: true)
        let annotpin = customPin(pinTitle: title, pinSubTitle: ind, location: location)
        map.addAnnotation(annotpin)
        self.map.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getData()
        var count = 2
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        var color = ""
        print(annotation.subtitle)
        if(annotation.subtitle == "1") {
            color = "greenLoc"
        }
        else {
            color = "redLoc"
        }
        print(color)
        print("***")
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
        annotationView.image = UIImage(named : color)
        annotationView.canShowCallout = true
        return annotationView
    }
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        print(view.annotation?.title)
//        place = (view.annotation?.title)! ?? "Hii"
//        stpSelected = view.annotation?.title!
//        performSegue(withIdentifier: "GraphDetails", sender: nil)
//    }
//    
    func getData() {
        latArr1.removeAll()
        longArr1.removeAll()
        subTitArr1.removeAll()
        titleArr1.removeAll()
        var ind = 0
        ref.child("stps").observeSingleEvent(of:  .value, with: {
            snapshot in
            for i in snapshot.children.allObjects as!  [DataSnapshot] {
                let dict = i.value as? [String:Any]
                let n = dict?["name"] as? String
                self.titleArr1.insert(n!, at: ind)
                let sts = dict?["status"] as? String
                self.subTitArr1.insert(sts!, at: ind)
                let loc = dict?["location"] as? [String:Any]
                print(loc!)
                let lat = Double(loc?["lat"] as! String)
                let long = Double(loc?["long"] as! String)
                self.latArr1.insert(lat!, at: ind)
                self.longArr1.insert(long!,  at: ind)
                ind = ind+1
                print(self.latArr1)
                print(self.longArr1)
            }
            for i in 0..<self.latArr1.count {
                self.showOnMap(lat: self.latArr1[i],long: self.longArr1[i],title: self.titleArr1[i],c: self.imageArr[i],ind: self.subTitArr1[i])
            }
        })
    }
    
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Details")
        let detPage:StpMap = segue.destination as! StpMap
        detPage.refViewStpMap = self
        detPage.stp = stpSelected
    }*/
    
}
