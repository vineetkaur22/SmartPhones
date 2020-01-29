//
//  AddPartyViewController.swift
//  PartyPlanner
//
//  Created by Vineet Kaur Bagga on 12/11/19.
//  Copyright © 2019 Vineet Kaur Bagga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFunctions
import Alamofire
import SwiftyJSON

class AddPartyViewController: UIViewController {
    
    var functions = Functions.functions()
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var DateText: UITextField!
    
    @IBOutlet weak var foodListText: UITextField!
    @IBOutlet weak var decorationListText: UITextField!
    @IBOutlet weak var themeText: UITextField!
    var user : User?
    var parties = [Party]()


    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
    }
    
    @IBAction func saveParty(_ sender: Any) {
        let uid = user?.uid
        print(uid!)
        print("Button Fire")
        let url = "https://us-central1-party-planner-b5f47.cloudfunctions.net/getParties?uid="
        let newUrl = url + String(uid!)
        print(newUrl)

        let parameters: Parameters = [
            "title" : titleText.text!,
            "theme" : themeText.text!,
            "date":DateText.text!,
            "decorationlist":decorationListText.text!,
            "foodlist":foodListText.text!
        ]

        Alamofire.request(newUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
            print(response)
        }
        
        let alert = UIAlertController(title: "Party Details Saved", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action)
            in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }

}
        
    
    
