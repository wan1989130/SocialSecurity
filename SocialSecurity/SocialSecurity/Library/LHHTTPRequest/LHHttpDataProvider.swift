//
//  LHHttpDataProvider.swift
//  HandleSchool
//
//  Created by 李琪 on 16/1/28.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import UIKit
import ObjectMapper

class LHHttpDataProvider {
    class func postFileForDelegate(_ delegate:AnyObject?, data:Array<Data>,  completionBlock:LHHTTPResultJsonHandler?){
        
    }
    class func postFileForDelegate(_ delegate:AnyObject?, clientIdentifier:String?,data:Array<Data>, withParams params:NSMutableDictionary?, completionBlock:LHHTTPResultJsonHandler?){
        var client:LHHTTPClient!
        if clientIdentifier == nil || clientIdentifier!.isEmpty == true{
            client = LHHTTPClient.sharedClient()
        }
        else{
            client = LHHTTPClient.sharedClientWithIdentifier(clientIdentifier!)
        }
        client.POSTFILE( data: data,parameters:params) { (requestSucceed, response, error) in
            let vc = delegate as? BaseViewController
            vc?.endLoad()
            
            if delegate != nil && delegate!.isKind(of: UIViewController.self){
                let vc = delegate as! UIViewController
                UIView.hideProgressHUB(vc.view)
            }
            
            //请求异常时处理方式
            if error != nil{
                if error!.code == -1001{
                    completionBlock?(false,nil)
                    LHAlertView.showTipAlertWithTitle("服务器连接超时")
                    return
                }else if error!.code == -1004 {
                    completionBlock?(false,nil)
                    LHAlertView.showTipAlertWithTitle("无法连接服务器")
                    return
                }else if(error!.code == -1009){
                    completionBlock?(false,nil)
                    LHAlertView.showTipAlertWithTitle("网络未连接")
                    return
                }else {
                    completionBlock?(false,nil)
                    LHAlertView.showTipAlertWithTitle("数据请求失败")
                    return
                }
                
                
            }
            
            
            if response == nil || !(response is NSDictionary){
                completionBlock?(false,nil)
            }
            else{
                //解析请求数据
                
                let myBaseModel = Mapper<BaseModel>().map(JSONObject: response)
                
                if myBaseModel?.code == "100"{//异地登陆
                    LHAlertView.showTipAlertWithTitle((myBaseModel?.msg)!)
                    let config = MyConfig.shared()
                    config.userModel.removeAll()
                    currentUser = nil
                    config.isLogin = false
                    let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    let navController = BaseNavigationViewController(rootViewController: loginVC)
                    UIApplication.shared.keyWindow?.rootViewController = navController
                    
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                    UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
                    
                }else if myBaseModel?.code != "0"{
                    
                    if myBaseModel?.msg != nil && myBaseModel?.msg != ""{
                        LHAlertView.showTipAlertWithTitle((myBaseModel?.msg)!)
                    }
                    
                    
                    completionBlock?(false,nil)
                    
                }else{
                    completionBlock?(true,response!)
                }
                
            }
            
        }
    }
    
    class func postDataForDelegate(_ delegate:AnyObject?, path:String, withParams params:NSMutableDictionary?, verson:String?, completionBlock:LHHTTPResultJsonHandler?) -> Void{
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier:nil, path:path, withParams:params, verson:verson, autoAlert:true, completionBlock:completionBlock)
    }
    
    class func postDataForDelegate(_ delegate:AnyObject?, path:String, withParams params:NSMutableDictionary?, verson:String?, autoAlert:Bool, completionBlock:LHHTTPResultJsonHandler?) -> Void{
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier:nil, path:path, withParams:params, verson:verson, autoAlert:autoAlert, completionBlock:completionBlock)
    }
    
    class func postDataForDelegate(_ delegate:AnyObject?, clientIdentifier:String?, path:String, withParams params:NSMutableDictionary?, verson:String?, completionBlock:LHHTTPResultJsonHandler?) -> Void{
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier:clientIdentifier, path:path, withParams:params, verson:verson, autoAlert:true, completionBlock:completionBlock)
    }
    
    class func postDataForDelegate(_ delegate:AnyObject?, clientIdentifier:String?, path:String, withParams params:NSMutableDictionary?, verson:String?, autoAlert:Bool, completionBlock:LHHTTPResultJsonHandler?) -> Void{
        
        
        var client:LHHTTPClient!
        if clientIdentifier == nil || clientIdentifier!.isEmpty == true{
            client = LHHTTPClient.sharedClient()
        }
        else{
            client = LHHTTPClient.sharedClientWithIdentifier(clientIdentifier!)
        }
        
        
        
        client.POST(path, parameters: params, verson: verson,autoAlert:autoAlert) { (requestSucceed, response, error) -> Void in
            let vc = delegate as? BaseViewController
            vc?.endLoad()
            if delegate != nil && delegate!.isKind(of: UIViewController.self){
                let vc = delegate as! UIViewController
                UIView.hideProgressHUB(vc.view)
            }
            
            //请求异常时处理方式
            
            if error != nil{
                    if error!.code == -1001{
                        completionBlock?(false,nil)
                        LHAlertView.showTipAlertWithTitle("当前网络不给力，请检查网络")
                        return
                    }else if error!.code == -1004 {
                        completionBlock?(false,nil)
                        LHAlertView.showTipAlertWithTitle("无法连接服务器")
                        return
                    }else if(error!.code == -1009){
                        completionBlock?(false,nil)
                        LHAlertView.showTipAlertWithTitle("网络未连接")
                        return
                    }else {
                        completionBlock?(false,nil)
                        LHAlertView.showTipAlertWithTitle("数据请求失败")
                        return
                    }

                
            }
            
            
            if response == nil || !(response is NSDictionary){
                completionBlock?(false,nil)
            }
            else{
                //解析请求数据
    
                let myBaseModel = Mapper<BaseModel>().map(JSONObject: response)

                if myBaseModel?.code == "100"{//异地登陆
                    LHAlertView.showTipAlertWithTitle((myBaseModel?.msg)!)
                    let config = MyConfig.shared()
                    config.userModel.removeAll()
                    currentUser = nil
                    config.isLogin = false

                    let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    let navController = BaseNavigationViewController(rootViewController: loginVC)
                    UIApplication.shared.keyWindow?.rootViewController = navController
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                    UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
                    
                }else if myBaseModel?.code != "0"{
                    if myBaseModel?.msg != nil{
                       LHAlertView.showTipAlertWithTitle((myBaseModel?.msg)!)
                    }
                    
                    completionBlock?(false,nil)
                    
                }else{
                    completionBlock?(true,response!)
                }
       
            }
            
        }
    }
    
}

//MARK:- Get
extension LHHttpDataProvider{
    class func getDataForDelegate(_ delegate:AnyObject?, path:String, withParams params:NSMutableDictionary?, verson:String?, completionBlock:LHHTTPResultJsonHandler?) -> Void{
        LHHttpDataProvider.getDataForDelegate(delegate, clientIdentifier:nil, path:path, withParams:params, verson:verson, autoAlert:true, completionBlock:completionBlock)
    }
    
    class func getDataForDelegate(_ delegate:AnyObject?, path:String, withParams params:NSMutableDictionary?, verson:String?, autoAlert:Bool, completionBlock:LHHTTPResultJsonHandler?) -> Void{
        LHHttpDataProvider.getDataForDelegate(delegate, clientIdentifier:nil, path:path, withParams:params, verson:verson, autoAlert:autoAlert, completionBlock:completionBlock)
    }
    
    
    
    class func getDataForDelegate(_ delegate:AnyObject?, clientIdentifier:String?, path:String, withParams params:NSMutableDictionary?, verson:String?, completionBlock:LHHTTPResultJsonHandler?) -> Void{
        LHHttpDataProvider.getDataForDelegate(delegate, clientIdentifier:clientIdentifier, path:path, withParams:params, verson:verson, autoAlert:true, completionBlock:completionBlock)
    }
    
    class func getDataForDelegate(_ delegate:AnyObject?, clientIdentifier:String?, path:String, withParams params:NSMutableDictionary?, verson:String?, autoAlert:Bool, completionBlock:LHHTTPResultJsonHandler?) -> Void{
     
        var client:LHHTTPClient!
        if clientIdentifier == nil || clientIdentifier!.isEmpty == true{
            client = LHHTTPClient.sharedClient()
        }
        else{
            client = LHHTTPClient.sharedClientWithIdentifier(clientIdentifier!)
        }
        client.GET(path, parameters: params, verson: verson,autoAlert:autoAlert) { (requestSucceed, response, error) -> Void in
                let vc = delegate as? BaseViewController
                vc?.endLoad()
                
                if delegate != nil && delegate!.isKind(of: UIViewController.self){
                    let vc = delegate as! UIViewController
                    UIView.hideProgressHUB(vc.view)
                }
                
                //请求异常时处理方式
                
                if error != nil{
                    if error!.code == -1001{
                        completionBlock?(false,nil)
                        LHAlertView.showTipAlertWithTitle("当前网络不给力，请检查网络")
                        return
                    }else if error!.code == -1004 {
                        completionBlock?(false,nil)
                        LHAlertView.showTipAlertWithTitle("无法连接服务器")
                        return
                    }else if(error!.code == -1009){
                        completionBlock?(false,nil)
                        LHAlertView.showTipAlertWithTitle("网络未连接")
                        return
                    }else {
                        completionBlock?(false,nil)
                        LHAlertView.showTipAlertWithTitle("数据请求失败")
                        return
                    }
                    
                    
                }
                
                
                if response == nil || !(response is NSDictionary){
                    completionBlock?(false,nil)
                }
                else{
                    //解析请求数据
                    
                    let myBaseModel = Mapper<BaseModel>().map(JSONObject: response)
                    
                    if myBaseModel?.code == "100"{//异地登陆
                        LHAlertView.showTipAlertWithTitle((myBaseModel?.msg)!)
                        let config = MyConfig.shared()
                        config.userModel.removeAll()
                        currentUser = nil
                        config.isLogin = false
                        
                        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                        let navController = BaseNavigationViewController(rootViewController: loginVC)
                        UIApplication.shared.keyWindow?.rootViewController = navController
                        UIApplication.shared.keyWindow?.makeKeyAndVisible()
                        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
                        
                    }else if myBaseModel?.code != "0"{
                        
                        LHAlertView.showTipAlertWithTitle((myBaseModel?.msg)!)
                        completionBlock?(false,nil)
                        
                    }else{
                        completionBlock?(true,response!)
                    }
                    
                }
                
            }
        }
    
}
