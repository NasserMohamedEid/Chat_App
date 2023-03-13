//
//  Outgoing.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 08/03/2023.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift
import Gallery

class Outgoing{
    class func sendMessage(chatId:String,text :String?,photo:UIImage? ,video:String? ,audio :String?,audioDuration:Float=0.0,location:String?,memberIds:[String]){
//        create local messagre from data we have
        let currentUser=User.currentUser!
        let message = LocalMessage()
        message.id=UUID().uuidString
        message.chatId=chatId
        message.senderId=currentUser.id
        message.senderName=currentUser.username
        message.senderInintials=String(currentUser.username.first!)
        message.date=Date()
        message.status=KSENT
         //check message type
        if text != nil{
            sendText (message:message,text:text!,memberIds:memberIds)
        }
        if photo != nil{
            //TODO:- function to send photo
        }
        if audio != nil{
            //TODO:- function to send photo
            
        }
        if location != nil{
            //TODO:- function to send photo
        }
        if video != nil{
            //TODO:- function to send photo
            
        }
        //TODO: -SEND push  notification
        //TODO: Update chat room
    }
    
    class func saveMessage(message :LocalMessage,memberIds:[String]){
        RealmManager.shared.save(message)
        for memberId in memberIds {
            FMessageLisener.shared.addMessage(message, memberId: memberId)
        }
    }
}

func sendText (message:LocalMessage,text :String,memberIds:[String]){
    message.message=text
    message.type=KTEXT
    Outgoing.saveMessage(message: message, memberIds: memberIds)
}
