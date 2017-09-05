//
//  UserToDoVC.swift
//  BuyGoodsToHome
//
//  Created by Anton on 9/3/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit
import Firebase

class UserToDoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayFood: [String] = []
    var volueToPass = String()

    @IBOutlet weak var tableViewToDoList: UITableView!
    
    @IBOutlet weak var navItemTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewToDoList.rowHeight = UITableViewAutomaticDimension
        tableViewToDoList.estimatedRowHeight = 150
        
        saveData()
    }

    // MARK: - Action for buttons
    
    @IBAction func btnAddNewToDo(_ sender: Any) {
        let newTask = NewTaskVC()
        present(newTask, animated: true, completion: nil)
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LogInViewControl()
        present(loginController, animated: true, completion: nil)
    }
    
    // MARK: - Save data from Firebase to array
    
    func saveData() {
        guard  let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        FIRDatabase.database().reference().child("list").child(uid).observe(.childAdded, with: { (snapshot) in
            if let user = snapshot.value as? String {
                
                let post = user
                
                self.arrayFood.append(post)
                self.tableViewToDoList.reloadData()
            }
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFood.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        
        let list = arrayFood[indexPath.row]
        cell.lebelUserToDoList.text = list
        
        return cell
    }
    // MARK: Custom swipe
    
    public func tableView(_ tableView:UITableView, editActionsForRowAt indexPath: IndexPath) -> [ UITableViewRowAction]? {
        
        let send = UITableViewRowAction(style: .normal, title: "Send")
        { action, index in
            print("Send")
            let goods = self.arrayFood[indexPath.row]
            let newControl = UsersTableVC()
            let navControl = UINavigationController(rootViewController: newControl)
            self.volueToPass = goods
            newControl.dataSend = [self.volueToPass]
            print(self.volueToPass)
            self.present(navControl, animated: true, completion: nil)
            
        }
        send.backgroundColor = .blue
        
        let done = UITableViewRowAction(style: .normal, title: "Done") { action, index in print("Done")
            self.tableViewToDoList.reloadData()
            let selectedCell = tableView.cellForRow(at: indexPath)
            selectedCell?.contentView.backgroundColor = UIColor.green
        }
        done.backgroundColor = .green
        
        return [send, done]
    }

}
