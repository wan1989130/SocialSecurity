//
//  InformationMessage.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import Foundation

extension MSDataProvider {
    //采集进度查询(查询自己)
    
    class func selfQuery(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "selfQuery.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //获取已经录入数量
    class func getWriteCount(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "getWriteCount.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
}
