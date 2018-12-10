//
//  InformationMessage.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import Foundation

extension MSDataProvider {
    //收件量分析统计
    class func goodsStatistics(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/goodsStatistics", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    
}
