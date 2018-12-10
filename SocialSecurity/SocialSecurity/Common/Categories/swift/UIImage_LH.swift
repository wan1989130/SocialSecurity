//
//  UIImage_LH.swift
//  imageClipDemo
//
//  Created by 李琪 on 15/12/9.
//  Copyright © 2015年 Huihai. All rights reserved.
//

import UIKit
enum HSImageClipRoundDirection:Int{
    case all = 0
    case top = 1
    case bottom = 2
}

enum HSImageAutoStretchDirection:Int{
    case all = 0
    case horizontal = 1 //水平
    case vertical = 2   //竖直
}

extension UIImage{
    
    ///将图片缩放至固定尺寸
    func scalingToSize(_ targetSize:CGSize) -> UIImage{
        return UIImage.scaleImageToSize(self, targetSize: targetSize)
    }
    
    class func scaleImageToSize(_ image:UIImage,targetSize:CGSize) -> UIImage{
        let sourceImage = image
        UIGraphicsBeginImageContext(targetSize)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
        let thumbnailRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        sourceImage.draw(in: thumbnailRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func scalingToScaleSize(_ targetSize:CGSize) -> UIImage{
        return UIImage.scaleImageToScaleSize(self, targetSize: targetSize)
    }
    
    class func scaleImageToScaleSize(_ image:UIImage,targetSize:CGSize) -> UIImage{
        let sourceImage = image
        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
//        let thumbnailRect = CGRectMake(0, 0, targetSize.width * UIScreen.mainScreen().scale, targetSize.height * UIScreen.mainScreen().scale)
        let thumbnailRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        sourceImage.draw(in: thumbnailRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    ///在图片四个角不变的情况下拉伸图片
    func autoStretch() -> UIImage{
        return autoStretch(.all)
    }
    
    func autoStretch(_ direction:HSImageAutoStretchDirection) -> UIImage{
        if direction == .all{
            return self.stretchableImage(withLeftCapWidth: Int(self.size.width / 2), topCapHeight: Int(self.size.height / 2))
        }
        else if direction == .horizontal{
            return self.stretchableImage(withLeftCapWidth: Int(self.size.width / 2), topCapHeight: 0)
        }
        else{
            return self.stretchableImage(withLeftCapWidth: 0, topCapHeight: Int(self.size.height / 2))
        }
        
    }
    
    func scaleToTargetScale(_ targetScale:CGFloat) -> UIImage{
       return UIImage.scaleImageToScale(self, targetScale: targetScale)
    }
    
    class func scaleImageToScale(_ image:UIImage,targetScale:CGFloat) -> UIImage{
        UIGraphicsBeginImageContext(CGSize(width: image.size.width * targetScale, height: image.size.height * targetScale));
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width * targetScale, height: image.size.height * targetScale))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage!
        
    }
    
    
    class func dataWithImage(_ image:UIImage, scale:CGFloat) -> Data?{
        
        if (image.jpegData(compressionQuality: scale) == nil) {
            return image.pngData();
        } else {
            
            return image.jpegData(compressionQuality: scale);
            
        }
    }
    
    ///生成纯色图片
    class func createImageWithColor(_ color:UIColor) -> UIImage{
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        return UIImage.createImageWithColor(color, rect: rect)
    }
    
    ///生成纯色图片
    class func createImageWithColorHexString(_ hex:String) -> UIImage{
        let color = UIColor(hexString: hex)
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        return UIImage.createImageWithColor(color!, rect: rect)
    }
    
    class func createImageWithColor(_ color:UIColor, rect:CGRect) -> UIImage{
        let rect = rect
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor);
        context?.fill(rect);
        let theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return theImage!;
    }
    
    
    //放大圆角图片
    class func scaleCornerImageToNewSize(_ image:UIImage, newSize:CGSize,cornerRadius:CGFloat) -> UIImage{
        UIGraphicsBeginImageContext(newSize)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.green.cgColor);
        context?.fill(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height));
        
        //左上角
        let ltImage = image.clipImageInRect(CGRect(x: 0,y: 0,width: cornerRadius,height: cornerRadius))
        ltImage.draw(at: CGPoint(x: 0, y: 0))
        
        //上边
        let tImage = image.clipImageInRect(CGRect(x: cornerRadius, y: 0, width: image.size.width - cornerRadius * 2, height: cornerRadius))
        tImage.scalingToSize(CGSize(width: newSize.width - cornerRadius * 2, height: cornerRadius)).draw(at: CGPoint(x: cornerRadius, y: 0))
        
        //右上角
        let rtImage = image.clipImageInRect(CGRect(x: image.size.width - cornerRadius,y: 0,width: cornerRadius,height: cornerRadius))
        rtImage.draw(at: CGPoint(x: newSize.width - cornerRadius, y: 0))
        
        //右边
        let rImage = image.clipImageInRect(CGRect(x: image.size.width - cornerRadius, y: cornerRadius, width: cornerRadius, height: image.size.height - cornerRadius * 2))
        rImage.scalingToSize(CGSize(width: cornerRadius, height: newSize.height - cornerRadius * 2)).draw(at: CGPoint(x: newSize.width - cornerRadius, y: cornerRadius))
        
        //右下角
        let rbImage = image.clipImageInRect(CGRect(x: image.size.width - cornerRadius,y: image.size.height - cornerRadius,width: cornerRadius,height: cornerRadius))
        rbImage.draw(at: CGPoint(x: newSize.width - cornerRadius,y: newSize.height - cornerRadius))
        
        //下边
        let bImage = image.clipImageInRect(CGRect(x: cornerRadius, y: image.size.height - cornerRadius, width: image.size.width - cornerRadius * 2, height: cornerRadius))
        bImage.scalingToSize(CGSize(width: newSize.width - cornerRadius * 2, height: cornerRadius)).draw(at: CGPoint(x: cornerRadius, y: newSize.height - cornerRadius))
        
        //左下角
        let lbImage = image.clipImageInRect(CGRect(x: 0,y: image.size.height - cornerRadius,width: cornerRadius,height: cornerRadius))
        lbImage.draw(at: CGPoint(x: 0,y: newSize.height - cornerRadius))
        
        //左边
        let lImage = image.clipImageInRect(CGRect(x: 0, y: cornerRadius, width: cornerRadius, height: image.size.height - cornerRadius * 2))
        lImage.scalingToSize(CGSize( width: cornerRadius, height: newSize.height - cornerRadius * 2)).draw(at: CGPoint(x: 0, y: cornerRadius))
        
        //中间
        let mImage = image.clipImageInRect(CGRect(x: cornerRadius, y: cornerRadius, width: image.size.width - cornerRadius * 2, height: image.size.height - cornerRadius * 2))
        mImage.scalingToSize(CGSize(width: newSize.width - cornerRadius * 2, height: newSize.height - cornerRadius * 2)).draw(at: CGPoint(x: cornerRadius, y: cornerRadius))
        
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        return theImage!
    }
    
    ///剪切图片
    func clipImageInRect(_ rect:CGRect) -> UIImage{
        let imageRef = self.cgImage?.cropping(to: rect)
        return UIImage(cgImage: imageRef!)
    }
    
    ///在图片上画一个半透明黑色圆角矩形框
    func drawBlackShadowEdgeForCornerRadius(_ cornerRadius:CGFloat) -> UIImage{
        return UIImage.drawBlackShadowEdgeForImage(self, cornerRadius: cornerRadius, edgeWidth: 5 , margin: 0, alpha: 0.2)
    }
    
    /**
     * cornerRadius:圆角大小
     * edgeWidth:边框宽度
     * margin:圆角矩形框距边框距离
     */
    func drawBlackShadowEdgeForCornerRadius(_ cornerRadius:CGFloat,edgeWidth:CGFloat,margin:CGFloat, alpha:CGFloat) -> UIImage{
        return UIImage.drawBlackShadowEdgeForImage(self, cornerRadius: cornerRadius, edgeWidth: edgeWidth, margin: margin, alpha: alpha)
    }
    
    class func drawBlackShadowEdgeForImage(_ image:UIImage,cornerRadius:CGFloat,edgeWidth:CGFloat,margin:CGFloat, alpha:CGFloat) -> UIImage{
        return UIImage.drawEdgeForImage(image, cornerRadius: cornerRadius, edgeWidth: edgeWidth, margin: margin, color: UIColor.black, alpha: alpha)
    }
    
    class func drawEdgeForImage(_ image:UIImage,cornerRadius:CGFloat,edgeWidth:CGFloat,margin:CGFloat,color:UIColor, alpha:CGFloat) -> UIImage{
        let insideCornerRadius = cornerRadius - edgeWidth
        let insideMargin = margin + edgeWidth
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        image.draw(at: CGPoint.zero)
        
        let edgePath = CGMutablePath()
        //外圈--顺时针
        //lt
        edgePath.move(to: CGPoint(x: margin, y: margin + cornerRadius))
        edgePath.addArc(tangent1End: CGPoint(x: margin, y: margin), tangent2End: CGPoint(x: margin + cornerRadius, y: margin), radius: cornerRadius)
        //t
        edgePath.addLine(to: CGPoint(x: imageWidth - margin - cornerRadius, y: margin))
        //rt
        edgePath.addArc(tangent1End: CGPoint(x: imageWidth - margin, y: margin), tangent2End: CGPoint(x: imageWidth - margin, y: margin + cornerRadius), radius: cornerRadius)
        //r
        edgePath.addLine(to: CGPoint(x: imageWidth - margin, y: imageHeight - margin - cornerRadius))
        //rb
        edgePath.addArc(tangent1End: CGPoint(x: imageWidth - margin, y: imageHeight - margin), tangent2End: CGPoint(x: imageWidth - margin - cornerRadius, y: imageHeight - margin), radius: cornerRadius)
        //b
        edgePath.addLine(to: CGPoint(x: margin + cornerRadius, y: imageHeight - margin))
        //lb
        edgePath.addArc(tangent1End: CGPoint(x: margin, y: imageHeight - margin), tangent2End: CGPoint(x: margin, y: imageHeight - margin - cornerRadius), radius: cornerRadius)
        //l
        edgePath.addLine(to: CGPoint(x: margin, y: margin + cornerRadius))
        //内圈--逆时针
        edgePath.addLine(to: CGPoint(x: insideMargin, y: insideMargin + insideCornerRadius))
        //l
        edgePath.addLine(to: CGPoint(x: insideMargin, y: imageHeight - insideMargin - insideCornerRadius))
        //lb
        edgePath.addArc(tangent1End: CGPoint(x: insideMargin, y: imageHeight - insideMargin), tangent2End: CGPoint(x: insideMargin + insideCornerRadius, y: imageHeight - insideMargin), radius: insideCornerRadius)
        //b
        edgePath.addLine(to: CGPoint(x: imageWidth - insideMargin - insideCornerRadius, y: imageHeight - insideMargin))
        //rb
        edgePath.addArc(tangent1End: CGPoint(x: imageWidth - insideMargin, y: imageHeight - insideMargin), tangent2End: CGPoint(x: imageWidth - insideMargin, y: imageHeight - insideMargin - insideCornerRadius), radius: insideCornerRadius)
        //r
        edgePath.addLine(to: CGPoint(x: imageWidth - insideMargin, y: insideMargin + insideCornerRadius))
        //rt
        edgePath.addArc(tangent1End: CGPoint(x: imageWidth - insideMargin, y: insideMargin), tangent2End: CGPoint(x: imageWidth - insideMargin - insideCornerRadius, y: insideMargin), radius: insideCornerRadius)
        //t
        edgePath.addLine(to: CGPoint(x: insideMargin + insideCornerRadius, y: insideMargin))
        //lt
        edgePath.addArc(tangent1End: CGPoint(x: insideMargin, y: insideMargin), tangent2End: CGPoint(x: insideMargin, y: insideMargin + insideCornerRadius), radius: insideCornerRadius)
        edgePath.closeSubpath()
        
        context?.addPath(edgePath)
        context?.setFillColor(color.withAlphaComponent(alpha).cgColor)
        context?.fillPath()
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
    
    ///将图片剪切成圆角图片
    func convertToRoundRectForCornerRadius(_ cornerRadius:CGFloat) -> UIImage{
        return UIImage.convertToRoundRectForImage(self, cornerRadius: cornerRadius, direction: .all)
    }
    
    func convertToRoundRectForCornerRadius(_ cornerRadius:CGFloat, direction:HSImageClipRoundDirection) -> UIImage{
        return UIImage.convertToRoundRectForImage(self, cornerRadius: cornerRadius,direction: direction)
    }
    
    class func convertToRoundRectForImage(_ image:UIImage,cornerRadius:CGFloat,direction:HSImageClipRoundDirection) -> UIImage{
        var cr = cornerRadius
        if image.size.width < cornerRadius * 2 || image.size.height < cornerRadius * 2 {
            cr = image.size.width < image.size.height ? image.size.width / 2 : image.size.height / 2
        }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        image.draw(at: CGPoint.zero)
        
        if direction == .all || direction == .top{
            //抹掉左上角
            let ltPath = CGMutablePath()
            ltPath.move(to: CGPoint(x: 0, y: cr))
            ltPath.addArc(tangent1End: CGPoint(x: 0, y: 0), tangent2End: CGPoint(x: cr, y: 0), radius: cr)
            ltPath.addLine(to: CGPoint(x: 0, y: 0))
            ltPath.closeSubpath()
            context.addPath(ltPath)
            context.setBlendMode(.clear)
            context.fillPath()
            
            //抹掉右上角
            let rtPath = CGMutablePath()
            rtPath.move(to: CGPoint(x: image.size.width - cr, y: 0))
            rtPath.addArc(tangent1End: CGPoint(x: image.size.width, y: 0), tangent2End: CGPoint(x: image.size.width, y: cr), radius: cr)
            rtPath.addLine(to: CGPoint(x: image.size.width, y: 0))
            rtPath.closeSubpath()
            context.addPath(rtPath)
            context.setBlendMode(.clear)
            context.fillPath()
        }
        
        if direction == .all || direction == .bottom{
            //抹掉右下角
            let rbPath = CGMutablePath()
            rbPath.move(to: CGPoint(x: image.size.width, y: image.size.height - cr))
            rbPath.addArc(tangent1End: CGPoint(x: image.size.width, y: image.size.height), tangent2End: CGPoint(x: image.size.width - cr, y: image.size.height), radius: cr)
            rbPath.addLine(to: CGPoint(x: image.size.width, y: image.size.height))
            rbPath.closeSubpath()
            context.addPath(rbPath)
            context.setBlendMode(.clear)
            context.fillPath()
            
            //抹掉左下角
            let lbPath = CGMutablePath()
            lbPath.move(to: CGPoint(x: 0, y: image.size.height - cr))
            lbPath.addArc(tangent1End: CGPoint(x: 0, y: image.size.height), tangent2End: CGPoint(x: cr, y: image.size.height), radius: cr)
            lbPath.addLine(to: CGPoint(x: 0, y: image.size.height))
            lbPath.closeSubpath()
            context.addPath(lbPath)
            context.setBlendMode(.clear)
            context.fillPath()
        }
        
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
    
    /**
     * 加载主题中的图片
     * 主题本身是一个bundle,每个主题中的资源都放到一个bundle中
     * 主题下面是模块,每一个模块也是一个bundle
     * 模块中包含一个map文件,当前map为Plist,也可以使用json,但改为json时需要改变下面的代码
     * map的数据结构是一个字典key是图片名(应用中调用的图片名),value是一个图片信息字典
     * 图片信息字典里包含5个字段,分别是资源图片名(图片集合的大图),x,y,width,height
     */
    class func loadImage(_ theme:String,module:String,name:String) -> UIImage{
        var bundlePath:String!
        var plistPath:String!
        if theme == "base"{
            let path = Bundle.main.path(forResource: "base", ofType: "bundle")! as String
            bundlePath = path + "/" + module + ".bundle"
            plistPath  = path + "/" + module + ".bundle" + "/" + "map.plist"
        }
        else{
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            bundlePath = paths[0] + "/" + theme + ".bundle/" + module + ".bundle"
            plistPath  = paths[0] + "/" + theme + ".bundle/" + module + ".bundle" + "/" + "map.plist"
        }
        //创建文件控件器
        let fileManager = FileManager.default
        
        //当文件不存在
        if(!fileManager.fileExists(atPath: bundlePath)) {
            return UIImage()
        }

        
        let bundle:Bundle! = Bundle(path: bundlePath)
        let mapDic:NSDictionary = NSDictionary(contentsOfFile: plistPath)!
        let imageInfo = mapDic[name] as! NSDictionary
        
        let imagePath = bundle.path(forResource: imageInfo["name"] as? String, ofType: "png")
        let image = UIImage(contentsOfFile: imagePath!)
        
        let x = imageInfo["x"] as! CGFloat
        let y = imageInfo["y"] as! CGFloat
        let w = imageInfo["w"] as! CGFloat
        let h = imageInfo["h"] as! CGFloat
        
        if image != nil{
            return image!.clipImageInRect(CGRect(x: x, y: y, width: w, height: h))
        }
        else{
            return UIImage()
        }
        
        
    }
    
    class func loadImage(_ name:String) -> UIImage{
//        let path = NSBundle.mainBundle().pathForResource(name, ofType: "png")
//        if path == nil{
//            return UIImage()
//        }
//        return UIImage(contentsOfFile: path!)!
        let image = UIImage(named: name)
        if image == nil{
            return UIImage()
        }
        return image!
    }
}
