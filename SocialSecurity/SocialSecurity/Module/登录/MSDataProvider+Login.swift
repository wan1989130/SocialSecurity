//
//  MSDataProvider+Login.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation

extension MSDataProvider{
    //登陆接口
    class func login(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "login.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
 
    //添加注册的新用户
    class func register(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "register.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
 
    //获取验证码
    class func getCode(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "getCode.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
   
    //忘记密码
    class func forgetPassword(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "forgetPassword.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
   
    

}
