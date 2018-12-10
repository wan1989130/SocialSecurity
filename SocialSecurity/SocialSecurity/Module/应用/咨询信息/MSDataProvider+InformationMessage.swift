//
//  InformationMessage.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import Foundation

extension MSDataProvider {
    //资讯信息管理列表（筛选+分页）
    class func informationList(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/informationList", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //获取资讯详情
    class func informationDetail(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/informationDetail", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
}
