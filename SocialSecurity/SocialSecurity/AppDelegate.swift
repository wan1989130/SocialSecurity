//
//  AppDelegate.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/5.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        SQLiteManager.sharedTools
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
            return false
            
        }
        statusBar.backgroundColor = UIColor.black
     
        
        //创建window
        loadWindow()
        
        //初始化网络请求组件
        initBaseClient()
        
        //根据应用版本及登录状态跳转至相应页面
        self.performToTargetVCAccordingToVersionAndLoginStatus()
        
        
        
        
        //隐藏键盘工具条
        keyManager()
        
        //        UITableView.appearance().estimatedRowHeight = UIScreen.main.bounds.size.height
        
        UITabBar.appearance().backgroundImage=UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        //ios12.1tabBar 中的图标及文字出现位置偏移动画
        //https://blog.csdn.net/longge_li/article/details/83654333
        UITabBar.appearance().isTranslucent = false
        //skphoto内存缓存图片
        //                SKCache.sharedCache.removeAllImages()
        
        SDImageCache.shared().clearDisk(onCompletion: nil)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        MSVersionManager.sharedInstance().checkAppStoreVersion()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

