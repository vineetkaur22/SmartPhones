//
//  LoginFirebaseViewController.swift
//  PartyPlanner
//
//  Created by Vineet Kaur Bagga on 12/11/19.
//  Copyright © 2019 Vineet Kaur Bagga. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginFirebaseViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func Login(_ sender: UIButton) {
        
        let password = passwordText.text!
        let emailtext = emailText.text!
        
        if(emailText.text! == "" || passwordText.text! == ""){
            loginLabel.text = "Please enter a valid email and password"
            return
        }
        
        Auth.auth().signIn(withEmail: emailtext, password: password) { [weak self] user, error in
                guard let strongSelf = self else { return }
                if (error == nil) {
                    strongSelf.performSegue(withIdentifier: "splashSegue", sender: strongSelf)
                }
                else{
                    strongSelf.loginLabel.text = error?.localizedDescription
                    return
                }

            }
        }
        
    @IBAction func goToRegister(_ sender: Any) {
        performSegue(withIdentifier: "registerSegue", sender: self)
    }

}
