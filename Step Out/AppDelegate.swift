import UIKit
import Firebase
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    var user_name = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let initialViewController = storyboard.instantiateInitialViewController() {
//            window?.rootViewController = initialViewController
//            window?.makeKeyAndVisible()
//        }
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.clientID = "273121369071-i2lph2nq4srqjra8ttrj9k0j8t93e80e.apps.googleusercontent.com"
        checkState()
        return true
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)		
        } else {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            Auth.auth().signInAndRetrieveData(with: credential) { (result, error) in
                if error == nil {
                    self.user_name = result?.user.displayName as! String

                    print("USER ID \(result?.user.tenantID ?? "is ")") // id is nil
                    //self.checkState()
                    //  self.leaderboardPage()
                    // let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //let LeaderboardVC = storyboard.instantiateViewController(withIdentifier: "LeaderboardView") as! LeaderboardViewController
                    //self.present(LeaderboardVC, animated: false, completion: nil)
                    //self.window?.rootViewController?.present(LeaderboardVC, animated: false, completion: nil)
//                    self.window?.rootViewController = UINavigationController(rootViewController: LeaderboardViewController())
//                    self.window?.makeKeyAndVisible()
                    
                } else {
                    
                    print(error?.localizedDescription ?? "error")
                }   
            }
            
        
        }
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    fileprivate func checkState() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if (Auth.auth().currentUser != nil) {
            leaderboardPage()
            print("YES USER IS ONLINE")
        }
        else {
            print("USER IS OFFline")
            loginPage()
        }
    }
    
    func loginPage() {
        let initialVC = initialViewController()
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
    }
    func leaderboardPage() {
       // let leaderboardViewController = LeaderboardViewController()
        window?.rootViewController = UINavigationController(rootViewController: LeaderboardViewController())
        window?.makeKeyAndVisible()
    }
}
