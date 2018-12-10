//
//  ViewController+LH.swift
//  HandleSchool
//
//  Created by 李琪 on 15/11/20.
//  Copyright © 2015年 Huihai. All rights reserved.
//

import UIKit

extension  UIViewController {
    /**
     * 获取某storyBoard中的viewController
     */
    class func getViewController(_ storyboardName:String, storyboardId:String)->UIViewController?{
        let storyboard:UIStoryboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let vc:UIViewController = storyboard.instantiateViewController(withIdentifier: storyboardId)
        return vc
    }
}
