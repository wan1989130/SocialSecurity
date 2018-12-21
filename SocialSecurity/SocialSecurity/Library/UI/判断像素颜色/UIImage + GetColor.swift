//
//  UIImage + GetColor.swift
//  更改图片背景色
//
//  Created by 王岩 on 2018/11/22.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

extension UIImage{
//    func getPixelColor(pos:CGPoint)->(alpha: CGFloat, red: CGFloat, green: CGFloat,blue:CGFloat){
////        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.cgImage ?? UIImage().cgImage))
//        // 用来存放目标像素值
//        var pixel = [UInt8](repeatElement(0, count: 4))
//        // 颜色空间为 RGB，这决定了输出颜色的编码是 RGB 还是其他（比如 YUV）
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        // 设置位图颜色分布为 RGBA
//        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
//        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo)
//        // 设置 context 原点偏移为目标位置所有坐标
//        context!.translateBy(x: -pos.x, y: -pos.y)
//
//        let r = CGFloat(pixel[1]) / CGFloat(255.0)
//        let g = CGFloat(pixel[2]) / CGFloat(255.0)
//        let b = CGFloat(pixel[3]) / CGFloat(255.0)
//        let a = CGFloat(pixel[0]) / CGFloat(255.0)
//
//
//
////        let inProvider =  self.cgImage?.dataProvider
////        let pixelData =  inProvider?.data
////
////        let data:UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
////        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
//
////        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
////        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
////        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
////        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
//
//        return (a,r,g,b)
//    }
//
//
//
//
//
    
    

}
extension UIView{
    /// 获取特定位置的颜色
    ///
    /// - parameter at: 位置
    ///
    /// - returns: 颜色
    public func pickColor(at position: CGPoint) -> (alpha: CGFloat, red: CGFloat, green: CGFloat,blue:CGFloat)? {
        
        // 用来存放目标像素值
        var pixel = [UInt8](repeatElement(0, count: 4))
        // 颜色空间为 RGB，这决定了输出颜色的编码是 RGB 还是其他（比如 YUV）
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // 设置位图颜色分布为 RGBA
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        guard let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo) else {
            return nil
        }
        // 设置 context 原点偏移为目标位置所有坐标
        context.translateBy(x: -position.x, y: -position.y)
        // 将图像渲染到 context 中
        layer.render(in: context)
        return (CGFloat(pixel[3]),CGFloat(pixel[0]),CGFloat(pixel[1]),CGFloat(pixel[2]))
//        return UIColor(red: CGFloat(pixel[0]) / 255.0,
//                       green: CGFloat(pixel[1]) / 255.0,
//                       blue: CGFloat(pixel[2]) / 255.0,
//                       alpha: CGFloat(pixel[3]) / 255.0)
    }
}
