//
//  HSRightBarButtonItemMenu.swift
//  HandleSchool
//
//  Created by 李琪 on 15/12/7.
//  Copyright © 2015年 Huihai. All rights reserved.
//

import UIKit

@objc protocol HSRightBarButtonItemMenuDelegate : NSObjectProtocol{
    @objc optional func HSRightBarButtonItemMenuDidDisappear(_ sender:AnyObject?) -> Void
}

enum HSRightBarButtonItemMenuState{
    case normal
    case hightlighted
}
class HSRightBarButtonItemMenu: UIView {
    var cornerRadius:CGFloat = 8        //圆角值
    var arrowSize:CGFloat = 10          //箭头高度
    var edgeInset:CGFloat = 0           //边框宽度
    var separatorOffset:CGFloat = 1     //分隔线宽度
    var animationEnabled:Bool = true    //弹出和收起时是否动画显示
    
    fileprivate var overlayView:HSRightBarButtonItemMenuOverlayView?
    fileprivate var popupImage:UIImage!
    fileprivate var highlightedPopupImage:UIImage!
    
    
    //分隔线色
    var sepratorLineSingleColorNormal:UIColor = UIColor.black
    var sepratorLineSingleColorHighlighted:UIColor = UIColor.green
    var sepratorLineGradientEnabled:Bool = false //分隔线是否显示渐变色
    var sepratorLineCompnentsNomal:[CGFloat] = [1,1,0,1,  0,0,1,1,  1,1,0,1]
    var sepratorLineCompnentsHightlighted:[CGFloat] = [0,1,0,1,   0,0,1,1,   0,1,0,1]
    
    //背景色
    var backgroundSingleColorNormal:UIColor = UIColor.white//UIColor(hexString: "fffbef")
    var backgroundSingleColorHighlighted:UIColor = UIColor.white//UIColor(hexString: "fffbef")
    var backgroundGradientEnabled:Bool = false   //背景是否显示渐变色
    var backgroundCompnentsNomal:[CGFloat] = [0,0,0,1,  1,1,1,1,  0,0,0,1]
    var backgroundCompnentsHighlighted:[CGFloat] = [0,1,0,1,   0,0,1,1,   0,1,0,1]
    
    //边框颜色
    var edgeColor:UIColor = UIColor.black
    
    var delegate:HSRightBarButtonItemMenuDelegate?
    var sender:AnyObject?
    
    
    var _items:NSArray?
    var items:NSArray?{
        get{
            return _items
        }
        set{
            _items = newValue
            updateItems()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        loadBaseInfo()
    }
    
    init(items:NSArray?){
        super.init(frame: CGRect.zero)
        loadBaseInfo()
        self.items = items
    }
    
    init(items:NSArray?, delegate:HSRightBarButtonItemMenuDelegate){
        super.init(frame: CGRect.zero)
        loadBaseInfo()
        self.items = items
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(){
        let view = UIApplication.shared.keyWindow!
        
        overlayView = HSRightBarButtonItemMenuOverlayView(frame: view.bounds)
        overlayView!.popupMenu = self
        
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1.6)
        self.layer.shadowRadius = 1.5
        
        if animationEnabled{
            self.layer.opacity = 0
        }
        
        overlayView!.addSubview(self)
        view.addSubview(overlayView!)
        
        if animationEnabled{
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.layer.opacity = 1.0
            })
        }
    }
    
    
    func dismiss(){
        delegate?.HSRightBarButtonItemMenuDidDisappear?(sender)
        
        removeFromSuperview()
        if overlayView != nil{
            overlayView!.removeFromSuperview()
        }
    }
    
    fileprivate func loadBaseInfo(){
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
    }
    
    fileprivate func updateItems(){
        if items != nil{
            var actualSize = self.actualSize()
            actualSize.height = actualSize.height + arrowSize
            
            self.frame = CGRect(x: ScreenWidth - actualSize.width - 10, y: 54, width: actualSize.width, height: actualSize.height)
            
            popupImage = popupImageForState(.normal)
            highlightedPopupImage = popupImageForState(.hightlighted)
            
            self.removeAllSubviews()
            
            var itemOffset:CGFloat = arrowSize
            
            if items!.count > 0{
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: actualSize.width, height: arrowSize))
                imageView.image =  croppedImageFromImage(popupImage, rect: imageView.frame)
                self.addSubview(imageView)
            }
            
            
            for i in 0..<items!.count{
                let item:HSRightBarButtonItemMenuItem = items![i] as! HSRightBarButtonItemMenuItem
                let itemSize = item.actualSize()
                let itemFrame = CGRect(x: 0, y: itemOffset, width: actualSize.width, height: itemSize.height)
                
                let image = croppedImageFromImage(popupImage, rect: itemFrame)
                let highlightImage = croppedImageFromImage(highlightedPopupImage, rect: itemFrame)
                
                let button = UIButton(type: .custom)
                button.tag = i
                button.frame = itemFrame
                button.autoresizingMask = UIView.AutoresizingMask()
                button.isEnabled = item.enabled
                
                //                button.setTitle(item.title, forState: .Normal)
                
                button.setImage(image, for: .normal)
                button.setImage(highlightImage, for: .highlighted)
                button.setImage(image, for: .disabled)
                
                button.addTarget(self, action: #selector(HSRightBarButtonItemMenu.performAction(_:)), for: .touchUpInside)
                self.addSubview(button)
                
                
                let titleLabel = UILabel(frame: CGRect(x: 0, y: itemOffset, width: itemSize.width, height: itemSize.height))
                titleLabel.text = item.title
                titleLabel.font = item.actualFont()
                titleLabel.textAlignment = .center
                titleLabel.textColor = UIColor(hexString: "5b5b5b")
                titleLabel.autoresizingMask = UIView.AutoresizingMask()
                self.addSubview(titleLabel)
                
                if i != items!.count - 1{
                    let lineImageView = UIImageView(frame:  CGRect(x: edgeInset, y: itemOffset + itemSize.height - 4, width: itemSize.width - edgeInset * 2, height: 4))
                    lineImageView.image = croppedImageFromImage(UIImage.createImageWithColor(UIColor.lightGray), rect: CGRect(x: 0, y: 0, width: itemSize.width - edgeInset * 2, height: 4))
                    self.addSubview(lineImageView)
                }
                
                itemOffset = itemOffset + itemSize.height
            }
            
        }
    }
    
    @objc func performAction(_ sender:UIButton){
        let item:HSRightBarButtonItemMenuItem = items![sender.tag] as! HSRightBarButtonItemMenuItem
        item.performAction()
        self.dismiss()
    }
    
    fileprivate func actualSize() -> CGSize{
        if items == nil || items!.count <= 0{
            return CGSize(width: 0, height: 0)
        }
        let w:CGFloat = 100
        var h:CGFloat = 0
        
        for i in 0..<items!.count{
            let item:HSRightBarButtonItemMenuItem = items![i] as! HSRightBarButtonItemMenuItem
            let actualItemSize = item.actualSize()
            //            if actualItemSize.height > h{
            h = h + actualItemSize.height
            //            }
        }
        
        if h > 0{
            h += arrowSize
        }
        return CGSize(width: w + 40, height: h)
    }
    
    //绘制背景图
    fileprivate func popupImageForState(_ state:HSRightBarButtonItemMenuState) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        let frameSize:CGSize = CGSize(width: self.bounds.size.width, height: self.bounds.size.height - arrowSize)
        let point:CGPoint = CGPoint(x: round(self.bounds.size.width / 2 - 1), y: self.bounds.size.height - 1 + arrowSize)
        
        
        
        // 绘制边框:从(cornerRadius)开始,顺时针绘制圆角矩形,并填充黑色
        let edgePath = CGMutablePath()
        
        //将画笔移到(0,cornerRadius)
        edgePath.move(to: CGPoint(x: 0, y: cornerRadius + arrowSize))
        //画笔沿(0,cornerRadius)->(0,0)->(cornerRadius,0)以弧度cornerRadius绘制一条弧线,起点为画笔当前位置
        edgePath.addArc(tangent1End: CGPoint(x: 0, y: arrowSize), tangent2End: CGPoint(x: cornerRadius, y: arrowSize), radius: cornerRadius)
        //画笔沿(cornerRadius,0)->(x-cornerRadius,0)画一条直线
        edgePath.addLine(to: CGPoint(x: frameSize.width - 20 - arrowSize, y: arrowSize))
        edgePath.addLine(to: CGPoint(x: frameSize.width - 20 - arrowSize / 2, y:  arrowSize / 2))
        edgePath.addLine(to: CGPoint(x: frameSize.width - 20, y: arrowSize))
        edgePath.addLine(to: CGPoint(x: frameSize.width - cornerRadius, y: arrowSize))
        
        
        //画笔沿(cornerRadius,0)->(x,0)->(cornerRadius,cornerRadius)以弧度cornerRadius绘制一条弧线
        edgePath.addArc(tangent1End: CGPoint(x: frameSize.width, y: arrowSize), tangent2End: CGPoint(x: frameSize.width, y: cornerRadius + arrowSize), radius: cornerRadius)
        //绘制右侧竖线
        edgePath.addLine(to: CGPoint(x: frameSize.width, y: frameSize.height - cornerRadius))
        //绘制右下角圆角
        edgePath.addArc(tangent1End: CGPoint(x: frameSize.width, y: frameSize.height), tangent2End: CGPoint(x: frameSize.width - cornerRadius, y: frameSize.height), radius: cornerRadius)
        
        //绘制左下竖线
        edgePath.addLine(to: CGPoint(x: cornerRadius, y: frameSize.height))
        //绘制左下圆角
        edgePath.addArc(tangent1End: CGPoint(x: 0, y: frameSize.height), tangent2End: CGPoint(x: 0, y: frameSize.height - cornerRadius), radius: cornerRadius)
        
        edgePath.closeSubpath()
        //TODO:设置边框颜色,未完成
        context.addPath(edgePath)
        let edgeColorArray:NSArray = edgeColor.convertToRGBArray() as NSArray
        context.setFillColor(red: edgeColorArray[0] as! CGFloat, green: edgeColorArray[1] as! CGFloat, blue: edgeColorArray[2] as! CGFloat, alpha: edgeColorArray[3] as! CGFloat)
        
        context.fillPath()
        
        ///绘制背景
        let basePath = CGMutablePath()
        
        //将画笔移到(0,cornerRadius)
        basePath.move(to: CGPoint(x: edgeInset, y: cornerRadius + arrowSize))
        //画笔沿(0,cornerRadius)->(0,0)->(cornerRadius,0)以弧度cornerRadius绘制一条弧线,起点为画笔当前位置
        basePath.addArc(tangent1End: CGPoint(x: edgeInset, y: edgeInset + arrowSize), tangent2End: CGPoint(x: cornerRadius, y: edgeInset + arrowSize), radius: cornerRadius - edgeInset)
        //画笔沿(cornerRadius,0)->(x-cornerRadius,0)画一条直线
        basePath.addLine(to: CGPoint(x: frameSize.width - 20 - arrowSize, y: arrowSize + edgeInset))
        basePath.addLine(to: CGPoint(x: frameSize.width - 20 - arrowSize / 2, y: arrowSize / 2 + edgeInset))
        basePath.addLine(to: CGPoint(x: frameSize.width - 20, y: arrowSize + edgeInset))
        basePath.addLine(to: CGPoint(x: frameSize.width - cornerRadius, y: arrowSize + edgeInset))
        
        //画笔沿(cornerRadius,0)->(x,0)->(cornerRadius,cornerRadius)以弧度cornerRadius绘制一条弧线
        basePath.addArc(tangent1End: CGPoint(x: frameSize.width - edgeInset, y:  edgeInset + arrowSize), tangent2End: CGPoint(x: frameSize.width - edgeInset, y: cornerRadius + arrowSize), radius: cornerRadius - edgeInset)
        //绘制右侧竖线
        basePath.addLine(to: CGPoint(x: frameSize.width - edgeInset, y: frameSize.height - cornerRadius))
        //绘制右下角圆角
        basePath.addArc(tangent1End: CGPoint(x: frameSize.width - edgeInset, y: frameSize.height - edgeInset), tangent2End: CGPoint(x: frameSize.width - cornerRadius, y: frameSize.height - edgeInset), radius: cornerRadius - edgeInset)
        
        //绘制左下角圆角
        basePath.addLine(to: CGPoint(x: cornerRadius + edgeInset, y: frameSize.height - edgeInset))
        //绘制左下圆角
        basePath.addArc(tangent1End: CGPoint(x: edgeInset, y: frameSize.height - edgeInset), tangent2End: CGPoint(x: edgeInset, y: frameSize.height - cornerRadius), radius: cornerRadius - edgeInset)
        basePath.closeSubpath()
        
        context.saveGState()
        context.addPath(basePath)
        //TODO:设置normal状态下背景色,未完成
        if backgroundGradientEnabled == false{
            //纯色
            if state == .normal{
                let bgColorArray:NSArray = backgroundSingleColorNormal.convertToRGBArray() as NSArray
                context.setFillColor(red: bgColorArray[0] as! CGFloat, green: bgColorArray[1] as! CGFloat, blue: bgColorArray[2] as! CGFloat, alpha: bgColorArray[3] as! CGFloat)
            }
            else{
                let bgColorArray:NSArray = backgroundSingleColorHighlighted.convertToRGBArray() as NSArray
                context.setFillColor(red: bgColorArray[0] as! CGFloat, green: bgColorArray[1] as! CGFloat, blue: bgColorArray[2] as! CGFloat, alpha: bgColorArray[3] as! CGFloat)
            }
            
            context.fillPath()
        }
        else{
            //渐变色
            
            context.clip()
            let backgroundColorSpaceRef = CGColorSpaceCreateDeviceRGB()
            var backgroundGradientRef:CGGradient!
            if state == .normal{
                let backgroundCount = Int(backgroundCompnentsNomal.count / 4)
                backgroundGradientRef = CGGradient(colorSpace: backgroundColorSpaceRef, colorComponents: backgroundCompnentsNomal, locations: nil, count: backgroundCount)
            }
            else{
                let backgroundCount = Int(backgroundCompnentsHighlighted.count / 4)
                backgroundGradientRef = CGGradient(colorSpace: backgroundColorSpaceRef, colorComponents: backgroundCompnentsHighlighted, locations: nil, count: backgroundCount)
            }
            
            //设置渐变色的起点和终点
            let startPoint = CGPoint(x: 0,  y: edgeInset)
            let endPoint = CGPoint(x: 0, y: point.y - edgeInset)
            
            context.drawLinearGradient(backgroundGradientRef, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)
        }
        context.restoreGState()
        
        ///绘制分隔线
        if items != nil && items!.count > 1{
            for i in 0..<items!.count{
                let item:HSRightBarButtonItemMenuItem = items![i] as! HSRightBarButtonItemMenuItem
                let actualSize = item.actualSize()
                
                if i == 0{
                    separatorOffset = separatorOffset + actualSize.height
                    drawBottomSeparatorInContext(context, startPoint: CGPoint(x: edgeInset,y: separatorOffset + arrowSize), endPoint: CGPoint(x: separatorOffset - 1, y: frameSize.height - edgeInset * 2), state: state)
                }
                else if i == items!.count - 1{
                    drawTopSeparatorInContext(context, startPoint: CGPoint(x: separatorOffset, y: edgeInset * 2), endPoint: CGPoint(x: separatorOffset, y: frameSize.height - edgeInset * 2), state: state)
                }
                else{
                    drawTopSeparatorInContext(context, startPoint: CGPoint(x: separatorOffset, y: edgeInset * 2), endPoint: CGPoint(x: separatorOffset, y: frameSize.height - edgeInset * 2), state: state)
                    separatorOffset = separatorOffset + actualSize.width
                    drawBottomSeparatorInContext(context, startPoint: CGPoint(x: separatorOffset - 1, y: edgeInset * 2), endPoint: CGPoint(x: separatorOffset - 1, y: frameSize.height - edgeInset * 2), state: state)
                }
            }
        }
        
        let popupImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return popupImage!
    }
    
    //剪切图片
    fileprivate func croppedImageFromImage(_ image:UIImage, rect:CGRect) -> UIImage{
        let scale = UIScreen.main.scale
        let scaledRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        let imageRef:CGImage = image.cgImage!.cropping(to: scaledRect)!
        let croppedImage = UIImage(cgImage: imageRef, scale: scale, orientation: .up)
        return croppedImage
    }
    
    //绘制右侧分隔线
    fileprivate func drawBottomSeparatorInContext(_ context:CGContext, startPoint:CGPoint, endPoint:CGPoint, state:HSRightBarButtonItemMenuState) -> Void{
        //        CGContextSaveGState(context)
        //        CGContextAddRect(context, CGRectMake(startPoint.x, startPoint.y, 1, endPoint.y - startPoint.y))
        //        CGContextClip(context)
        //
        //
        //        //TODO:设置纯色
        //        if sepratorLineGradientEnabled == false{
        //            if state == .Normal{
        //                let colorArray:NSArray = sepratorLineSingleColorNormal.convertToRGBArray()
        //                CGContextSetRGBFillColor(context, colorArray[0] as! CGFloat, colorArray[1] as! CGFloat, colorArray[2] as! CGFloat, colorArray[3] as! CGFloat)
        //            }
        //            else{
        //                let colorArray:NSArray = sepratorLineSingleColorHighlighted.convertToRGBArray()
        //                CGContextSetRGBFillColor(context, colorArray[0] as! CGFloat, colorArray[1] as! CGFloat, colorArray[2] as! CGFloat, colorArray[3] as! CGFloat)
        //            }
        //        }
        //        else{
        //
        //            //TODO:设置渐变色
        //            let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        //            var components:[CGFloat]!
        //            switch state{
        //            case .Normal:
        //                components = sepratorLineCompnentsNomal
        //                break
        //            case .Hightlighted:
        //                components = sepratorLineCompnentsHightlighted
        //                break
        //            }
        //
        //            let count = Int(components.count / 4)
        //            let gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, components, nil, count)
        //
        //            CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, CGGradientDrawingOptions.init(rawValue: 0))
        //        }
        //
        //        CGContextRestoreGState(context);
    }
    
    //绘制左侧分隔线
    fileprivate func drawTopSeparatorInContext(_ context:CGContext, startPoint:CGPoint, endPoint:CGPoint, state:HSRightBarButtonItemMenuState) -> Void{
        //        CGContextSaveGState(context)
        //        CGContextAddRect(context,CGRectMake(startPoint.x, startPoint.y, 1, endPoint.y - startPoint.y))
        //        CGContextClip(context)
        //
        //        //TODO:设置纯色
        //        if sepratorLineGradientEnabled == false{
        //            if state == .Normal{
        //                let colorArray:NSArray = sepratorLineSingleColorNormal.convertToRGBArray()
        //                CGContextSetRGBFillColor(context, colorArray[0] as! CGFloat, colorArray[1] as! CGFloat, colorArray[2] as! CGFloat, colorArray[3] as! CGFloat)
        //            }
        //            else{
        //                let colorArray:NSArray = sepratorLineSingleColorHighlighted.convertToRGBArray()
        //                CGContextSetRGBFillColor(context, colorArray[0] as! CGFloat, colorArray[1] as! CGFloat, colorArray[2] as! CGFloat, colorArray[3] as! CGFloat)
        //            }
        //        }
        //        else{
        //            //TODO:设置渐变色
        //            let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        //            var components:[CGFloat] = Array()
        //            switch state{
        //            case .Normal:
        //                components = sepratorLineCompnentsNomal
        //                break
        //            case .Hightlighted:
        //                components = sepratorLineCompnentsHightlighted
        //                break
        //            }
        //
        //            let count = Int(components.count / 4)
        //            let gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, components, nil, count)
        //
        //            CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, CGGradientDrawingOptions.init(rawValue: 0))
        //        }
        //
        //        CGContextRestoreGState(context);
    }
    
}














