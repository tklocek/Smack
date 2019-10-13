//
//  CircleImage.swift
//  Smack
//
//  Created by Tomek Klocek on 2019-10-11.
//  Copyright © 2019 Tomek Klocek. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {
    

    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
