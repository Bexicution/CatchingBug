import UIKit
import FirebaseDatabase
import Firebase

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    

    @IBOutlet var ListTableView: UITableView!
    @IBOutlet var YourNumOfSteps: UILabel!
    var sessionsStorage = [Person]()
    var ref = Database.database().reference()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leaderboard"

       
        
      //  ListTableView.backgroundView = UIImageView(image: UIImage(named: "luke-chesser-pJadQetzTkI-unsplash")
        
//        sessionsStorage.add(bex)
//        sessionsStorage.add(abylay)
//        sessionsStorage.add(aidar)
//        sessionsStorage.add(dara)
        
        fetchUser()
    }
    
    func fetchUser() {
        ref.child("Users").observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                user.setValuesForKeys(dictionary)
                let fullName = user.fullname
                let fullNameArr = fullName!.components(separatedBy: " ")
                let name = fullNameArr[0]
                let surname = fullNameArr[1]
                
                let user1 = Person(name: name, surname: surname, steps: user.steps!)
                self.sessionsStorage.append(user1)
            }
        }
    }
    
    
//    let bex = Person(name: "Bexultan", surname: "Tokan", steps: 2002)
//    let abylay = Person(name: "Abylay", surname: "Yerzhanov", steps: 2001)
//    let aidar = Person(name: "Aidar", surname: "Nugmanoff", steps: 2000)
//    let dara = Person(name: "Dara", surname: "Tumenbayeva", steps: 1999)

    
    @IBAction func TestingButton() {
        
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
        return sessionsStorage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personCell = tableView.dequeueReusableCell(withIdentifier: "person_cell", for: indexPath) as! LeaderboardTableViewCell
        let session = sessionsStorage[indexPath.row]
        personCell.configure(with: session)

        return personCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("tapped on \(indexPath)")
    }
    
}
