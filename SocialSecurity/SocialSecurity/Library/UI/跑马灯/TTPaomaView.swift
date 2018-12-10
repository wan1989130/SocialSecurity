//
//  TTPaomaView.swift
//  swift-test
//
//  Created by Leery on 2018/11/3.
//  Copyright © 2018 LZT. All rights reserved.
//

import UIKit

/**
 * 设置字体
 */
func defaultSystemFont(withSize size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}
/**
 * 获取文字的size
 */
func getSize(withString string:String, size:CGSize, font:UIFont) -> CGSize {
    let newSize:CGSize = (string as NSString).boundingRect(with: size, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
    return newSize
}

class TTPaomaView: UIView,CAAnimationDelegate {
    
    var labels:NSMutableArray! = NSMutableArray()
    var textString:String! = ""
    var mainView:UIView!
    private var duration:TimeInterval!
    var textFont:UIFont! = defaultSystemFont(withSize: 12)
    var textColor:UIColor! {
        didSet{
            for lab in labels {
                let label = lab as! UILabel
                label.textColor = textColor
            }
        }
    }
    private var canAnimate:Bool! = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
    }
    
    func setAttributeText(_ attr:NSAttributedString) {
        if labels.count > 0 {
            labels.removeAllObjects()
        }
        for view in self.subviews {
            view.removeFromSuperview()
        }
        if canAnimate {
            canAnimate = false
            stopAnimation()
        }
        let label = UILabel.init(frame: self.bounds)
        label.textAlignment = .left
        label.textColor = textColor
        label.font = textFont
        label.attributedText = attr
        self.addSubview(label)
    }
    
    func setText(text:String) {
        if labels.count > 0 {
            labels.removeAllObjects()
        }
        for view in self.subviews {
            view.removeFromSuperview()
        }
        if canAnimate {
            canAnimate = false
            stopAnimation()
        }
        mainView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        addSubview(mainView)
        textString = text
        let size = getSize(withString: text, size: CGSize.init(width: 100000, height: 20), font: textFont)
        if size.width+10 >= frame.size.width {
            for i in 0...1 {
                let label = UILabel.init(frame: CGRect.init(x: CGFloat(i)*(size.width+20), y: 0, width: size.width+10, height: frame.size.height))
                label.text = text
                label.textColor = textColor
                label.textAlignment = .left
                label.font = textFont
                mainView.addSubview(label)
                labels.add(label)
            }
            if !canAnimate {
                canAnimate = true
                startAnimation(textWidth: size.width+20)
            }

        }else{
            for i in 0...1 {
                let label = UILabel.init(frame: CGRect.init(x: CGFloat(i)*(self.frame.size.width + 20), y: 0, width: self.frame.size.width + 10, height: frame.size.height))
                label.text = text
                label.textColor = textColor
                label.textAlignment = .left
                label.font = textFont
                mainView.addSubview(label)
                labels.add(label)
            }
            if !canAnimate {
                canAnimate = true
                startAnimation(textWidth: self.frame.size.width + 20)
            }
        }
        
    }
    
    private func startAnimation(textWidth:CGFloat) {
        if textWidth >= frame.size.width {
            duration = Double(textString.count) / 4
            let lab1:UILabel = labels.firstObject as! UILabel
            let lab2:UILabel = labels.lastObject as! UILabel
            let frountAnimat = CABasicAnimation.init(keyPath: "position")
            frountAnimat.fromValue = NSValue.init(cgPoint: CGPoint.init(x: lab1.center.x, y: lab1.center.y))
            frountAnimat.toValue = NSValue.init(cgPoint: CGPoint.init(x: lab1.center.x - textWidth, y: lab1.center.y))
            frountAnimat.duration = duration
            frountAnimat.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            frountAnimat.repeatCount = MAXFLOAT
            frountAnimat.isRemovedOnCompletion = false
            
            let behindAnima = CABasicAnimation()
            behindAnima.keyPath = "position"
            behindAnima.fromValue = NSValue.init(cgPoint: CGPoint.init(x: lab2.center.x, y: lab2.center.y))
            behindAnima.toValue = NSValue.init(cgPoint: CGPoint.init(x: lab2.center.x - textWidth, y: lab2.center.y))
            behindAnima.duration = duration
            behindAnima.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            behindAnima.repeatCount = MAXFLOAT
            behindAnima.isRemovedOnCompletion = false
            
            lab1.layer.add(frountAnimat, forKey: "frountAnimate")
            lab2.layer.add(behindAnima, forKey: "behindAnimate")
        }
    }
    func setFont(font:UIFont) {
        if canAnimate {
            let labelOne = labels[0] as! UILabel
            let labelTwo = labels[1] as! UILabel
            labelOne.font = font
            labelTwo.font = font
        }
    }
    private func stopAnimation() {
        if labels.count > 0 {
            let lab1:UILabel = labels.firstObject as! UILabel
            let lab2:UILabel = labels.lastObject as! UILabel
            lab1.layer.removeAnimation(forKey: "frountAnimate")
            lab2.layer.removeAnimation(forKey: "behindAnimate")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
