//
//  ShadowUtil.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/13.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit


class ShadowUtil {
    
    static var colorOne = UIColor.darkGray.cgColor
    
    class func setShadow(view:UIView){
        view.layer.masksToBounds = false
        view.layer.shadowColor = colorOne
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.4//阴影透明度0-1
    }
}
