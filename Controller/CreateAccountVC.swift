//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Tomek Klocek on 2019-10-03.
//  Copyright © 2019 Tomek Klocek. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

}
