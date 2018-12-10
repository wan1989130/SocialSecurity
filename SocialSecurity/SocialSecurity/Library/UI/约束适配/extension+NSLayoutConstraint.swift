//
//  extension+NSLayoutConstraint.swift
//  size-class
//
//  Created by 王岩 on 2018/6/15.
//  Copyright © 2018年 王岩. All rights reserved.
//

import Foundation
import UIKit
let iphone5  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:960,height:1336), (UIScreen.main.currentMode?.size)!) : false
let iphone6  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:750,height:1334), (UIScreen.main.currentMode?.size)!) : false
let iphone6p  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1242,height:2208), (UIScreen.main.currentMode?.size)!) : false
let iphone6pBigMode = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2001), (UIScreen.main.currentMode?.size)!) : false
let iphoneX = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2436), (UIScreen.main.currentMode?.size)!) : false

//适配参数
let suitParm:CGFloat = (iphone6p ? 1.12 : (iphone6 ? 1.0 : (iphone6pBigMode ? 1.01 : (iphoneX ? 1.0 : 0.85))))

import Foundation
import UIKit
extension NSLayoutConstraint {
    @IBInspectable var adapterScreen: Bool {
        get {
            return true
        }
        
        set {
            if newValue {
                self.constant = self.constant * suitParm
            }
            
        }
    }
    
}


