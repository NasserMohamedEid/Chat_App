//
//  FileStorage.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 23/09/2022.
//

import Foundation
import UIKit
import ProgressHUD
import FirebaseStorage
import Gallery
let storage = Storage.storage()
class FileStorage{
    class func uploadImage(_ image:UIImage,directory:String,completion:@escaping(_ documentLink:String?)->Void){
        //create folder on firestore
        let storageRef=storage.reference(forURL: kFILEREFRANCE).child(directory)
//        convert the image to data
        let imageData=image.jpegData(compressionQuality: 0.5)
//        put the data into firestore and return the link
        var task :StorageUploadTask!
        task=storageRef.putData(imageData!, metadata:nil, completion: { metaData, error in
            task.removeAllObservers()
            ProgressHUD.dismiss()
            if error != nil{
                print ("Error Uploading image\(error!.localizedDescription)")
                return
            }
            storageRef.downloadURL { url, error in
                guard let downloadUrl = url else{
                    completion(nil)
                    return
                }
                completion(downloadUrl.absoluteString)
            }
        })
        //Observe percentage Upload
        task.observe(StorageTaskStatus.progress) { snapshot in
            let progress=snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
            ProgressHUD.showProgress(CGFloat( progress))
        }
    }
    class func downloadImage(imageUrl:String,complition:@escaping (_ image:UIImage?)->Void){
        let imageFileName=fileNameFrom(fileUrl: imageUrl)
        if fileExistsPath(path: imageFileName){
            if let contentsOfFile = UIImage(contentsOfFile: fileInDocumentsDirectory(fileName: imageFileName)){
                complition(contentsOfFile)
                
            }else{
                print("could not convert local image")
                complition(UIImage(named: "avatar")!)
                
            }
        }else{
            if imageUrl != ""{
                let documentUrl=URL(string: imageUrl)
                let downloadQueue=DispatchQueue(label: "imageDownloadQueue")
                downloadQueue.async {
                    let data = NSData(contentsOf: documentUrl!)
                    if data != nil{
                        FileStorage.saveFileLocally(fileData: data!, fileName: imageFileName)
                        DispatchQueue.main.async {
                            complition(UIImage(data: data! as Data))
                        }
                    }
                }
            }else{
                print ("no document found in database")
                complition(nil)
            }
            
        }
    }
    //MARK: -save data locally
    class func saveFileLocally(fileData:NSData,fileName:String){
        let docUrl=getDocument().appendingPathComponent(fileName, isDirectory: false)
        fileData.write(to: docUrl, atomically: true)
    }
}
