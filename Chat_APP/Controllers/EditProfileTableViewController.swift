//
//  EditProfileTableViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 19/09/2022.
//

import UIKit
import Gallery
import ProgressHUD
class EditProfileTableViewController: UITableViewController, UITextFieldDelegate {
    var gallary:GalleryController!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView=UIView()
        
        configureTextField()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        showUserInfo()
    }
    //MARK: - IBOutlets
    
    @IBOutlet weak var avatarImageViewOutlet: UIImageView!
    
    
    @IBOutlet weak var statusLableOutlet: UILabel!
    @IBOutlet weak var usernameTextFieldOutlet: UITextField!
    //MARK: -IBActions
 
    @IBAction func editButtonPressed(_ sender: UIButton) {
        showGallery()
    }
    //MARK: -Table view datasource
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 || section == 1 ? 0.0: 30.0
    }
   
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView=UIView()
        headerView.backgroundColor=UIColor(named: "colorTableview")
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    //MARK: -Show User info
    func showUserInfo(){
        if let user=User.currentUser{
            usernameTextFieldOutlet.text=user.username
            statusLableOutlet.text=user.status
            if user.avatarLink != ""{
                FileStorage.downloadImage(imageUrl: user.avatarLink) { avatarImage in
                    self.avatarImageViewOutlet.image=avatarImage?.circleMask
                }
            }
        }
    }
    //MARK: - Configure Textfield
    private func configureTextField(){
        usernameTextFieldOutlet.delegate=self
        usernameTextFieldOutlet.clearButtonMode = .whileEditing
    }
    //MARK: -Gallary
    private func showGallery(){
        gallary=GalleryController()
        gallary.delegate=self
        Config.tabsToShow=[.imageTab,.cameraTab]
        Config.Camera.imageLimit=1
//        Config.initialTab = .imageTab
        self.present(gallary, animated: true, completion: nil)
    }
    //MARK: -Text Field delegate Function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextFieldOutlet{
            if textField.text != "" {
                if var user=User.currentUser{
                    user.username = textField.text!
                    saveUserLocally(user)
                    FUserListener.shared.saveUserToFirestore(user)                }
            }
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    private func uploadAvatarImage(_ image:UIImage){
        let fileDirectory = "Avatars/"+"_\(User.currentId)"+".jpg"
        FileStorage.uploadImage(image, directory: fileDirectory) { avatarLink in
            if var user=User.currentUser{
                user.avatarLink=avatarLink ?? ""
                saveUserLocally(user)
                FUserListener.shared.saveUserToFirestore(user)
            }
                //TODO:- Save image locally
            FileStorage.saveFileLocally(fileData: image.jpegData(compressionQuality: 0.5)! as NSData, fileName: User.currentId)
        }
    }
    
}
extension EditProfileTableViewController:GalleryControllerDelegate{
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count>0{
            images.first!.resolve { avatarImage in
                if avatarImage != nil{
                    self.uploadAvatarImage(avatarImage!)
                    self.avatarImageViewOutlet.image=avatarImage?.circleMask
                }else{
                    ProgressHUD.showError("Coud not Select image")
                }
            }
        }
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section==2&&indexPath.row==0{
            performSegue(withIdentifier: "editProfileToStatusSegue", sender: Self.self)
        }
    }
}
    //HELPERS
func getDocument()->URL{
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
}
func fileInDocumentsDirectory(fileName:String)->String{
    return getDocument().appendingPathComponent(fileName).path
}
func fileExistsPath(path:String)->Bool{
    return FileManager.default.fileExists(atPath: fileInDocumentsDirectory(fileName: path))
}

