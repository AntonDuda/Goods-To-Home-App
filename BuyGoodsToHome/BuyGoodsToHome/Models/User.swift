//
//  User.swift
//  BuyGoodsToHome
//
//  Created by Anton on 8/30/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit

class Users: NSObject {
    
    var id: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    
    init(dictionary: [AnyHashable: Any]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}
