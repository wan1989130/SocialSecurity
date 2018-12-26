//
//  PhoneType.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2018/12/13.
//  Copyright © 2018年 MR. All rights reserved.
//

import UIKit

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}
