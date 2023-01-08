//
//  StartChat.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 17/10/2022.
//

import Foundation
import Firebase


func  restartChat(chatRoomId: String, membersId :[String]){
    FUserListener.shared.downloadUsersFromFireStore(withIds: membersId) { allUsers in
        if allUsers.count>0{
            creatChatRooms(chatRoomId: chatRoomId, users: allUsers)
        }
    }
}

func startChat(sender:User,receiver:User)->String{
    var chatRoomId=""
    let value=sender.id.compare(receiver.id).rawValue
    chatRoomId=value < 0 ? (sender.id+receiver.id):(receiver.id+sender.id)
    creatChatRooms(chatRoomId: chatRoomId, users: [sender,receiver])
    return chatRoomId
}
func creatChatRooms(chatRoomId:String,users:[User]){
    //if user have already chatroom id
    
    
    var usersToCreatChatsFor:[String]=[]
    for user in users{
        usersToCreatChatsFor.append(user.id)
    }
    FirestoreReference(.Chat).whereField(KCHATROOMID,isEqualTo: chatRoomId).getDocuments { querySnapshot, error in
        guard let snapshot=querySnapshot else{return}
        if !snapshot.isEmpty{
            for chatData in snapshot.documents{
                let currentChat = chatData.data() as Dictionary
                if let currentUserId=currentChat[KSENDERID]{
                    if usersToCreatChatsFor.contains(currentUserId as!String){
                        usersToCreatChatsFor.remove(at: usersToCreatChatsFor.firstIndex(of: currentUserId as! String)!)
                    }
                }
                
            }
        }
        for userId in usersToCreatChatsFor{
            let senderUser=userId==User.currentId ? User.currentUser! :getRecerFrom(users: users)
            let recevierUser=userId==User.currentId ?  getRecerFrom(users: users):User.currentUser!
            
            let chatRoomObject = ChatRoom(id: UUID().uuidString,chatRoomId: chatRoomId,senderId: senderUser.id,senderName: senderUser.username,receviverId: recevierUser.id,receviverName: recevierUser .username,date:  Date(),memberIds: [senderUser.id,recevierUser.id],lastMessage: "",unreadCounter: 0,avatarLink: recevierUser.avatarLink)
            
            //save chat Room
            FChatRoomLisener.shared.saveChatRoom(chatRoomObject)
            
        }
        
    }
}
func getRecerFrom(users:[User])->User{
    var allUser=users
    
    allUser.remove(at: allUser.firstIndex(of: User.currentUser!)!)
    return allUser.first!
}
