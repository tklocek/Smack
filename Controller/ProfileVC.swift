//
//  ProfileVC.swift
//  Smack
//
//  Created by Tomek Klocek on 2019-10-14.
//  Copyright © 2019 Tomek Klocek. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    // Outlets
    @IBOutlet weak var closeModalPressed: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView() {
        self.profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        self.userName.text = UserDataService.instance.name
        self.userEmail.text = UserDataService.instance.email
        self.profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }

    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
