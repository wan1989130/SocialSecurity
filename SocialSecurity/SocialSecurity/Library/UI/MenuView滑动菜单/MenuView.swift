//
//  MenuView.swift
//  水平滑动
//
//  Created by 王岩 on 2017/6/15.
//  Copyright © 2017年 王岩. All rights reserved.
//

import UIKit
protocol MenuViewProtocol {
    func menuView(forIndex index:Int) -> UIView
    //    func MenuViewDidScrollToIndex(index:Int) -> Void
    func menuViewIndex(index:Int) -> Void
}


class MenuView: UIView,UIScrollViewDelegate {
    var contentHeightTab = 0//带tabbar 传-49
    var nomarlColor = UIColor(hexString: "bbbbbb")
    var selectedColor = UIColor(hexString: "008FF5")
    var lineColor = UIColor(hexString: "008FF5")
    var height:CGFloat = 40  //菜单高度
    var currentButton:UIButton! //当前被选中的button
    var totalSize:CGFloat = 0 //总宽度
    var line:UILabel!  //红线
    var contentScrollView:UIScrollView!  //内容滑动区域
    var flag = false
    var width:CGFloat!  //button宽度
    var shengyuWidth:CGFloat!
    var currentX:CGFloat = 0  //当前x坐标
    var currentPage = 0 //内容区滚动视图的当前页
    
    func scrollToIndex(index:Int){
        currentPage = index
        let button = self.scrollView.viewWithTag(currentPage + 100) as! UIButton
        currentButton.isSelected = false
        currentButton = button
        currentButton.isSelected = true
        
        //        self.scrollView.scrollRectToVisible(CGRect(x: currentButton.frame.minX ,
        //                                                   y: CGFloat(contentHeightTab),
        //                                                   width:currentButton.frame.width,
        //                                                   height: height+1),
        //                                            animated: true)
        var point:CGPoint!
        if titleArray.count == 0{
            point = CGPoint(x: 0, y: 0)
        }
        else{
            point = CGPoint(x: contentScrollView.contentSize.width / CGFloat(titleArray.count), y: 0)
        }
        self.contentScrollView.setContentOffset(point, animated: true)
        
        UIView.animate(withDuration: 0.15, animations: {
            self.line.frame.size.width = self.currentButton.frame.width
            self.line.transform = CGAffineTransform(translationX: self.currentButton.frame.minX, y: 0)
            
        }, completion: { (isFinish) in
            //            self.delegate?.menuViewIndex(index: self.currentPage)
        })
        contentScrollView.scrollRectToVisible(CGRect(x: contentScrollView.frame.width * CGFloat((currentButton.tag - 100)), y: height + 1, width:contentScrollView.frame.width, height: contentScrollView.frame.height), animated: true)
        delegate?.menuViewIndex(index: currentButton.tag - 100)
        
    }
    
    var delegate:MenuViewProtocol?{
        didSet{
            for subView in contentScrollView.subviews{
                subView.removeFromSuperview()
            }
            for i in 0..<titleArray.count{
                let subView = delegate?.menuView(forIndex: i)
                let frame = contentScrollView.frame
                subView?.frame = CGRect(x: frame.size.width * CGFloat(i),
                                        y: 0,
                                        width: frame.size.width,
                                        height: frame.size.height - CGFloat(navHeight))
                contentScrollView.addSubview(subView!)
            }
        }
    }
    
    var titleArray:Array<String> = [String](){
        didSet{
            for subView in scrollView.subviews{
                subView.removeFromSuperview()
            }
            
            if titleArray.count>0{
                let str = titleArray.joined()
                let tempSize = (str as NSString).boundingRect(with: CGSize.init(width: 0, height: 0),
                                                              options: .usesLineFragmentOrigin ,
                                                              attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13)],
                                                              context: nil).size
                
                if tempSize.width + CGFloat((titleArray.count + 1) * 20) < ScreenWidth{
                    flag = true
                    shengyuWidth = ScreenWidth - tempSize.width
                }
                for i in 0..<titleArray.count{
                    let tempTag = 100
                    let titleSize = (titleArray[i] as NSString).boundingRect(with: CGSize.init(width: 0, height: 0), options: .usesLineFragmentOrigin , attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13)], context: nil).size
                    if flag{
                        width = titleSize.width + shengyuWidth/CGFloat(titleArray.count)
                    }else{
                        width = titleSize.width + 20
                    }
                    
                    let btn = UIButton.init(frame: CGRect(x: currentX, y: 0, width: width, height: height))
                    currentX = currentX + width
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    btn.setTitleColor(selectedColor, for: .selected)
                    btn.setTitleColor(nomarlColor, for: .normal)
                    btn.setTitle(titleArray[i], for: .normal)
                    btn.tag = tempTag + i
                    btn.addTarget(self, action: #selector(tabClick(btn:)), for: .touchUpInside)
                    if i == 0{
                        currentButton = btn
                        currentButton.isSelected = true
                    }
                    totalSize = totalSize + width
                    scrollView.addSubview(btn)
                }
                scrollView.contentSize = CGSize(width: totalSize, height: 0)
                
                line = UILabel.init(frame: CGRect(x: 0, y: height, width: currentButton.frame.size.width, height: 1))
                line.backgroundColor = lineColor
                scrollView.addSubview(line)
                self.addSubview(scrollView)
                contentScrollView = UIScrollView.init(frame: CGRect(x: 0, y: height+1, width: ScreenWidth, height: ScreenHeight - height - 1 + CGFloat(contentHeightTab)))
                contentScrollView.contentSize = CGSize(width: ScreenWidth * CGFloat(titleArray.count), height: ScreenHeight - height - 1 + CGFloat(contentHeightTab))
                contentScrollView.showsHorizontalScrollIndicator = false
                contentScrollView.delegate = self
                contentScrollView.isPagingEnabled = true
                self.addSubview(contentScrollView)
                
            }
            
        }
    }
    @objc func tabClick(btn:UIButton){
        let button:UIButton = scrollView.viewWithTag(btn.tag) as! UIButton
        currentButton.isSelected = false
        currentButton = button
        currentButton.isSelected = true
        UIView.animate(withDuration: 0.2, animations: {
            //设置下frame为了改变线的宽度
            self.line.frame.size.width = self.currentButton.frame.width
            self.line.transform = CGAffineTransform(translationX: self.currentButton.frame.minX, y: 0)
        }, completion: nil)
        contentScrollView.scrollRectToVisible(CGRect(x: contentScrollView.frame.width * CGFloat((btn.tag - 100)), y: height + 1, width:contentScrollView.frame.width, height: contentScrollView.frame.height), animated: false)
        delegate?.menuViewIndex(index: btn.tag - 100)
    }
    
    var scrollView:UIScrollView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: height+1))
        scrollView.delegate = self
        
        //        scrollView.isScrollEnabled = false
        scrollView.alwaysBounceVertical = false
        //        scrollView.alwaysBounceHorizontal = false
        
        //        scrollView.isPagingEnabled = true
        
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView{
            currentPage = Int(contentScrollView.contentOffset.x/scrollView.frame.width)
            let button = self.scrollView.viewWithTag(currentPage + 100) as! UIButton
            currentButton.isSelected = false
            currentButton = button
            currentButton.isSelected = true
            
            self.scrollView.scrollRectToVisible(CGRect(x: currentButton.frame.minX ,
                                                       y: CGFloat(contentHeightTab),
                                                       width:currentButton.frame.width,
                                                       height: height+1),
                                                animated: true)
            
            UIView.animate(withDuration: 0.15, animations: {
                self.line.frame.size.width = self.currentButton.frame.width
                self.line.transform = CGAffineTransform(translationX: self.currentButton.frame.minX, y: 0)
                
            }, completion: { (isFinish) in
                self.delegate?.menuViewIndex(index: self.currentPage)
            })
        }
    }
    
    
}
