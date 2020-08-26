import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet var ListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Leaderboard"
        
      //  ListTableView.backgroundView = UIImageView(image: UIImage(named: "luke-chesser-pJadQetzTkI-unsplash")
        
    }
    
//    func addCellToTableView() {
//        ListTableView.beginUpdates()
//        ListTableView.insertRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)
//    }

    
    var sessionsStorage = SessionsStorage()
    let bex = Person(name: "Bexultan", surname: "Tokan", steps: 2002, rating: 1)
    let abylay = Person(name: "Abylay", surname: "Yerzhanov", steps: 2001, rating: 2)
    let aidar = Person(name: "Aidar", surname: "Nugmanoff", steps: 2000, rating: 3)
    let dara = Person(name: "Dara", surname: "Tumenbayeva", steps: 1999, rating: 4)
//      let st = [bex, abylay, aidar, dara]
    sessionsStorage.add(bex)
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows: \(SessionsStorage.shared.sessions.count)")
        return SessionsStorage.shared.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personCell = tableView.dequeueReusableCell(withIdentifier: "person_cell", for: indexPath) as! LeaderboardTableViewCell
        let session = SessionsStorage.shared.sessions[indexPath.row]
        personCell.configure(with: session)
        
        return personCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("tapped on \(indexPath)")
    }
    
}
