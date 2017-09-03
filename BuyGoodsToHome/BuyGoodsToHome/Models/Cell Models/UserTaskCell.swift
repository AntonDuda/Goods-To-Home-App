//
//  UserTaskCell.swift
//  BuyGoodsToHome
//
//  Created by Anton on 9/3/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit

class UserTaskCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
   
    @IBOutlet weak var userTaskLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        userProfileImage = profileImageView
    }
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "no image icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
}
