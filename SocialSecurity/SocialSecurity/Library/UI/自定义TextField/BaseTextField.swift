//
//  BaseTextField.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/10/13.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setValue(UIColor.lightGray, forKeyPath: "_placeholderLabel.textColor")
    }

}
