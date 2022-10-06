//
//  UsersTableViewCell.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 27/09/2022.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
//MARK: -IBOutlet
    
    @IBOutlet weak var avatarImageViewOutlet: UIImageView!
    @IBOutlet weak var statusLableOutlet: UILabel!
    @IBOutlet weak var userNameLableOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(user:User){
        userNameLableOutlet.text=user.username
        statusLableOutlet.text=user.status
        if user.avatarLink != ""{
            FileStorage.downloadImage(imageUrl: user.avatarLink) { avatarImage in
                self.avatarImageViewOutlet.image=avatarImage?.circleMask
            }
            
        }else{
            self.avatarImageViewOutlet.image=UIImage(named: "avatar")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
