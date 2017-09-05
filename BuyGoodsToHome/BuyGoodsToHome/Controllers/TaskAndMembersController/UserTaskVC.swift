//
//  UserTaskVC.swift
//  BuyGoodsToHome
//
//  Created by Anton on 9/3/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit
import Firebase

class UserTaskVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let cellId = "cell"
    
    @IBOutlet weak var tableViewUserTask: UITableView!
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    tableViewUserTask.rowHeight = UITableViewAutomaticDimension
    tableViewUserTask.estimatedRowHeight = 100

    observeMessages()

}
    
var messages = [Message]()
    func observeMessages() {
    FIRDatabase.database().reference().child("message").observe(.childAdded, with: { (snapshot) in
            
        if let dictionary = snapshot.value as? [String: AnyObject] {
            let message = Message(dictionary: dictionary)
                if message.toId == FIRAuth.auth()?.currentUser?.uid {
                    self.messages.append(message)
                }
            DispatchQueue.main.async(execute: {
                self.tableViewUserTask.reloadData()
                })
            }
        }, withCancel: nil)
    }

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "send", for: indexPath) as! UserTaskCell

    let message = messages[indexPath.row]
        
    let seconds = message.timestamp?.doubleValue
        
    let timestampDate = Date(timeIntervalSince1970: seconds!)
        
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM hh:mm a"
        
        cell.taskSenderLabel.text = message.name
        cell.userTaskLabel?.text = message.text
        cell.timeLabel.text = dateFormatter.string(from: timestampDate)
        
return cell
    }
}
