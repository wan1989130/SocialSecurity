//
//  UIView + Cornner.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/20.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat,size:CGRect) {
        let maskPath = UIBezierPath(roundedRect: size, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = size
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}


