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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
