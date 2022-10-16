//
//  ChatTableViewCell.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 12/10/2022.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
//MARK: -IBOutlet
    
    @IBOutlet weak var avatarImageOutlet: UIImageView!
    @IBOutlet weak var lastMessageLableOutlet: UILabel!
    @IBOutlet weak var usernameLableOutlet: UILabel!
    @IBOutlet weak var dateLableOutlet: UILabel!
    @IBOutlet weak var unreadCounterLableOutlet: UILabel!
    @IBOutlet weak var unreadCounterViewOutlet: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       unreadCounterViewOutlet.layer.cornerRadius = unreadCounterViewOutlet.frame.height/2
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(chatRoom: ChatRoom){
        usernameLableOutlet.text=chatRoom.receviverName
        usernameLableOutlet.minimumScaleFactor=0.9
        
        lastMessageLableOutlet.text=chatRoom.lastMessage
        lastMessageLableOutlet.numberOfLines=2
        lastMessageLableOutlet.minimumScaleFactor=0.9
        if chatRoom.unreadCounter != 0{
            self.unreadCounterLableOutlet.text="\(chatRoom.unreadCounter)"
            self.unreadCounterViewOutlet.isHidden=false

        }else{
            self.unreadCounterViewOutlet.isHidden=true
        }
        if chatRoom.avatarLink != ""{
            FileStorage.downloadImage(imageUrl: chatRoom.avatarLink) { avatarImage in
                self.avatarImageOutlet.image=avatarImage?.circleMask
            }
            
        }else {
            self.avatarImageOutlet.image=UIImage(named: "avatar")?.circleMask
        }
        dateLableOutlet.text=timeElapse(chatRoom.date ?? Date())
    }

}
