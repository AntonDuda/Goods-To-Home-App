//
//  UserToDoVC.swift
//  BuyGoodsToHome
//
//  Created by Anton on 9/3/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit

class UserToDoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableViewToDoList: UITableView!
    
    @IBOutlet weak var navItemTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnAddNewToDo(_ sender: Any) {
    }
    
    @IBAction func btnLogout(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        return cell
    }
}
