//
//  FChatRoomLisener.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 03/01/2023.
//

import Foundation
import Firebase
class FChatRoomLisener{
    static let shared=FChatRoomLisener()
    private init(){}
    func saveChatRoom(_ chatRoom:ChatRoom){
        do{
           try FirestoreReference(.Chat).document(chatRoom.id).setData(from : chatRoom)
        }catch
        {print ("No able to save document ",error.localizedDescription)}
    }
    
    //MARK: -Delete chat Room
    func deleteChatRoom(_ chatRoom:ChatRoom){
        FirestoreReference(.Chat).document(chatRoom.id).delete()
    }
    
    //MARK: -Download All Chat Room
    
    func downloadChatRoom(completion:@escaping ([ChatRoom])->Void){
        FirestoreReference(.Chat).whereField( KSENDERID, isEqualTo: User.currentId).addSnapshotListener { snapshot, error in
            var chatRooms:[ChatRoom]=[]
            guard let document=snapshot?.documents else{
                print("no document found ")
                return
            }
            let allchatRoom=document.compactMap { snapshot->ChatRoom? in
                return try? snapshot.data(as:ChatRoom.self)
            }
            
            for chatRoom in allchatRoom{
                if chatRoom.lastMessage != ""{
                    chatRooms.append(chatRoom)
                }
            }
            
            chatRooms.sort(by: {$0.date!>$1.date!})
            completion(chatRooms )
        }

    }
    
}
