//
//  InformationMessage.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import Foundation

extension MSDataProvider {
    //意见反馈
    class func suggest(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "suggest.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //昵称修改
    class func updateNickName(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "updateNickName.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //修改密码
    class func updatePassword(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "updatePassword.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
}
