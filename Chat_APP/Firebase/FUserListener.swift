//
//  FUserListner.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 04/09/2022.
//

import Foundation
import Firebase
class FUserListener{
    static let shared=FUserListener()
    private init() {}
    //MARK: -Login
    func loginUser(email:String,password:String,complition:@escaping (_ error:Error?,_ isVeryfied:Bool)->Void){
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
//            && authDataResult!.user.isEmailVerified
            if error == nil  {
                complition(error,true)
                self.downloadFromFirestore(userId:authDataResult!.user.uid)
            }else{
                complition(error,false)
            }
        }
        
    }
    
    
    //MARK: -Register
    func registerUserWith(email:String,password:String,complition:@escaping (_ error:Error?)->Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] (authResult, error) in
            complition(error)
            if error == nil{
                Auth.auth().currentUser?.sendEmailVerification{ (error) in
                    complition(error)
                }
            }
            
            if authResult?.user != nil{
                let user=User(id: authResult!.user.uid, username: email, email: email, pushId: "", avatarLink: "", status: "Hey ,Iam using chat app")
                saveUserToFirestore(user)
                saveUserLocally(user)
            }
        }
    }
    
    
    
    func saveUserToFirestore(_ user:User){
        do{
           try FirestoreReference(.User).document(user.id).setData(from:user)

        }catch{
            
        }
    }
    
    //MARK: -download From Firestore
  private  func downloadFromFirestore(userId:String)
    {
        FirestoreReference(.User).document(userId).getDocument { document, error in
            guard let userDocument=document else{
                print ("no data found")
                return
            }
            //transforme result
            let result=Result{
                try? userDocument.data(as: User.self)
            }
            switch result {
            case .success(let userObject):
                if let user = userObject {
                    saveUserLocally(user)
                    
                }else {
                    print ("Document does not exist")
                }
            case .failure(let failure):
                print(failure.localizedDescription,"error")
            }
        }
    }
    //MARK: -resend Email Verification
    func resendEmailVerification(email:String,completion:@escaping (_ error:Error?)->Void){
        Auth.auth().currentUser?.reload(completion: { error in
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                completion(error)
            })
        })
    }
    //MARK: -Logout
    func logoutCurrentUser(completion:@escaping (_ error:Error?)->Void){
        do{
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: KCURRENTUSER)
            UserDefaults.standard.synchronize() //MARK: -> Q
            completion(nil)
        }catch let error as NSError {
                completion(error)
            }
        
    }
    //MARK: -Forget password
    func forgetPassword(email:String,completion:@escaping (_ error:Error?)->Void){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }

}
