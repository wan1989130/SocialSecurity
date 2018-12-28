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
    //身份证查询
    class func idCardQuery(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "idCardQuery.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //扫描身份证是否可用
    class func scanQuery(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "scanQuery.do", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //扫描身份证使用
    class func scanCountQuery(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "scanCountQuery.do", withParams: parameter, verson: nil, autoAlert: true, completionBlock: completionBlock)
    }
    //国标项
    class func getDictionary(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "getDictionary.do", withParams: parameter, verson: nil, autoAlert: true, completionBlock: completionBlock)
    }
    // 录入和修改
    class func addOrUpdate(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "addOrUpdate.do", withParams: parameter, verson: nil, autoAlert: true, completionBlock: completionBlock)
    }
    // 查看详情
    class func queryDetail(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "queryDetail.do", withParams: parameter, verson: nil, autoAlert: true, completionBlock: completionBlock)
    }
    //采集进度查询
    class func allPeopleQuery(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "allPeopleQuery.do", withParams: parameter, verson: nil, autoAlert: true, completionBlock: completionBlock)
    }
}
