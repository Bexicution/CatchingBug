//
//  ViewController.swift
//  Step Out
//
//  Created by Mac on 8/20/20.
//  Copyright © 2020 Bexultan. All rights reserved.
//

import UIKit
import GoogleSignIn

class initialViewController: UIViewController {
    
    @IBOutlet var signInButtonGoogle: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
       
        
        
        
       /*
        miniFrame.layer.cornerRadius = 14
        miniFrame.layer.masksToBounds = true
     
        signInButton.layer.cornerRadius = 14
        signInButton.layer.masksToBounds = true
        */
        
        
        
//        if Auth.auth().currentUser != nil {
//            print("User signed in")
//             performSegue(withIdentifier: "leaderboard", sender: nil)
//        }
    }
    
    @IBAction func GoogleSignedInTapped() {
       // performSegue(withIdentifier: "Leaderboard", sender: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vclogin = storyboard.instantiateViewController(withIdentifier: "LeaderboardView")
//        self.present(vclogin, animated: true) {
//            return
//        }
        return
    }
    
    @IBAction func signInButton2() {
       // performSegue(withIdentifier: "leaderboard", sender: nil)
        
    }
    
}

