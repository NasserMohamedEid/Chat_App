//
//  ChatRoom.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 12/10/2022.
//

import Foundation
import FirebaseFirestoreSwift
struct ChatRoom:Codable{
    var id=""
    var chatRoomId=""
    var senderId=""
    var receviverId=""
    var receviverName=""
    @ServerTimestamp var date=Date()
    var memberIds=[""]
    var lastMessage=""
    var unreadCounter=0
    var avatarLink=""
}
