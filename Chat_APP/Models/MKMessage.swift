//
//  MKMessage.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 07/03/2023.
//

import Foundation
import MessageKit
class MKMessage : NSObject,MessageType{
    var messageId: String
    var kind: MessageKit.MessageKind
    var sentDate: Date
    var mkSender:MKSender
    var sender: MessageKit.SenderType {return mkSender}
    var senderIntials: String
    var status:String
    var readDate :Date
    var incoming :Bool
    init(message : LocalMessage) {
        self.messageId=message.id
        self.mkSender = MKSender(senderId: message.senderId, displayName: message.senderName)
        self.status=message.status
        self.kind=MessageKind.text(message.message)
        self.senderIntials=message.senderInintials
        self.sentDate = message.date
        self.readDate=message.readeDate
        self.incoming=User.currentId != mkSender.senderId
        
    }
    



    
}
