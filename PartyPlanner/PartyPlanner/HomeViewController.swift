//
//  DashboardViewController.swift
//  PartyPlanner
//
//  Created by Vineet Kaur Bagga on 12/10/19.
//  Copyright © 2019 Vineet Kaur Bagga. All rights reserved.
//

import UIKit
import FirebaseAuth
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var partyTableView: UITableView!
    
    var loggedInuser : User?
    var parties = [Party]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.partyTableView.delegate = self
        self.partyTableView.dataSource = self

        self.partyTableView.estimatedRowHeight = 100
        self.partyTableView.rowHeight = 100
        //loadValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getParties()
    }
    
    @IBAction func addNewParty(_ sender: Any) {
        self.performSegue(withIdentifier: "addPartySegue", sender: self)
    }
    
    func getParties(){
        let uid = Auth.auth().currentUser?.uid
        let url = "https://us-central1-party-planner-b5f47.cloudfunctions.net/getParties?uid="
        let newUrl = url + String(uid!)

        Alamofire.request(newUrl, method: .get, parameters: nil).responseJSON { response in
            
            switch response.result{
                case .success:
                    if let value = response.value{
                        let json = JSON(value)
                        //print(json)
                        
                        self.parties.removeAll()
                        
                        if let array = json.array {
                            for party in array {
                                let dict = party.dictionary
                                
                                if(dict != nil){
                                    // This will run only once
                                    for (key, value) in dict! {
                                        print("key: \(key), value: \(value)")
                                        let partyId: String = key
                                        if let detailsDict = value.dictionary{
                                            
                                            let theme: String = (detailsDict["theme"]?.string ?? "")
                                            let title: String = (detailsDict["title"]?.string ?? "")
                                            let date: String = (detailsDict["date"]?.string ?? "")
                                            let decorationlist: String = (detailsDict["decorationlist"]?.string ?? "")
                                            let foodlist: String = (detailsDict["foodlist"]?.string ?? "")
            
                                            let p = Party(partyId: partyId, title: title, date: date, theme: theme, foodList: foodlist, decorationList: decorationlist)
                                            
                                            self.parties.append(p)
                                        }
                                        
                                    }
                                }
                            }
                            
                        }
                    }
                    DispatchQueue.main.async {  self.partyTableView.reloadData() }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    @IBAction func Logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            return
        }
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(parties.count)
        return parties.count
    }
       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
        let cell = tableView.dequeueReusableCell(withIdentifier: "partyCell", for: indexPath) as! PartyTableViewCell

        cell.titleText.text = parties[indexPath.row].title;
        cell.themeText.text = parties[indexPath.row].theme;
        cell.contentView.tag = indexPath.row;

        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction))
        cell.contentView.addGestureRecognizer(gesture)

        return cell
   }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        // Do what you want
        let tag = sender.view?.tag
        print ("tag clicked : \(tag ?? -1)")
        
        let partyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "PartyDetailsViewController") as! PartyDetailsViewController
        
        if let index = tag {
            partyDetailsViewController.party = parties[index]
            self.navigationController?.pushViewController(partyDetailsViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let party = parties[indexPath.row]
            deletePartyFromDB(partyId: party.partyId!)
            parties.remove(at: indexPath.row)
            //search.remove(at: indexPath.row)
            partyTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func deletePartyFromDB(partyId: String){
        let uid = Auth.auth().currentUser?.uid
        let url = "https://us-central1-party-planner-b5f47.cloudfunctions.net/getParties?uid="
        let newUrl = url + String(uid!)
        print(newUrl)

        let parameters: Parameters = [
            "partyId" : partyId
        ]

        Alamofire.request(newUrl, method: .delete, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
            print(response)
        }
    }
    
    
    
}
