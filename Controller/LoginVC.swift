//
//  LoginVC.swift
//  Smack
//
//  Created by Tomek Klocek on 2019-10-03.
//  Copyright © 2019 Tomek Klocek. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
}
