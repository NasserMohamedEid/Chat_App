//
//  ChatRoomTableViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 15/10/2022.
//

import UIKit

class ChatRoomTableViewController: UITableViewController {
    @IBAction func composeButtonPressed(_ sender: UIBarButtonItem) {
        let userView=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "usersView")as! UsersTableViewController
        navigationController?.pushViewController(userView, animated: true)
         
    }
    //MARK: -var
    var chatRooms:[ChatRoom]=[]
    var filterChatRoom:[ChatRoom]=[]
    let searchController=UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView=UIView()
        downloadChatRooms()
        navigationItem.searchController=searchController
        searchController.searchResultsUpdater=self
        
        
      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  searchController.isActive ? filterChatRoom.count : chatRooms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatTableViewCell 
//        let chat = ChatRoom(id:"123",chatRoomId: "123",senderId: "123",receviverName: "MOHAMED",date: Date(),memberIds:[""], lastMessage: "hi nasser how are you hi nasser how are you ",unreadCounter: 3,avatarLink: "")
        cell.configure(chatRoom: searchController.isActive ? filterChatRoom[indexPath.row] : chatRooms[indexPath.row])
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
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let chatRoom=searchController.isActive ? filterChatRoom[indexPath.row] : chatRooms[indexPath.row]
            FChatRoomLisener.shared.deleteChatRoom(chatRoom)
            searchController.isActive ? filterChatRoom.remove(at: indexPath.row) : chatRooms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
            
             
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomObject=searchController.isActive ? filterChatRoom[indexPath.row] : chatRooms[indexPath.row]
        goToMSG(chatRoom:chatRoomObject)
    }
    //MARK: -Navigation
    func goToMSG(chatRoom:ChatRoom){
        //MARK: -make sure all user have chat room
        restartChat(chatRoomId: chatRoom.chatRoomId, membersId: chatRoom.memberIds)
        
        
        let privateMSGView=MSGViewController(chatId: chatRoom.id, recipientId: chatRoom.receviverId, recipientName: chatRoom.receviverName)
        navigationController?.pushViewController(privateMSGView, animated: true)
    }
}
extension ChatRoomTableViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterChatRoom=chatRooms.filter({ chatRoom ->Bool in
            return chatRoom.receviverName.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        tableView.reloadData()
    }
    
}
