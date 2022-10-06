//
//  UsersTableViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 27/09/2022.
//

import UIKit

class UsersTableViewController: UITableViewController {
    var allUser : [User]?
    override func viewDidLoad() {
        super.viewDidLoad()
        allUser = [User.currentUser!]
        
        
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! UsersTableViewCell
        cell.configureCell(user: User.currentUser!)
        return cell
    }
    

  

}
