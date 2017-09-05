//
//  UsersTableVC.swift
//  BuyGoodsToHome
//
//  Created by Anton on 8/30/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit
import Firebase

class UsersTableVC: UITableViewController {

    var dataSend = [String]()
    
    let cellId = "Cell"
    
    var usersArray = [Users]()
    
override func viewDidLoad() {
    super.viewDidLoad()
        
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
    tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
    fetchUser()
}
    
func fetchUser() {
    
    FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
        if let dictionary = snapshot.value as? [String: AnyObject] {
            let user = Users(dictionary: dictionary)
                user.id = snapshot.key
            self.usersArray.append(user)
                
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
                })
            }
    
        }, withCancel: nil)
    }
    
func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
    let user = usersArray[indexPath.row]
        print(user)
       
    cell.textLabel?.text = user.name
    cell.detailTextLabel?.text = user.email
        
    if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
    return cell
}
    
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 72
    }
    
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let sender = usersArray[indexPath.row]
        
    let fromId = FIRAuth.auth()!.currentUser!.uid
    let toId = sender.id!
    let name = sender.name!
    let ref = FIRDatabase.database().reference().child("message")
    let childRef = ref.childByAutoId()
    
    let text = dataSend.first!
    let timestamp = Int(Date().timeIntervalSince1970)
    let values = ["text": text, "toId": toId, "fromId": fromId, "timestamp": timestamp, "name": name] as [String : Any]
    childRef.updateChildValues(values)
        dismiss(animated: true, completion: nil)
    }
}

class UserCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
    detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
}

let profileImageView:UIImageView = {
    let imageView = UIImageView()
        imageView.image = UIImage(named: "no image icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
    return imageView
}()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)

        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
  }
}
