//
//  PartyDetailsViewController.swift
//  PartyPlanner
//
//  Created by Vineet Kaur Bagga on 12/12/19.
//  Copyright © 2019 Vineet Kaur Bagga. All rights reserved.
//

import UIKit

class PartyDetailsViewController: UIViewController {
    @IBOutlet weak var partyDetailLabel: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    var party: Party?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPartyDetails()
    }
    
    func loadPartyDetails(){
        let date = party?.date
        let title = party?.title
        let theme = party?.theme
        let decoration = party?.decorationList
        let food = party?.foodlist
        
        detailTextView.text = "\tDate : " + (date ?? "01/01/2020") + "\n\n"
        detailTextView.text += "\tTitle : " + title! + "\n\n"
        detailTextView.text += "\tTheme : " + theme! + "\n\n"
        detailTextView.text += "\tDecoration : " + decoration! + "\n\n"
        detailTextView.text += "\tFood : " + food! + "\n\n"
    }
}
