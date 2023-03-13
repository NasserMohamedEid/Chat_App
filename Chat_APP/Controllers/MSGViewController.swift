//
//  MSGViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 08/01/2023.
//

import UIKit
import MessageKit
import Gallery
import RealityKit
import InputBarAccessoryView

class MSGViewController: MessagesViewController  {
    //MARK: -var
    private var chatId=""
    private var recipientId=""
    private var recipientName=""
    let refresControler=UIRefreshControl()
    let micButton=InputBarButtonItem()
    
    let currentuser=MKSender(senderId: User.currentId, displayName: User.currentUser!.username)
    let mkMessage :[MKMessage]=[]
    //MARK: -init
    init(chatId: String, recipientId: String , recipientName: String) {
        super.init(nibName: nil, bundle: nil )
        self.chatId = chatId
        self.recipientId = recipientId
        self.recipientName = recipientName
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder )
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configMessageViewController()
        configMessageInputBar()
     
    }
    
    private func configMessageViewController(){
        messagesCollectionView.messagesDataSource=self
        messagesCollectionView.messageCellDelegate=self
        messagesCollectionView.messagesDisplayDelegate=self
        messagesCollectionView.messagesLayoutDelegate=self
        
        //scrol Down When load Message
        scrollsToLastItemOnKeyboardBeginsEditing=true
        maintainPositionOnKeyboardFrameChanged=true
        messagesCollectionView.refreshControl=refresControler
    }
    
    private func configMessageInputBar(){
        messageInputBar.delegate=self
        let attachButton=InputBarButtonItem()
        attachButton.image=UIImage(systemName: "paperclip", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        attachButton.setSize(CGSize(width: 30, height: 30), animated: false )
        attachButton.onTouchUpInside { _ in
            print("attach Button")
                //TODO ATTACH Action
        }
        let micButton=InputBarButtonItem()
        micButton.image=UIImage(systemName: "mic.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        micButton.setSize(CGSize(width: 30, height: 30), animated: false )
        
        //add gesture recognizer
        messageInputBar.setStackViewItems([attachButton], forStack: .left, animated: false)
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        //update mic Button
        updateMicButtonStatus(show:false)
        messageInputBar.inputTextView.isImagePasteEnabled=false
        messageInputBar.backgroundView.backgroundColor = .systemBackground
        messageInputBar.inputTextView.backgroundColor  = .systemBackground
    }
    func updateMicButtonStatus(show:Bool){
        if show{
            messageInputBar.setStackViewItems([micButton], forStack: .right, animated: false)
            messageInputBar.setRightStackViewWidthConstant(to: 30, animated: false)
        }
        else{messageInputBar.setStackViewItems([messageInputBar.sendButton], forStack: .right, animated: false)
            messageInputBar.setRightStackViewWidthConstant(to: 55, animated: false)
            
        }
    }
    //MARK: -Actions
    func send(text:String?,photo:UIImage?,video:String?,audio:String?
              ,location :String?,audioDuration :Float=0.0){
        Outgoing.sendMessage(chatId: chatId, text: text, photo: photo, video: video, audio: audio, location: location, memberIds: [User.currentId,recipientId])
    }
}
