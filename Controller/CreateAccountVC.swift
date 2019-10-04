//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Tomek Klocek on 2019-10-03.
//  Copyright © 2019 Tomek Klocek. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    // Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (sucess) in
            if sucess {
                print("registered user")
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

    
    
    
}
