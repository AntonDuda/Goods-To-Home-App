//
//  UserTaskVC.swift
//  BuyGoodsToHome
//
//  Created by Anton on 9/3/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit

class UserTaskVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableViewUserTask: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sender") as! UserTaskCell

        
        
        return cell
    }


}
