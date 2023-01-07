//
//  ChatRoomTableViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 15/10/2022.
//

import UIKit

class ChatRoomTableViewController: UITableViewController {
//MARK: -var
    var chatRooms:[ChatRoom]=[]
    var filterChatRoom:[ChatRoom]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView=UIView()
        downloadChatRooms()
      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatRooms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatTableViewCell 
//        let chat = ChatRoom(id:"123",chatRoomId: "123",senderId: "123",receviverName: "MOHAMED",date: Date(),memberIds:[""], lastMessage: "hi nasser how are you hi nasser how are you ",unreadCounter: 3,avatarLink: "")
        cell.configure(chatRoom: chatRooms[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    
    private func downloadChatRooms(){
        FChatRoomLisener.shared.downloadChatRoom { allchatRooms in
            self.chatRooms=allchatRooms
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
