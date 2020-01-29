//
//  Party.swift
//  PartyPlanner
//
//  Created by Vineet Kaur Bagga on 12/11/19.
//  Copyright © 2019 Vineet Kaur Bagga. All rights reserved.
//

import UIKit

class Party: NSObject {
    
    let partyId: String?
    let title: String?
    let date: String?
    let theme: String?
    let foodlist: String?
    let decorationList: String?
    
    init(partyId:String, title: String, date: String, theme: String, foodList: String, decorationList: String) {
        self.partyId = partyId
        self.title = title
        self.date = date
        self.theme = theme
        self.foodlist = foodList
        self.decorationList = decorationList
        
    }
    
    
}
