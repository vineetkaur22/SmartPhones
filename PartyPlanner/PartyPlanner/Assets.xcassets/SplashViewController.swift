//
//  SplashViewController.swift
//  PartyPlanner
//
//  Created by Vineet Kaur Bagga on 12/11/19.
//  Copyright © 2019 Vineet Kaur Bagga. All rights reserved.
//

import UIKit
import FirebaseAuth


class SplashViewController: UIViewController {
    @IBOutlet weak var welcomeText: UILabel!
    var user : User?


    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        guard let  name = user?.displayName else {return}
        welcomeText.text = "Welcome "
        welcomeText.text?.append(name)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
        self.performSegue(withIdentifier: "homeSegue", sender: self)
        }
    }
}
