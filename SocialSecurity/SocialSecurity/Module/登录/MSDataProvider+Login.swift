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
    //查询所有单位名称
    class func selectCompany(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/companyList", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //验证密码是否有效
    class func checkPassword(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/checkPassword", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //添加注册的新用户
    class func addUser(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/addUser", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //第一次绑定手机号
    class func firstBindPhone(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){

        LHHttpDataProvider.postDataForDelegate(delegate, path: "auth/bindPhone", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //获取验证码
    class func getVerCode(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "verCode", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //验证原绑定手机验证码
    class func commonCheckVerCodeByBindAccount(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "common/checkVerCodeByBindAccount", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //账号绑定
    class func authBindAccount(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "auth/bindAccount", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //根据用户名密码获取（教师学校列表、家长学生列表）
    class func getSchOrStuListByUser(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "getSchOrStuListByUser", withParams: parameter, verson: nil, completionBlock: completionBlock)
       
    }
    //找回密码
    class func authFindPwd(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "resetPassword", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    //账号注册验证
    class func commonCheckVerCodeByFindPwd(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "register/user", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    //企业注册
    class func enterpriseRegister(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "register/enterprise", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    //个人信息完善
    class func personInformation(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "user/updateUserInfo", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    

}
