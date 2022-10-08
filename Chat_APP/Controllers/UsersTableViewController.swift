//
//  UsersTableViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 27/09/2022.
//

import UIKit

class UsersTableViewController: UITableViewController {
    var allUsers : [User] = []
    var filteredUser : [User] = []
    let searchController=UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView=UIView()
        navigationItem.searchController=searchController
        searchController.searchResultsUpdater=self
        downloadUsers()
        self.refreshControl=UIRefreshControl()
        self.tableView.refreshControl=self.refreshControl
        
        
    }

    //MARK: -UIScrollView Delegate function
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.refreshControl!.isRefreshing{
            self.downloadUsers()
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchController.isActive ? filteredUser.count : allUsers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! UsersTableViewCell
        let user=searchController.isActive ? filteredUser[indexPath.row] :allUsers[indexPath.row]
        cell.configureCell(user: user)
        
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
//MARK: -Extention
extension UsersTableViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filteredUser=allUsers.filter({ user ->Bool in
            return user.username.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        tableView.reloadData()
    }
    
    
}
