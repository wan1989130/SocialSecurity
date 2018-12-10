//
//  ColorChange.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/13.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ColorChange{
    class func change(frame:CGRect,view:UIView){
        //初始化CAGradientlayer对象，使它的大小为UIView的大小
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
        view.layer.addSublayer(gradientLayer)
        //设置渐变区域的起始和终止位置（范围为0-1）
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        //设置颜色数组
        
        gradientLayer.colors = [UIColor(hexString: "d7dde4").cgColor,UIColor(hexString: "F6F6F6").cgColor,UIColor(hexString: "F6F6F6").cgColor,UIColor(hexString: "d7dde4").cgColor]
//                 gradientLayer.colors = [UIColor.red.cgColor,UIColor.blue.cgColor,UIColor.blue.cgColor,UIColor.red.cgColor]
        //设置颜色分割点（范围：0-1）
        gradientLayer.locations = [0.01,0.2,0.8, 0.99]
        
    }
}
