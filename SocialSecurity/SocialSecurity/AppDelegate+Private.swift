
//  AppDelegate+Perform.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/5.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit
import ObjectMapper
extension AppDelegate {
  
    
    //创建window
    func loadWindow(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
    }
    
    // MARK: - Initial
    func initBaseClient()->Void{
        MSDataProvider.initBaseClient()
    }
    
    
    //根据应用版本及登录状态跳转至相应页面
    func performToTargetVCAccordingToVersionAndLoginStatus(){
//        performToLoginViewController()
        
        
//        let deviceUUID = UIDevice.current.identifierForVendor?.uuid
//        print("设备信息\(deviceUUID!)")
        
        //第一次启动进入引导页
//        if MyConfig.shared().isNewVersion == true{
//            let config = MyConfig.shared()
////            if config.userModel.count > 0{
////                let userNSObjectModel = NSKeyedUnarchiver.unarchiveObject(with: config.userModel) as! UserNSObjectModel
////                userNSObjectModel.token = ""
////                config.userModel = NSKeyedArchiver.archivedData(withRootObject: userNSObjectModel)
////                config.isLogin = false
////            }
//           
//            performToGuideViewController()
//        }
//        else{
//                                performToLoginViewController()
////                  performToMainViewController()
            if MyConfig.shared().token != ""{
               
                    //如果登录过,并且本地有用户登录信息,跳转至首页
                    performToMainViewController()
              
            }else{
                //未登录过,跳转至登录页
                performToLoginViewController()
            }
//
//        }
    }
    //隐藏键盘工具条
    func keyManager(){
        
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        
    }
}

extension AppDelegate {
    //跳转至引导页
    func performToGuideViewController(){
        let picArr = [UIImage.loadImage("guidePage1"),UIImage.loadImage("guidePage2"),UIImage.loadImage("guidePage3")]
        let titleArr = ["立即体验"]
        
        let guideVC = MSGuidePageViewController.sharedGuideVC()
        guideVC.guidePage(withPicArray: picArr, andTitleArray: titleArr)
        
        window?.rootViewController = guideVC
        window?.makeKeyAndVisible()
        window?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
    
    //跳转至登录页
    func performToLoginViewController(){
        
        
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navController = BaseNavigationViewController(rootViewController: loginVC)
        window?.rootViewController = navController
//        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
//        window?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
        
    }
    
    //跳转至首页
    func performToMainViewController(){
        
        let tabbarVC = BaseTabBarViewController()
        
        window?.rootViewController = tabbarVC
        window?.makeKeyAndVisible()
//        window?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
    func getCurrentUser(){
        let config = MyConfig.shared()
        if config.userModel.count > 0 {
            
            let userNSObjectModel = NSKeyedUnarchiver.unarchiveObject(with: config.userModel) as! UserNSObjectModel
            
            currentUser = userNSObjectModel.toAnyObject()
           
            print("token = " + currentUser.token)
            
        
        }
    }
    
}
