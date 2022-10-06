//
//  SettingTableViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 12/09/2022.
//

import UIKit

class SettingTableViewController: UITableViewController {
//MARK: -IBOutlet
  
    @IBOutlet weak var avatarImageOutlet: UIImageView!
    
    @IBOutlet weak var statusLablOutlet: UILabel!
    @IBOutlet weak var usernameOutlet: UILabel!
    @IBOutlet weak var appVersionLableOutlet: UILabel!
    //MARK: -Lifecycle of table view
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView=UIView()
        ShowUserInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        ShowUserInfo()
    }
//MARK: -IBAction
    
    @IBAction func termsButtonPressed(_ sender: UIButton) {
    }
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        FUserListener.shared.logoutCurrentUser { error in
            if error==nil{
                let loginView=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self.present(loginView, animated: true, completion: nil)
                }
                
                
            }
        }
    }
    @IBAction func tellFriendButtonPressed(_ sender: UIButton) {
    }
    //MARK: -table View Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headearView=UIView()
        headearView.backgroundColor=UIColor(named:"colorTableview" )
        return headearView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 30.0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 0.0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section==0 && indexPath.row==0{
            performSegue(withIdentifier: "SettingToEditPrrofileSegua", sender: Self.self)
        }
    }
    //MARK: -Update UI
    private func ShowUserInfo(){
        if let user=User.currentUser{
            usernameOutlet.text=user.username
            statusLablOutlet.text=user.status
            appVersionLableOutlet.text = "App Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"]as? String ?? "")"
            if user.avatarLink != ""{
                //TODO: Download and Set avatar
                print (user.avatarLink)
                FileStorage.downloadImage(imageUrl: user.avatarLink) { image in
                    print(image)
                    self.avatarImageOutlet.image=image?.circleMask
                }
            }
        }
    }
}
