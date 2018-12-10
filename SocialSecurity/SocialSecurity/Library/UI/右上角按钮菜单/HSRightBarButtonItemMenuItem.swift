//
//  HSRightBarButtonItemMenuItem.swift
//  HandleSchool
//
//  Created by 李琪 on 15/12/7.
//  Copyright © 2015年 Huihai. All rights reserved.
//

import UIKit

typealias HSRightBarButtonItemMenuHandler = () -> Void

class HSRightBarButtonItemMenuItem: NSObject {
    var title:String?
    var target:AnyObject?
    var action:Selector?
    var completionBlock:HSRightBarButtonItemMenuHandler?
    
    var enabled:Bool = true
    var width:CGFloat = 100
    var font:UIFont?
    var defaultHeight:CGFloat = 40
    
    var fontForTitleWithImage:UIFont = UIFont.boldSystemFont(ofSize: 12)
    var fontForTitle:UIFont = UIFont.boldSystemFont(ofSize: 14)
    
    init(title:String, completionBlock:@escaping HSRightBarButtonItemMenuHandler) {
        super.init()
        setup(title,  target: nil, action: nil, completionBlock: completionBlock)
    }

    init(title:String, target:AnyObject, action:Selector) {
        super.init()
        setup(title, target: target, action: action, completionBlock: nil)
    }

    fileprivate func setup(_ title:String?, target:AnyObject?, action:Selector?, completionBlock:HSRightBarButtonItemMenuHandler?) {
        
        self.title = title
        self.target = target
        self.action = action
        self.completionBlock = completionBlock
        
        self.font = nil
    }
    
    func actualSize() -> CGSize{
        let w:CGFloat = width
        var h:CGFloat = 0
        
        
        if self.width > 0{
//            w = self.width
            h = defaultHeight
        }
        else{
            h = defaultHeight
            
//            let f = (self.font != nil) ? self.font! : self.fontForTitle
//            let titleSize = self.title!.getSizeWithFont(f)
//            w = titleSize.width
        }
        
//        w = w + (self.actualFont().pointSize - 4) * 2
        
        
        return CGSize(width: w, height: h)
    }
    
    func actualFont() -> UIFont{
        var f = self.font
        if f == nil{
            f = self.fontForTitle
        }
        return f!
    }
    
    func performAction() -> Void{
        if target != nil || action != nil{
            if target!.responds(to: action!){
                target?.performSelector(onMainThread: action!, with: self, waitUntilDone: true)
            }
        }
        if completionBlock != nil{
            completionBlock!()
        }
    }
    
    func handleCompletionBlock() -> Void{
        if completionBlock != nil{
            completionBlock!()
        }
    }
}
