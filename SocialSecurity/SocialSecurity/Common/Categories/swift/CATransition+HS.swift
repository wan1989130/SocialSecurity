//
//  CATransition+Animation.swift
//  testCode
//
//  Created by 李琪 on 16/7/19.
//  Copyright © 2016年 李琪. All rights reserved.
//


/**
 UIApplication.sharedApplication().keyWindow?.rootViewController = ViewController2(nibName: "ViewController2", bundle: nil)
 UIApplication.sharedApplication().keyWindow?.layer.addAnimation(CATransition.animationWithType(KYNaviAnimationType(rawValue: indexPath.row + 1)!, direction: .Top), forKey: nil)
 */



import UIKit
enum KYNaviAnimationType:Int{
    case fade        = 1    //淡化
    case push        = 2    //推挤
    case reveal      = 3    //揭开
    case moveIn      = 4    //覆盖
    case cube        = 5    //立方体
    case suck        = 6    //吸收
    case spin        = 7    //旋转
    case ripple      = 8    //波纹
    case pageCurl    = 9    //翻页
    case pageUnCurl  = 10   //反翻页
    case cameraOpen  = 11   //镜头开
    case cameraClose = 12   //镜头关
}


enum KYNaviAnimationDirection{
    case left
    case right
    case top
    case bottom
}
extension CATransition {
    class func animationWithType(_ animationType:KYNaviAnimationType) -> CATransition{
        return CATransition.animationWithType(animationType, direction: .top)
    }
    
    class func animationWithType(_ animationType:KYNaviAnimationType, direction:KYNaviAnimationDirection) -> CATransition{
        
        let animation = CATransition()
        animation.duration = 0.5
        
        switch (animationType) {
        case .fade:
            animation.type = CATransitionType.fade; //淡化.
        case .push:
            animation.type = CATransitionType.push; //推挤.
        case .reveal:
            animation.type = CATransitionType.reveal; //揭开.
        case .moveIn:
            animation.type = CATransitionType.moveIn;//覆盖.
        case .cube:
            animation.type = CATransitionType(rawValue: "cube");   //立方体.
        case .suck:
            animation.type = CATransitionType(rawValue: "suckEffect"); //吸收.
        case .spin:
            animation.type = CATransitionType(rawValue: "oglFlip");    //旋转.
        case .ripple:
            animation.type = CATransitionType(rawValue: "rippleEffect");   //波纹.
        case .pageCurl:
            animation.type = CATransitionType(rawValue: "pageCurl");   //翻页.
        case .pageUnCurl:
            animation.type = CATransitionType(rawValue: "pageUnCurl"); //反翻页.
        case .cameraOpen:
            animation.type = CATransitionType(rawValue: "cameraIrisHollowOpen");   //镜头开.
        case .cameraClose:
            animation.type = CATransitionType(rawValue: "cameraIrisHollowClose");  //镜头关.
        }
        
        switch (direction) {
        case .left:
            animation.subtype = CATransitionSubtype.fromLeft
        case .right:
            animation.subtype = CATransitionSubtype.fromRight
        case .top:
            animation.subtype = CATransitionSubtype.fromTop
        case .bottom:
            animation.subtype = CATransitionSubtype.fromBottom
        }
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        
        
        return animation;
        
    }

}
