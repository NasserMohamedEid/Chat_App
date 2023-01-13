//
//  LocalMessage.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 12/01/2023.
//

import Foundation
import RealmSwift
class LocalMessage:Object,Codable{
    @objc dynamic var id = ""
    @objc dynamic var chatId = ""
    @objc dynamic var date = Data()
    @objc dynamic var senderId=""
    @objc dynamic var senderName=""
    @objc dynamic var senderInintials=""
    @objc dynamic var readeDate=Date()
    @objc dynamic var type = ""
    @objc dynamic var status = ""
    @objc dynamic var message = ""
    @objc dynamic var audioUrl=""
    @objc dynamic var videoUrl=""
    @objc dynamic var pictureUrl=""
    @objc dynamic var Longitude=0.0
    @objc dynamic var latitude=0.0
    @objc dynamic var audioDuration=0.0
    
    override class func primaryKey()->String{
        return "id"
    }
    
    
    
}
