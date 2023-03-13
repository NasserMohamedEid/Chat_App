//
//  MessagesDataSource.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 12/01/2023.
//

import Foundation
import MessageKit
extension MSGViewController: MessagesDataSource{
    func currentSender() -> MessageKit.SenderType {
        return currentuser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return mkMessage[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return mkMessage.count
    }
    
    
}
