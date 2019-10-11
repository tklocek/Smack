//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Tomek Klocek on 2019-10-03.
//  Copyright © 2019 Tomek Klocek. All rights reserved.
//

import UIKit
    



class CreateAccountVC: UIViewController, UINavigationControllerDelegate {

    // Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    
    func myFuncInViewControllerA() {
        print("Back to ViewControllerA!")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            print(UserDataService.instance.avatarName)
        } else {
            print("AvatarName is empty")
        }

    }

    func handleAvatarDismissed() {
       print("handleAvatarDissmissed")
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            print(UserDataService.instance.avatarName)
        } else {
            print("AvatarName is empty")
        }
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let name = userNameTxt.text , userNameTxt.text != "" else { return }
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (sucess) in
            if sucess {
               AuthService.instance.loginUser(email: email, password: pass) { (sucess) in
                   if sucess {
                    AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (sucess) in
                        if sucess {
                            print(UserDataService.instance.name, UserDataService.instance.avatarName)
                            self.performSegue(withIdentifier: UNWIND, sender: nil)
                        }
                    }
                    
                    
                   }
               }
            }
        }
        

        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
  
     
            
            performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
      
    }
    

}
