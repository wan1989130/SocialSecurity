//
//  LHAlertView.swift
//  HandleSchool
//
//  Created by 李琪 on 15/11/25.
//  Copyright © 2015年 Huihai. All rights reserved.
//

import UIKit
import Foundation

typealias HSAlertViewEventHandler = ()->Void

class LHAlertView: UIView {
    
    class func showAlertWithTitle(_ title:String){
        DispatchQueue.main.async { () -> Void in
            UIAlertController.showAlertWithTitle(title)
        }
    }
    
    class func showAlertWithTitle(_ title:String, msg:String){
        DispatchQueue.main.async { () -> Void in
            UIAlertController.showAlertWithTitle(title, msg: msg)
        }
    }
    
    class func showAlertWithTitle(_ title:String, msg:String, buttonTitle:String){
        DispatchQueue.main.async { () -> Void in
            UIAlertController.showAlertWithTitle(title, msg: msg, buttonTitle: buttonTitle)
        }
    }
    
    class func showAlertWithTitle(_ title:String, completionBlock:@escaping HSAlertViewEventHandler){
        DispatchQueue.main.async { () -> Void in
            UIAlertController.showAlertWithTitle(title, completionBlock: completionBlock)
        }
    }
    
    class func showAlertWithTitle(_ title:String, msg:String, completionBlock:@escaping HSAlertViewEventHandler){
        DispatchQueue.main.async { () -> Void in
            UIAlertController.showAlertWithTitle(title, msg: msg, completionBlock: completionBlock)
        }
    }
    
    class func showAlertWithTitle(_ title:String, msg:String, confirmButtonTitle:String, completionBlock:@escaping HSAlertViewEventHandler){
        DispatchQueue.main.async { () -> Void in
            UIAlertController.showAlertWithTitle(title, msg: msg, confirmButtonTitle: confirmButtonTitle, completionBlock: completionBlock)
        }
    }
    
    class func showAlertWithTitle(_ title:String, msg:String, confirmButtonTitle:String,cancelButtonTitle:String, completionBlock:@escaping HSAlertViewEventHandler, cancelBlock:@escaping HSAlertViewEventHandler){
        DispatchQueue.main.async { () -> Void in
            UIAlertController.showAlertWithTitle(title, msg: msg, confirmButtonTitle: confirmButtonTitle, cancelButtonTitle: cancelButtonTitle, completionBlock: completionBlock, cancelBlock: cancelBlock)
        }
    }
    
    class func showAlertOnViewController(_ viewController:UIViewController!, title:String, msg:String, confirmButtonTitle:String,cancelButtonTitle:String, completionBlock:@escaping HSAlertViewEventHandler, cancelBlock:@escaping HSAlertViewEventHandler){
        DispatchQueue.main.async { () -> Void in
            UIAlertController.showAlertOnViewController(viewController, title: title, msg: msg, confirmButtonTitle: confirmButtonTitle, cancelButtonTitle: cancelButtonTitle, completionBlock: completionBlock, cancelBlock: cancelBlock)
        }
    }
     
    class func showTipAlertWithTitle(_ title:String){
        if title == ""{
            return
        }
        LHAlertView.showTipAlertWithTitle(title, onView: UIApplication.shared.keyWindow!)
//        DispatchQueue.main.async { () -> Void in
//            let alertView = OLGhostAlertView.init(title: title, message: nil, timeout: 2.0, dismissible: false)
//            alertView?.position = OLGhostAlertViewPosition.bottom
//            alertView?.completionBlock = nil
//            alertView?.show()
//        }
    }
    
    class func showTipAlertWithTitle(_ title:String, onView view:UIView){
        DispatchQueue.main.async { () -> Void in
            let alertView = OLGhostAlertView.init(title: title, message: nil, timeout: 2.0, dismissible: false)
            alertView?.position = OLGhostAlertViewPosition.bottom
            alertView?.completionBlock = nil
            alertView?.show(in: view)
        }
    }
    
    class func showTipAlertWithTitle(_ title:String, postion ptn:OLGhostAlertViewPosition){
        if title == ""{
            return
        }
        DispatchQueue.main.async { () -> Void in
            let alertView = OLGhostAlertView.init(title: title, message: nil, timeout: 2.0, dismissible: false)
            alertView?.position = ptn
            alertView?.completionBlock = nil
            alertView?.show()
        }
    }
}
