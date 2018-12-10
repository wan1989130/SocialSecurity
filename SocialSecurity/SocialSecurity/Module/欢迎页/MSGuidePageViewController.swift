//
//  MSGuidePageViewController.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/4.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class MSGuidePageViewController: BaseViewController,UIScrollViewDelegate {
    static var instance = MSGuidePageViewController()
    var kNumberOfPages:Int = 3
    
    var picArr = [UIImage]()
    var titleArr = [String]()
    var scView:UIScrollView!
    var pageControl:UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        createScrollerView()
        createPageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        pageControl.currentPage = 0
        
    }
    
    //MARK:- Btn 点击事件
    @objc func btnClicked(_ btn:UIButton){
        if btn.tag == 1000{
            performToMainViewController()
//            if MyConfig.shared().userModel.count > 0{
//                let userNSObjectModel = NSKeyedUnarchiver.unarchiveObject(with: MyConfig.shared().userModel) as! UserNSObjectModel
//                if MyConfig.shared().isLogin && userNSObjectModel.token != ""{
//                    currentUser = userNSObjectModel.toAnyObject()
//                    //如果登录过,并且本地有用户登录信息,跳转至首页
//                    performToMainViewController()
//                }
//                else{
//                    //未登录过,跳转至登录页
//                    performToLoginViewController()
//                }
//            }else{
//                //未登录过,跳转至登录页
//                performToLoginViewController()
//            }
        }
    }
    //跳转至登录页
    func performToLoginViewController(){
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navController = BaseNavigationViewController(rootViewController: loginVC)
        UIApplication.shared.keyWindow?.rootViewController = navController
        //        window?.rootViewController = loginVC
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
        
    }
    
    //跳转至首页
    func performToMainViewController(){
//        //获取currentUser
//        if !getCurrentUser(){
//            performToLoginViewController()
//            return
//        }
        let tabbarVC = BaseTabBarViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
    func getCurrentUser() -> Bool{
        let config = MyConfig.shared()
        if config.userModel.count > 0 {
            
            let userNSObjectModel = NSKeyedUnarchiver.unarchiveObject(with: config.userModel) as! UserNSObjectModel
            
            currentUser = userNSObjectModel.toAnyObject()
            if currentUser.userType == .error{
                
                return false
            }
            print("token = " + currentUser.token)
            return true
            
        }else{
            return false
        }
        
    }
    
    //MARK:- 外部设置启动图 Arr 对应方法
    func guidePage(withPicArray picArray:Array<UIImage>, andTitleArray titleArray:Array<String>){
        picArr = picArray
        titleArr = titleArray
        kNumberOfPages = picArr.count
    }
    
    //MARK:- 创建 VC
    class func sharedGuideVC() -> MSGuidePageViewController{
        return instance
    }
    
    func createScrollerView(){
        scView = UIScrollView(frame: UIScreen.main.bounds)
        scView.delegate = self
        view.addSubview(scView)
        scView.contentSize = CGSize(width: CGFloat(kNumberOfPages) * ScreenWidth, height: ScreenHeight)
        scView.isPagingEnabled = true
        scView.bounces = false
        scView.showsHorizontalScrollIndicator = false
        
        for i in 0..<picArr.count{
            let imgViewPic = UIImageView(frame: CGRect(x: ScreenWidth * CGFloat(i), y: 0, width: ScreenWidth, height: ScreenHeight))
            imgViewPic.image = picArr[i]
            imgViewPic.tag = 100 + i
            scView.addSubview(imgViewPic)
            
            if kNumberOfPages - 1 == i{
                
                //最后一页的按钮按钮
                for j in 0..<titleArr.count{
                    let btn = UIButton(type: .custom)
                    btn.frame = CGRect(x: ScreenWidth / 2 + CGFloat(kNumberOfPages - 1) * ScreenWidth - 90, y: ScreenHeight - 120, width: 180, height: 44)
                    btn.tag = 1000 + j
                    btn.setTitle(titleArr[j], for: .normal)
                    btn.setBackgroundImage(UIImage.init(named: "button_bg"), for: .normal)
                    btn.addTarget(self, action: #selector(self.btnClicked(_:)), for: .touchUpInside)
                    scView.addSubview(btn)
                    btn.layer.cornerRadius = 5
                }
                
            }
        }
    }
    
    func createPageControl(){
        pageControl = UIPageControl(frame: CGRect(x: (ScreenWidth - 40) / 2, y: ScreenHeight - 50, width: 40, height: 20))
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor.init(hexString: "666666")
        pageControl.pageIndicatorTintColor = UIColor.init(hexString: "999999")
        view.addSubview(pageControl)
    }
    
    //MARK:- scrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scView.contentOffset.x / ScreenWidth)
    }
}
