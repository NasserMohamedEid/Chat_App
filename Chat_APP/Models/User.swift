//
//  User.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 04/09/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
struct User :Codable,Equatable{
    var id=""
    var username:String
    var email:String
    var pushId=""
    var avatarLink=""
    var status:String
    static var currentId:String{
        return Auth.auth().currentUser!.uid
    }
    static var currentUser : User? {
        if Auth.auth().currentUser != nil{
            if let data=UserDefaults.standard.data(forKey: KCURRENTUSER){
                let decoder = JSONDecoder()
                do{
                    let userObject=try decoder.decode(User.self, from: data)
                    return userObject
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        return nil

    }
    //MARK: - Q1
    static func==(lhs:User,rhs:User)->Bool{
       return rhs.id==lhs.id
    }
}

func saveUserLocally(_ user:User){
    let ecoder=JSONEncoder()
    do{
        let data = try ecoder.encode(user)
        UserDefaults.standard.set(data, forKey: KCURRENTUSER)
    }catch{
        print(error.localizedDescription)
    }
}
func creatDummyUsers(){
    print ("creat dummy user...")
    let name=["Ahmed Salah","Mohamed Eid","Noha Mohamed","Yasser Ahmed","Omer Mohamed"]
    var imageIndex=1
    var UserIndex=1
    for i in 0..<5{
        let id=UUID().uuidString
        let fileDirectory="Avatars/"+"_\(id)"+".jpg"
        FileStorage.uploadImage(UIImage(named: "user\(imageIndex)")!, directory: fileDirectory) { avatarLink in
            let user=User(id:id,username: name[i], email: "user\(UserIndex)@gmail.com",pushId: "",avatarLink: avatarLink ?? "" , status: "No status")
            UserIndex += 1

            FUserListener.shared.saveUserToFirestore(user)
        }
        imageIndex += 1
        if imageIndex==5{
            imageIndex=1
        }

    }
}
