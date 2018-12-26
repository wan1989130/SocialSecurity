//
//  UIView + Load.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/26.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

extension UIView{
    //通过xib文件名加载view
    public class func loadView<T:UIView>( _ type: T.Type, _ bundle:Bundle? = nil) -> T{
        let fullClassName = T.description()
        let arr = fullClassName.components(separatedBy: ".")
        let nibName = arr.last ?? ""
        
        let targetBundle = bundle ?? Bundle.main
//        if bundle == nil{
//            if (Bundle.main.path(forResource: nibName, ofType: "nib") != nil){
//                targetBundle = Bundle.main
//            }
//            else if (BaseLibraryBundle.path(forResource: nibName, ofType: "nib") != nil){
//                targetBundle = BaseLibraryBundle
//            }
//            else{
//                return T()
//            }
//        }
        
        let nibs = targetBundle.loadNibNamed(nibName, owner: self, options: nil)
        let v = nibs?.last as? T ?? T()
        return v
    }
}
