//
//  UIViewController+LH.swift
//  HandleSchool
//
//  Created by 李琪 on 16/8/8.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import UIKit

extension UIViewController {
    class func loadViewController(_ name:String) -> UIViewController{
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let controllerName = namespace + "." + name // xibName 形如 XXViewController
        let classType: AnyObject.Type = NSClassFromString(controllerName)!
        let nsobjectype : UIViewController.Type = classType as! UIViewController.Type
        let vc: UIViewController = nsobjectype.init(nibName: name, bundle: nil)
        return vc
    }


}
