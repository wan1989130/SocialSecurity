//
//  HSRightBarButtonItemMenuOverlayView.swift
//  HandleSchool
//
//  Created by 李琪 on 15/12/7.
//  Copyright © 2015年 Huihai. All rights reserved.
//

import UIKit

class HSRightBarButtonItemMenuOverlayView: UIView {
    var popupMenu:HSRightBarButtonItemMenu?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let touch:UITouch =  (touches as NSSet).anyObject()! as! UITouch
        let view = touch.view
        
        if (view!.isMember(of: HSRightBarButtonItemMenuOverlayView.self)){
            self.popupMenu!.dismiss()
        }
    }
    
}
