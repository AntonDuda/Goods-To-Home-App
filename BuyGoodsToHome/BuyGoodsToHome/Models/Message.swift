//
//  Message.swift
//  BuyGoodsToHome
//
//  Created by Anton on 8/30/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    var name: String?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.toId = dictionary["toId"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
        self.name = dictionary["name"] as? String
    }
}
