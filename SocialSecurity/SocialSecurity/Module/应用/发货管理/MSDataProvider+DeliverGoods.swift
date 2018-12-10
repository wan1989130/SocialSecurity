//
//  MSDataProvider+DeliverGoods.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

extension MSDataProvider {

    //区域获取
    class func areaList(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/areaList", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //发货管理录入
    class func addShippingInfo(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/addShippingInfo", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //根据发货人身份证号查找发货人、收货人信息
    class func getUserByCard(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/getUserByCard", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    
}
