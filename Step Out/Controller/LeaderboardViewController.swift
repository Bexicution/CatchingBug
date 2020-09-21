import UIKit
import FirebaseDatabase
import Firebase
import CoreMotion
import FirebaseAuth

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    
    @IBOutlet var ListTableView: UITableView!
    @IBOutlet var YourNumOfSteps: UILabel!
    var sessionsStorage = [Person]()
    var ref = Database.database().reference()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var fullName = "Sample Name"
    let user = Auth.auth().currentUser
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterMyself()
        fetchUser()
        
//        if CMMotionActivityManager.isActivityAvailable() {
//            print("YES, Active")
//            self.activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
//                DispatchQueue.main.async {
//                    if let activity = data {
//                        if activity.running == true {
//                            self.YourNumOfSteps.text = "Running"
//                            print("Running")
//                        } else if activity.walking == true {
//                            self.YourNumOfSteps.text = "Walking"
//                            print("Walking")
//                        } else if activity.automotive == true {
//                            self.YourNumOfSteps.text = "Automobile"
//                            print("Automobile")
//                        }
//                    }
//                }
//            }
//        }
//        pedometer.startUpdates(from: Date()) { (pedometerData, error) in
//            if let pedData = pedometerData {
//                self.YourNumOfSteps.text = "Steps: \(pedData.numberOfSteps)"
//            } else {
//                self.YourNumOfSteps.text = "Steps: Not available"
//            }
//        }
        if CMPedometer.isStepCountingAvailable() {
            self.pedometer.startUpdates(from: Date()) { (data, error) in
                if error == nil {
                    if let response = data {
                        DispatchQueue.main.async {
                            self.YourNumOfSteps.text = "\(response.numberOfSteps)"   
                            //print(response.numberOfSteps)
                        }
                    }
                }
            }
        } else {
            self.YourNumOfSteps.text = "Steps: Unavailable"
        }
    }
    
    
    
    
    
    func enterMyself() {
        ref.child("Users").child(user?.uid ?? "nil").observe(.value) { (DataSnapshot) in
            let id = DataSnapshot.value as? [String: Any]
            if id == nil {
                let object = [
                    "fullname": self.user?.displayName ?? "Sample Name",
                    "steps": 0
                ] as [String : Any]
                self.ref.child("Users").child(self.user?.uid ?? "random").setValue(object)
            }
        }
        self.ListTableView.reloadData()
    }
    func fetchUser() {

        sessionsStorage.removeAll()
        ref.child("Users").observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                if snapshot.key == self.user?.uid {
                    self.YourNumOfSteps.text = ("\(dictionary["steps"] as! Int)")
                }
               
                let steps = dictionary["steps"] as? Int
                let fullName =  dictionary["fullname"] as? String
                let fullNameArr = fullName?.components(separatedBy: " ")
                let name = fullNameArr?[0] ?? "NAME"
                let surname = fullNameArr?[1] ?? ""
               
                let user1 = Person(name: name, surname: surname, steps: steps ?? -1)
                 self.sessionsStorage.append(user1)
                 self.sessionsStorage.sort { (a:Person, b:Person) -> Bool in
                    a.steps > b.steps
                }
                self.ListTableView.reloadData()
            }
        }
    }
    
    private var data : String? // String? or any type you want
    func getData() -> String? {
        return data
    }
    func passData(_ data : String?) {
        self.data = data
    }
    
    @IBAction func TestingButton() {
//        fullName = self.appDelegate.getUsername()
       /* self.YourNumOfSteps.text = "0"
        let object = [
            "fullname": fullName,
            "steps": 0
        ] as [String : Any]
        ref.child("Users").childByAutoId().setValue(object)*/
        self.fetchUser()
        
        do {
            try Auth.auth().signOut()
            appDelegate.window?.rootViewController = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            appDelegate.window?.makeKeyAndVisible()
        } catch _ {
            print("ERROR HERE")
        }
        
//        if Auth.auth().currentUser?.uid == nil {
//                       print("not logged in")
//               }
//               else {
//                   print(Auth.auth().currentUser?.uid)
//               }
////
//        let fullName = appDelegate.user_name
//
//        let fullNameArr = fullName.components(separatedBy: " ")
//        let name = fullNameArr[0]
//        let surname = fullNameArr[1]
//        let object = [
//            "name": name,
//            "surname": surname,
//            "steps": 0
//            ] as [String : Any]
//       //        ref.child("Users").childByAutoId().setValue(object)
//   //     ref.child("Users").childByAutoId().setValue(surname)
      //  ref.child("Users").child(user.uid).setValue(["username": username])
        
     //   ref.child("users").childByAutoId().setValue("hey", forKey: "yo")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  print ("SIZE OF TABLEVIEW \(sessionsStorage.count)")
        return sessionsStorage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personCell = tableView.dequeueReusableCell(withIdentifier: "person_cell", for: indexPath) as! LeaderboardTableViewCell
        let session = sessionsStorage[indexPath.row]
        personCell.configure(with: session)
        personCell.ratingNum.text = "\(indexPath.row + 1)"
        return personCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print ("tapped on \(indexPath)")
    }
    
}
