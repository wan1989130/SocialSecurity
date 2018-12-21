//
//  UIImage + Compressor.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/30.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

extension UIImage{
    //压缩图片
    func imageWithImageSimple(newSize:CGSize,maxLength:Int)->Data{
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        var compress:CGFloat = 1
        var data = newImage.jpegData(compressionQuality: compress)
        
        
        while data!.count > maxLength && compress > 0.01 {
            compress -= 0.02
            data = newImage.jpegData(compressionQuality: compress)
            print("data = \(data) compress = \(compress)")
        }
        return data!
        
    }
}
