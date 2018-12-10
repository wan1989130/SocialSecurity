//
//  InformationMessage.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import Foundation

extension MSDataProvider {
    //获取发货信息列表与统计分析钻取页共用（筛选+分页）
    class func shippingList(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/shippingList", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //查询发货单详情
    class func shippingDetail(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/shippingDetail", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    
}
