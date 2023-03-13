//
//  FMessageLisener.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 08/03/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
class FMessageLisener{
    static let shared = FMessageLisener()
    private init(){}
    func addMessage(_ message : LocalMessage ,memberId: String ){
        do{
            try FirestoreReference(.Message).document(memberId).collection(message.chatId).document(message.id).setData(from: message)
        }catch{
            print ("error saving message to firestore",error.localizedDescription)
        }
        
    }
        
}
