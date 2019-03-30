//
//  BaseViewController.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/2.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit
/**
 * A页面跳转B页面,B页面销毁时给A页面传递数据的Block
 */
typealias BaseViewControllerDismissBlock = (_ param:Any?) -> Void

class BaseViewController: UIViewController {
    var noDataView:NoDataView!//无数据显示的view
    var pushInfoParamString:String?         //通过推送消息启动页面时,用该属性记录参数,多个参数用","分隔
    var senderParam:Any?                    //作为跳转页面时接收消息的参数
    var dismissBlock:BaseViewControllerDismissBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //关闭所有键盘
    func closeKeyboard(){
        closeKeyboard(self.view)
    }
    
    //获取数据请求页码
    func getPageIndex(_ dataArray:Array<Any>, pageSize:Int) -> Int{
        let fullPageCount = dataArray.count / pageSize
        let remainPageCount = dataArray.count % pageSize
        
        return remainPageCount == 0 ? fullPageCount : fullPageCount + 1
    }
    

}
//MARK:- 页面跳转
extension BaseViewController{
    //PUSH
    func pushViewController(_ vcName:String){
        pushViewController(vcName, sender: nil)
    }
    
    /**
     * sender: 接收的参数,可以为任意类型
     */
    func pushViewController(_ vcName:String, sender:Any?){
        pushViewController(vcName, sender: sender, completion: nil)
    }
    
    func pushViewController(_ vcName:String, sender:Any?, completion:BaseViewControllerDismissBlock?){
        closeKeyboard()
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 在 Swift 的 class 需要包含命名空间
        let cls = NSClassFromString(namespace + "." + vcName) as! BaseViewController.Type
        let vc = cls.init(nibName: vcName, bundle: nil)
        vc.senderParam = sender
        vc.dismissBlock = completion
        vc.hidesBottomBarWhenPushed = true
//        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.loadImage("arrow_back"), style: UIBarButtonItemStyle.plain, target: vc, action: #selector(vc.back))
        let button =   UIButton(type: .system)
        button.frame = CGRect(x:0, y:0, width:10, height:30)
        button.setImage(UIImage(named:"arrow_back"), for: .normal)
        button.setTitle("返回", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.sizeToFit()
        button.addTarget(self, action: #selector(vc.back), for: .touchUpInside)
        let leftBarBtn = UIBarButtonItem(customView: button)
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -5;
        vc.navigationItem.leftBarButtonItems = [spacer,leftBarBtn]
        
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func back(){
        if LHHTTPClient.manager.tasks.count > 0{
            for task in LHHTTPClient.manager.tasks{
                if task.state == .running || task.state == .suspended{
                    task.cancel()
                }
            }
        }
        MBProgressHUD.hide(for: self.view, animated: true)
//        LHHTTPClient.hud = nil
        navigationController?.popViewController(animated: true)
    }
    
    
    //PRESENT
    func presentViewController(_ vcName:String){
        presentViewController(vcName, sender:nil, completion: nil)
    }
    
    func presentViewController(_ vcName:String, sender:Any?){
        presentViewController(vcName, sender:sender, completion: nil)
    }
    
    /**
     * sender: 接收的参数,可以为任意类型
     */
    func presentViewController(_ vcName:String, sender:Any?, completion: (() -> Swift.Void)? = nil){
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 在 Swift 的 class 需要包含命名空间
        let cls = NSClassFromString(namespace + "." + vcName) as! BaseViewController.Type
        let vc = cls.init(nibName:vcName, bundle:nil)
        present(vc, animated: true, completion: completion)
    }
}

//MARK:- Web
extension BaseViewController{
    //加载进度圈
    func beginLoad() -> Void{
        UIView.showProgressHUB(self.view)
    }
    
    //取消进度圈
    func endLoad(){
        UIView.hideProgressHUB(self.view)
    }
}

//MARK:- Private
extension BaseViewController{
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //统计功能
//        if self.title != nil && !NSString.isNilOrEmpty(self.title){
//            MobClick.beginLogPageView(self.title)
//        }
//        else{
//            MobClick.beginLogPageView(NSStringFromClass(object_getClass(self)))
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("aaaac = \(self.view.viewController())")
        MBProgressHUD.hide(for: self.view, animated: true)
//        if LHHTTPClient.manager.tasks.count > 0{
//            for task in LHHTTPClient.manager.tasks{
//                if task.state == .running || task.state == .suspended{
//                    task.cancel()
//                }
//            }
//        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
        //统计功能
//        if self.title != nil && !NSString.isNilOrEmpty(self.title){
//            MobClick.endLogPageView(self.title)
//        }
//        else{
//            MobClick.endLogPageView(NSStringFromClass(object_getClass(self)))
//        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        closeKeyboard()
    }
    
    fileprivate func closeKeyboard(_ view:UIView){
        for subView in view.subviews{
            if subView is UITextView || subView is UITextField || subView is UISearchBar{
                subView.resignFirstResponder()
            }
            
            if subView.subviews.count > 0{
                closeKeyboard(subView)
            }
        }
    }
    
    /**
     * 获取当前屏幕显示的viewController
     */
    class func getCurrentVC() -> UIViewController{
        var result:UIViewController? = nil
        var window:UIWindow! = UIApplication.shared.keyWindow
        if window.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                    break
                }
            }
        }
        var nextResponder:AnyObject? = nil
        let appRootVC:UIViewController! = window.rootViewController
        if appRootVC.presentedViewController != nil {
            nextResponder = appRootVC.presentedViewController
        }else{
            let frontView:UIView! = window.subviews[0]
            nextResponder = frontView.next
        }
        if nextResponder is UITabBarController {
            let tabbar = nextResponder as! UITabBarController
            let nav:UINavigationController = tabbar.viewControllers![tabbar.selectedIndex] as! UINavigationController
            result = nav.children.last
        }
        else if(nextResponder is UINavigationController){
            let nav:UIViewController = nextResponder as! UIViewController
            result = nav.children.last
        }
        else{
            result = nextResponder as? UIViewController
        }
        return result!
    }

    //判断是否加载无数据样式
    func addNoDataView(loadType:DirectionType,dataCount:Int,msg:String,imageName:String?,tableView:UITableView){
        if loadType == .top || loadType == .first{
            if dataCount < 1{
                if noDataView == nil{
                    noDataView = UIView.loadViewWithName("NoDataView") as! NoDataView
                    noDataView.noDataLabel.text = msg
                    if imageName != nil{
                        noDataView.noDataImageView.image = UIImage.loadImage(imageName!)
                    }
                    noDataView.drawInView(self.view, leftMargin: 0, topMargin: tableView.frame.minY, rightMargin: 0, bottomMargin: 0)
                }
            }
        }
    }
    //tableView上有布局的情况
    func addNoDataView(loadType:DirectionType,dataCount:Int,msg:String,imageName:String?,topMargin:CGFloat){
        if loadType == .top || loadType == .first{
            if dataCount < 1{
                if noDataView == nil{
                    noDataView = UIView.loadViewWithName("NoDataView") as! NoDataView
                    noDataView.noDataLabel.text = msg
                    if imageName != nil{
                        noDataView.noDataImageView.image = UIImage.loadImage(imageName!)
                    }
                    noDataView.drawInView(self.view, leftMargin: 0, topMargin: topMargin, rightMargin: 0, bottomMargin: 0)
                }
            }
        }
    }
    
    //返回无数据view
    func returnNoDataView(loadType:DirectionType,dataCount:Int,msg:String,imageName:String?,tableView:UITableView)->UIView?{
            if dataCount < 1{
                if noDataView == nil{
                    noDataView = UIView.loadViewWithName("NoDataView") as! NoDataView
                    noDataView.noDataLabel.text = msg
                    if imageName != nil{
                        noDataView.noDataImageView.image = UIImage.loadImage(imageName!)
                    }
                    return noDataView
                }
            }
        return nil
    }
    
    

    
}
