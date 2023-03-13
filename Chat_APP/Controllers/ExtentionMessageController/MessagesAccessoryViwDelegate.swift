//
//  MessagesAccessoryViwDelegate.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 12/01/2023.
//

import Foundation
import InputBarAccessoryView
extension MSGViewController: InputBarAccessoryViewDelegate{
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        
    }
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        send(text: text, photo: nil, video: nil, audio: nil, location: nil)
        messageInputBar.inputTextView.text=""
        messageInputBar.invalidatePlugins()
    }
}
