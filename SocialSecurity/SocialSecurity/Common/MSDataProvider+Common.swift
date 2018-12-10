//
//  MSDataProvider+Common.swift
//  SeniorHighSchoolProject
//
//  Created by 李琪 on 2017/8/21.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

extension MSDataProvider {
   
    //获取年级列表
    class func getGrades(delegate:UIViewController, parameter:NSMutableDictionary,completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier, path: "outcomes/get_Grade", withParams: parameter, verson: nil, completionBlock: completionBlock)
       
    }
    
    //获取年班列表
    class func getClasses(delegate:UIViewController, parameter:NSMutableDictionary,completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "comment/get_Class_Grade", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //获取班级列表
    class func getOnlyClass(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "outcomes/get_Class", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    //获取学期
    class func getTerms(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "comment/get_Term", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    //上传文件
    class func uploadFile(delegate:UIViewController,imgDataArray:Array<Data>,  parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postFileForDelegate(delegate,clientIdentifier: FileServerClientIdentifier ,data: imgDataArray, withParams: parameter,completionBlock: completionBlock)
    }
    
    ///获取区域列表
    class func getAreaList(delegate:UIViewController, completionBlock:@escaping LHHTTPResultJsonHandler){
        let param:NSMutableDictionary = [
            "productId":ProductId
        ]
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: GetAreaServerClientIdentifier, path: "getServices", withParams: param, verson: "v1", completionBlock: completionBlock)
    }
    //获取配置接口
    class func getConfig(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "getMobileConfig", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    //检查更新
    class func getVersion(delegate:UIViewController, parameter:NSMutableDictionary,autoAlert:Bool , completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "app/checkVersion", withParams: parameter, verson: nil, autoAlert: autoAlert, completionBlock: completionBlock)
    }
    
    
}
