//
//  StatusTableViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 24/09/2022.
//

import UIKit

class StatusTableViewController: UITableViewController {

    let status=["Available","busy","I am sleeping","Dardesh Only","At work","Can't Talk "]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView=UIView()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return status.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=status[indexPath.row]
        let userStatus=User.currentUser?.status
        cell?.accessoryType=userStatus==status[indexPath.row] ?.checkmark:.none
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userStatus=tableView.cellForRow(at: indexPath)?.textLabel?.text
        tableView.reloadData()
        var user=User.currentUser
        user?.status=userStatus!
        saveUserLocally(user!)
        FUserListener.shared.saveUserToFirestore(user!)
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headearView=UIView()
        headearView.backgroundColor=UIColor(named:"colorTableview" )
        return headearView
    }
}
