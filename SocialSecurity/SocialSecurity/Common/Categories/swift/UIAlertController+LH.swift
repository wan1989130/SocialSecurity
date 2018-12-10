//
//  UIAlertController+LH.swift
//  HandleSchool
//
//  Created by 李琪 on 15/11/25.
//  Copyright © 2015年 Huihai. All rights reserved.
//

import UIKit
@available(iOS 8.0, *)
typealias UIAlertActionCompletionBlock = (UIAlertAction) -> Void
let UIAlertActionDefaultConfirmButtonTitle = "确认"

@available(iOS 8.0, *)
extension UIAlertController{
    class func showAlertWithTitle(_ title:String){
        UIAlertController.showAlertWithTitle(title, msg: nil, buttonTitle: nil)
    }
    
    class func showAlertWithTitle(_ title:String, msg:String){
        UIAlertController.showAlertWithTitle(title, msg: msg, buttonTitle: nil)
        
    }
    
    class func showAlertWithTitle(_ title:String, msg:String?, buttonTitle btnTitle:String?){
        var buttonTitle = btnTitle
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        if NSString.isNilOrEmpty(buttonTitle){
        buttonTitle = UIAlertActionDefaultConfirmButtonTitle
        }
        let confirmAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(confirmAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    class func showAlertWithTitle(_ title:String, completionBlock:@escaping HSAlertViewEventHandler){
        UIAlertController.showAlertWithTitle(title, msg: nil, confirmButtonTitle: UIAlertActionDefaultConfirmButtonTitle, cancelButtonTitle: nil, completionBlock: completionBlock, cancelBlock: nil)
        
    }
    
    class func showAlertWithTitle(_ title:String, msg:String, completionBlock:@escaping HSAlertViewEventHandler){
        UIAlertController.showAlertWithTitle(title, msg: msg, confirmButtonTitle: UIAlertActionDefaultConfirmButtonTitle, cancelButtonTitle: nil, completionBlock: completionBlock, cancelBlock: nil)
        
    }
    
    class func showAlertWithTitle(_ title:String, msg:String, confirmButtonTitle:String, completionBlock:@escaping HSAlertViewEventHandler){
        UIAlertController.showAlertWithTitle(title, msg: msg, confirmButtonTitle: confirmButtonTitle, cancelButtonTitle: nil, completionBlock: completionBlock, cancelBlock: nil)
        
    }
    
    class func showAlertWithTitle(_ title:String, msg:String?, confirmButtonTitle:String?,cancelButtonTitle:String?, completionBlock:HSAlertViewEventHandler?, cancelBlock:HSAlertViewEventHandler?){
//        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
//        if (cancelButtonTitle != nil){
//            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertActionStyle.default) { (action) -> Void in
//                if (cancelBlock != nil){
//                    cancelBlock!()
//                }
//            }
//            alertController.addAction(cancelAction)
//        }
//        
//        if (confirmButtonTitle != nil){
//            let confirmAction = UIAlertAction(title: confirmButtonTitle, style: UIAlertActionStyle.default) { (action) -> Void in
//                if (completionBlock != nil){
//                    completionBlock!()
//                }
//                
//            }
//            alertController.addAction(confirmAction)
//        }
//        else{
//            let confirmAction = UIAlertAction(title: UIAlertActionDefaultConfirmButtonTitle, style: UIAlertActionStyle.default, handler: nil)
//            alertController.addAction(confirmAction)
//        }
//        
//        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        UIAlertController.showAlertOnViewController(UIApplication.shared.keyWindow?.rootViewController!, title: title, msg: msg, confirmButtonTitle: confirmButtonTitle, cancelButtonTitle: cancelButtonTitle, completionBlock: completionBlock, cancelBlock: cancelBlock)
    }
    
    class func showAlertOnViewController(_ viewController:UIViewController!, title:String, msg:String?, confirmButtonTitle:String?,cancelButtonTitle:String?, completionBlock:HSAlertViewEventHandler?, cancelBlock:HSAlertViewEventHandler?){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        if (cancelButtonTitle != nil){
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertAction.Style.default) { (action) -> Void in
                if (cancelBlock != nil){
                    cancelBlock!()
                }
            }
            alertController.addAction(cancelAction)
        }
        
        if (confirmButtonTitle != nil){
            let confirmAction = UIAlertAction(title: confirmButtonTitle, style: UIAlertAction.Style.default) { (action) -> Void in
                if (completionBlock != nil){
                    completionBlock!()
                }
                
            }
            alertController.addAction(confirmAction)
        }
        else{
            let confirmAction = UIAlertAction(title: UIAlertActionDefaultConfirmButtonTitle, style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(confirmAction)
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
