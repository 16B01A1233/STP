import UIKit
import FirebaseDatabase

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var usernameT: UITextField!

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var passwordT: UITextField!
    var ref:DatabaseReference!
    @IBAction func Login(_ sender: Any) {
        //print(usernameT.text!)
        //print(passwordT.text!)
        let username = usernameT.text!
        let password = passwordT.text!
        
        if(username != "" && password != "") {
         ref.child("Users").child(username).observeSingleEvent(of:  .value, with: { snapshot in
                let pswd = snapshot.childSnapshot(forPath: "password").value as! String
                print(pswd)
                    if(pswd == password) {
                        
                        print("Correct Credentials")
                        UserDefaults.standard.set(username, forKey : "userid")
                        self.performSegue(withIdentifier: "Mainid", sender: nil)
                    }
                
            })
        }
        
        passwordT.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameT.delegate = self
        passwordT.delegate = self
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        passwordT.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordT.resignFirstResponder()
        return(true)
    }
    
}

