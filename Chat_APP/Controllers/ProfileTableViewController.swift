//
//  ProfileTableViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 09/10/2022.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    var user:User?
//MARK: -IB Outlets
    
    @IBOutlet weak var avatarImageViewOutlet: UIImageView!
    @IBOutlet weak var usernameLableOutlet: UILabel!
    @IBOutlet weak var statusLableOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        tableView.tableFooterView=UIView()
      setupUI()
    }

    private func setupUI(){
        if user != nil{
            self.title=user?.username
            usernameLableOutlet.text=user?.username
            statusLableOutlet.text=user?.status
            if user?.avatarLink != ""{
                FileStorage.downloadImage(imageUrl: user!.avatarLink) {  avatarImage in
                    self.avatarImageViewOutlet.image=avatarImage?.circleMask
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0: 0.0
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.0
    }
   
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView=UIView()
//        headerView.backgroundColor=UIColor(named: "colorTableview")
//        return headerView
//    }
  
}
