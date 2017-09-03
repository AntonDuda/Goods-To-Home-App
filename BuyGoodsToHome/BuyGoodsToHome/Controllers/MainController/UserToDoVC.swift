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
    

    @IBOutlet weak var tableViewToDoList: UITableView!
    
    @IBOutlet weak var navItemTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        return cell
    }
}
