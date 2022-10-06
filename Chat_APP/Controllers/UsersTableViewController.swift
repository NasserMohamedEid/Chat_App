//
//  UsersTableViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 27/09/2022.
//

import UIKit

class UsersTableViewController: UITableViewController {
    var allUsers : [User]?
    override func viewDidLoad() {
        super.viewDidLoad()
        allUsers = [User.currentUser!]
        
        downloadUsers()
        
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if allUsers != nil{
            return allUsers!.count
        }
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! UsersTableViewCell
        if allUsers != nil{
            cell.configureCell(user: allUsers![indexPath.row])
        }else{
            cell.configureCell(user: User.currentUser!)
        }
        
        return cell
    }
    
//MARK: -download all user from fire store
    private func downloadUsers(){
        FUserListener.shared.downloadAllUsersFromFirestore { firestoreAllUser in
            self.allUsers=firestoreAllUser
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
