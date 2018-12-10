//
//  MSDataProvider+Common.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/22.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation
extension MSDataProvider{
    //获取学生列表
    class func getStudents(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier, path: "common/student/listByClass", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
        
    }
}
