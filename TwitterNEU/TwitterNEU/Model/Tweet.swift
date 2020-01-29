//
//  Tweet.swift
//  TwitterNEU
//

import Foundation

class Tweet{
    var author : String = ""
    var body : String = ""
    var uid : String = ""
    var key : String = ""
    
    init(author: String, body: String, uid: String, key: String) {
        self.author = author
        self.body = body
        self.uid = uid
        self.key = key
    }
}
