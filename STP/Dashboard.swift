import UIKit
import FirebaseDatabase
class Dashboard: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var count: Int = 0
    
    @IBAction func mapButton(_ sender: Any) {
        flag = 1
        performSegue(withIdentifier: "mapConn", sender: nil)
    }
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
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: "gridCellId", for: indexPath) as! CustomCollectionCell
        cell.nameStp.text = stpname[indexPath.item]
        if(stpstat[indexPath.row]=="1"){
            cell.nameStp.backgroundColor = UIColor.green
            //    cell.nameStp.textColor  = UIColor.green
        }
        else{
            cell.nameStp.backgroundColor = UIColor.red
            //  cell.nameStp.textColor  = UIColor.red
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
        if(flag == 0) {
            print("Details")
                        let detPage:StpMap = segue.destination as! StpMap
                        detPage.refDashboard = self
                        detPage.stp = s
        }
        else {
            print("MappConn")
        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        flag = 0
        print(stpname[indexPath.item])
        s = stpname[indexPath.item]
        
        performSegue(withIdentifier: "DashDetails", sender: nil)
    }
}
