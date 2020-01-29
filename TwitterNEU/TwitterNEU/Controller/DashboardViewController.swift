//
//  DashboardViewController.swift
//  TwitterNEU

import UIKit
import FirebaseAuth

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutUser(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            KeyChainService().keyChain.delete("uid")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            return
        }
        KeyChainService().keyChain.delete("uid")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func userProfile(_ sender: Any) {
        
        performSegue(withIdentifier: "userProfileSegue", sender: self)
        
    }
    @IBAction func tweet(_ sender: Any) {
        performSegue(withIdentifier: "tweetSegue", sender: self)
    }
    
    @IBAction func readMyTweets(_ sender: Any) {
         performSegue(withIdentifier: "readMyTweetsSegue", sender: self)
        
    }
    
    
}
