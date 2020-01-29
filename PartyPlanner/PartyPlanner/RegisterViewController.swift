//
//  RegisterViewController.swift
//  PartyPlanner
//
//  Created by Vineet Kaur Bagga on 12/11/19.
//  Copyright © 2019 Vineet Kaur Bagga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textReenter: UITextField!
    @IBOutlet weak var labelWelcome: UILabel!
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerUser(_ sender: Any) {
        let name = textName.text!
        let email = textEmail.text!
        let password = textPassword.text!
        let reenter = textReenter.text!
        
        if password.count < 8 {
            labelWelcome.text = "Password should be bigger than 8"
            return
        }
        if password != reenter{
            labelWelcome.text = "Passwords dont match"
            return
        }

        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            
        guard let user = authResult?.user, error == nil else {
            self.labelWelcome.text! = error!.localizedDescription
          return
        }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { (error) in
            print(error)
            self.addUserInDatabase(user: user)
        }
         
        print("\(user.email!) created")
        let alert = UIAlertController(title: "User Created", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action)
        in
        self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
        }
    }
    
    func addUserInDatabase(user : User){
        ref = Database.database().reference()
        let uid = user.uid
        self.ref.child("parties").child(uid)
    }
}
