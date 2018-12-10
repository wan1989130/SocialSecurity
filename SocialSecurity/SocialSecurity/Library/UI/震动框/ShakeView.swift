//
//  ShakeView.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/14.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ShakeView: UIView {

    @IBOutlet var constraint3: NSLayoutConstraint!
    @IBOutlet var constraint2: NSLayoutConstraint!
    @IBOutlet var constraint1: NSLayoutConstraint!
    @IBAction func cancelClick(_ sender: Any) {
        self.hideInWindow()
        
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        constraint1.constant = 8 * (ScreenHeight/667)
        constraint2.constant = 24 * (ScreenHeight/667)
        constraint3.constant = 24 * (ScreenHeight/667)
    }
}
