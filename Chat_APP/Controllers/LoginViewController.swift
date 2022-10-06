//
//  ViewController.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 31/08/2022.
//

import UIKit
import ProgressHUD
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLableOutlet.text=""
        passwordLableOutlet.text=""
        confirmPasswordLableOutlet.text=""
        emailTextFiledOutlet.delegate=self
        passwordTextFiledOutlet.delegate=self
        confirmPasswordTextFiledOutlet.delegate=self
    }
//MARK: -Variable
    var islogin:Bool=false
    
    
    
//MARK: -IBOutlet
    //lable
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var emailLableOutlet: UILabel!
    @IBOutlet weak var confirmPasswordLableOutlet: UILabel!
    @IBOutlet weak var passwordLableOutlet: UILabel!
    @IBOutlet weak var haveAnAccountOutlet: UILabel!
    //TextField
    
    @IBOutlet weak var emailTextFiledOutlet: UITextField!
    @IBOutlet weak var passwordTextFiledOutlet: UITextField!
    @IBOutlet weak var confirmPasswordTextFiledOutlet: UITextField!
    
    //Button Outlet
    
    @IBOutlet weak var forgetPasswordOutlet: UIButton!
    @IBOutlet weak var resendEmailOutlet: UIButton!
    @IBOutlet weak var registerOutlet: UIButton!
    @IBOutlet weak var loginOutlet: UIButton!
    //MARK: -IBAction
    
    
    @IBAction func forgetPasswordPressed(_ sender: UIButton) {
        if isDataInputedFor(mode: "forgetPassword"){
            print ("ok")
            //Todo ->reset password
            forgetPassword()
        }else{
            ProgressHUD.showError("All Fields are required")
            
        }
    }
    @IBAction func resendEmailPressed(_ sender: UIButton) {
        if isDataInputedFor(mode: "forgetPassword"){
            print ("ok")
            //Todo ->resend email
            resendEmailVerification()
        }else{
            ProgressHUD.showError("All Fields are required")
            
        }
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        if isDataInputedFor(mode: islogin ? "login" : "register" ) {
        
            //Todo ->login or register
            islogin ? login():register()
            
           
        }else{
            ProgressHUD.showError("All Fields are required")
            
        }
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        ubdateUiMode(mode:islogin)
    }
    private func ubdateUiMode(mode:Bool){
        if !mode{
            titleOutlet.text="Login"
            confirmPasswordLableOutlet.isHidden=true
            confirmPasswordTextFiledOutlet.isHidden=true
            registerOutlet.setTitle("Login", for: .normal)
            loginOutlet.setTitle("Register", for: .normal)
            haveAnAccountOutlet.text="New Here?"
            forgetPasswordOutlet.isHidden=false
            resendEmailOutlet.isHidden=true
        }else{
            titleOutlet.text="Register"
            confirmPasswordLableOutlet.isHidden=false
            confirmPasswordTextFiledOutlet.isHidden=false
            registerOutlet.setTitle("Register", for: .normal)
            loginOutlet.setTitle("Login", for: .normal)
            haveAnAccountOutlet.text="Have An Account ?"
            forgetPasswordOutlet.isHidden=true
            resendEmailOutlet.isHidden=false
        }
        islogin.toggle()
    }
    private func isDataInputedFor(mode:String)->Bool{
        switch mode{
        case "login":return emailTextFiledOutlet.text != "" && passwordTextFiledOutlet.text != ""
        case "register":return emailTextFiledOutlet.text != "" && passwordTextFiledOutlet.text != "" && confirmPasswordTextFiledOutlet.text != ""
        case "forgetPassword":return emailTextFiledOutlet.text != ""
        default:
            return false
        }
    }
    
    //MARK: -register
    
    private func login(){
        FUserListener.shared.loginUser(email: emailTextFiledOutlet.text!, password: passwordTextFiledOutlet.text!) { error, isVeryfied in
            if error==nil{
                if isVeryfied{
                    //todo go to chat app
                    print ("go to chat app")
                    self.goToApp()
                }else{
                    ProgressHUD.showFailed("please check your email and verify your email")
                }
            }else{
                ProgressHUD.showFailed(error?.localizedDescription)
            }
        }
    }
    

    //MARK: -register
    private func register(){
            if passwordTextFiledOutlet.text!==confirmPasswordTextFiledOutlet.text! {
                FUserListener.shared.registerUserWith(email: emailTextFiledOutlet.text!, password: passwordTextFiledOutlet.text!) { (error) in
                    if error == nil {
                        ProgressHUD.showSucceed("Verification email sent")
                       }else{
                        ProgressHUD.showError(error!.localizedDescription)
                         }
                    }
              }
        }
    
    //MARK: - resende email verification
    private func resendEmailVerification(){
        FUserListener.shared.resendEmailVerification(email: emailTextFiledOutlet.text!) { error in
            if error==nil{
                ProgressHUD.showSucceed("Verification email send")
            }else{
                ProgressHUD.showFailed(error?.localizedDescription)
            }
        }
    }
    //MARK: -forget Password
    private func forgetPassword(){
        FUserListener.shared.forgetPassword(email: emailTextFiledOutlet.text!) { error in
            if error==nil{
                
                ProgressHUD.showSucceed("email send")
            }else{
                ProgressHUD.showFailed(error?.localizedDescription)
            }
        }
    }
    private func goToApp(){
        let mainView=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as! UITabBarController
        mainView.modalPresentationStyle = .fullScreen
        present(mainView, animated: true, completion: nil)
    }
}



//MARK: -UI Text Delegate
extension LoginViewController:UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        emailLableOutlet.text=emailTextFiledOutlet.hasText ? "Email":""
        passwordLableOutlet.text=passwordTextFiledOutlet.hasText ? "Password":""
        confirmPasswordLableOutlet.text=confirmPasswordTextFiledOutlet.hasText ? "Confirm Password":""
    }
}

