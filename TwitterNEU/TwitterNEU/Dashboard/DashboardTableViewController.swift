//
//  DashboardTableViewController.swift
//  TwitterNEU
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DashboardTableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
     var listTweets = [Tweet]()
     var refFollowing : DatabaseReference?
     var loggedInuser : User?
     var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loggedInuser = Auth.auth().currentUser
        guard let  uid = loggedInuser?.uid else {return}
        ref = Database.database().reference()
        
        refFollowing = Database.database().reference().child("following").child(uid)
        
        loadTweets()

    }
    
      deinit {
          Database.database().reference().removeAllObservers()
      }
    
    func loadTweets(){
            
            refFollowing?.observeSingleEvent(of: .value, with: { (snapShot) in
               // print(snapShot)
                if let snapDict = snapShot.value as? [String:AnyObject]{
                    for each in snapDict as [String:AnyObject]{
                        let uidToFollow = each.value["uid"]! as! String
                        self.ref?.child("tweets").child(uidToFollow).observe(.value, with: { (snap) in
                          
                            if let tweetDict = snap.value as? [String:AnyObject]{
                                for eachTweet in tweetDict as [String:AnyObject]{
                                    let author : String = eachTweet.value["author"]! as! String
                                    let body: String = eachTweet.value["body"]! as! String
                                    let uidTweeter : String = eachTweet.value["uid"]! as! String
                                    
                                    
                                    self.listTweets.append(Tweet(author: author, body: body, uid: uidTweeter, key: eachTweet.key    ))
                                    self.table.reloadData()
                                    
                                }
                            }
                        })
                    }
                }
            })
        }


   


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTweets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(listTweets[indexPath.row].author): \(listTweets[indexPath.row].body)"
        return cell
    }
    


}
