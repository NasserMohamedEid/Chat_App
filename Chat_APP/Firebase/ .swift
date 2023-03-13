//
//  FCollectionRefrance.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 04/09/2022.
//

import Foundation
import Firebase

enum FCollectionReference:String{
    case User
    case Chat
    case Message 
}
func FirestoreReference(_ collectionReference:FCollectionReference)->CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
