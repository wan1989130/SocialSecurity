//
//  InformationMessage.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import Foundation

extension MSDataProvider {
    //通讯录列表查询(无分页)
    class func telephoneList(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "ph/telephoneList", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    
}
