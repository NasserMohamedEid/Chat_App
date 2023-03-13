//
//  RealmManager.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 08/03/2023.
//

import Foundation
import RealmSwift
class RealmManager {
    static let shared = RealmManager()
    let realm = try! Realm()
    private init(){}
    func save<T: Object>(_ object :T){
        do{
            realm.add( object, update:.all)
        }catch{
            print ("error saving data ", error.localizedDescription)
        }
    }
}
