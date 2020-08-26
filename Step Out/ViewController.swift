//
//  ViewController.swift
//  Step Out
//
//  Created by Mac on 8/20/20.
//  Copyright © 2020 Bexultan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var miniFrame: UIButton!
    @IBOutlet var signInButton: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        miniFrame.layer.cornerRadius = 14
        miniFrame.layer.masksToBounds = true
     
        signInButton.layer.cornerRadius = 14
        signInButton.layer.masksToBounds = true
    }
  
    @IBAction func signInButton2() {
        performSegue(withIdentifier: "leaderboard", sender: nil)
    }
    
}

