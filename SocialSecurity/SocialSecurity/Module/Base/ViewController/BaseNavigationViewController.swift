//
//  BaseNavigationViewController.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/4.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController,UINavigationControllerDelegate {
    var popDelegate: UIGestureRecognizerDelegate?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    //UINavigationControllerDelegate方法
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //实现滑动返回功能
        //清空滑动返回手势的代理就能实现
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }
        else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        //设置导航条样式
        //TODO:根据实际样式编写
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        UINavigationBar.appearance().barTintColor = UIColor(hexString: "1999D9")
//        self.navigationBar.setBackgroundImage(UIImage.init(named: "button_bg1")!, for: .default)
//        UINavigationBar.appearance().barTintColor = UIColor.init(patternImage: UIImage.init(named: "button_bg1")!)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
    }
    
    //    /**
    //     * 重写这个方法的目的是拦截所有push进来的控制器
    //     * @param viewController 即将push进来的控制器
    //     * @param animated 是否有动画效果
    //     */
    //    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    //        if viewControllers.count > 0{
    //            viewController.hidesBottomBarWhenPushed = true
    //            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.loadImage("arrow_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back))
    //        }
    //        super.pushViewController(viewController, animated: animated)
    //    }
    //
    //
    //
    //    func back(){
    //        popViewController(animated: true)
    //    }
    
}
