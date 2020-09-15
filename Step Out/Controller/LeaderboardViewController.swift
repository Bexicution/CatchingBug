import UIKit
import FirebaseDatabase
import Firebase

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    

    @IBOutlet var ListTableView: UITableView!
    @IBOutlet var YourNumOfSteps: UILabel!
    var sessionsStorage = [Person]()
    var ref = Database.database().reference()
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
 //   lazy var fullName = appDelegate.user_name
    var fullName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  title = "Leaderboard"
          
//        let storyboard = UIStoryboard(name: "main", bundle: nil)
//        let vcLeaderboard = storyboard.instantiateViewController(withIdentifier: "LeaderboardView")
//        self.present(vcLeaderboard, animated: true)
        fetchUser()
       // enterMyself()
      //  ListTableView.backgroundView = UIImageView(image: UIImage(named: "luke-chesser-pJadQetzTkI-unsplash")
 
        print(sessionsStorage.count)
    }
    func enterMyself() {
        let object = [
            "fullname": fullName,
            "steps": 0
        ] as [String : Any]
        ref.child("Users").childByAutoId().setValue(object)
        self.ListTableView.reloadData()
    }
    func fetchUser() {
        ref.child("Users").observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
           
               
                let steps = dictionary["steps"] as? Int
                let fullName =  dictionary["fullname"] as? String
                let fullNameArr = fullName?.components(separatedBy: " ")
                let name = fullNameArr?[0] ?? "NAME"
                //print("NAME: \(String(describing: name))")
                let surname = "SURNAME"
                //print("SURNAME: \(String(describing: surname))")
                
                let user1 = Person(name: name, surname: surname, steps: steps ?? -1)
                //print(user1.name, user1.surname, user1.steps)
                self.sessionsStorage.append(user1)
                //self.sessionsStorage.sort(by: snapshot.steps > $1.steps)//(by: { $0.fileID > $1.fileID })
                //images.sort { $0.fileID < $1.fileID }
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
        self.YourNumOfSteps.text = "0"
        let object = [
            "fullname": fullName,
            "steps": 0
        ] as [String : Any]
        ref.child("Users").childByAutoId().setValue(object)
        self.ListTableView.reloadData()
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
        print ("SIZE OF TABLEVIEW \(sessionsStorage.count)")
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
        print ("tapped on \(indexPath)")
    }
    
}
