//
//  NSData+LH.swift
//  HandleSchool
//
//  Created by 李琪 on 16/9/21.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import UIKit

extension Data {
    func hexString() -> String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
}
