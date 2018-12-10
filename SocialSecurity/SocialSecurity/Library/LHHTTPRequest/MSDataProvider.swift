//
//  MSDataProvider.swift
//  MiddleSchool2_student
//
//  Created by 李琪 on 2017/5/25.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class MSDataProvider: Any {
    
       
    class func postFile(delegate:UIViewController, files:Array<Data>, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postFileForDelegate(delegate, data: files, completionBlock: completionBlock)
    }
    
    class func createJsonString(_ param:AnyObject?)->String{
        if param == nil{
            return ""
        }
        let writer = SBJsonWriter()
        
        let jsonString = writer.string(with: param)
        if jsonString != nil{
            return jsonString!
        }
        else{
            return ""
        }
    }
    // MARK: - Initial
    class func initBaseClient()->Void{
        LHHTTPClient.sharedClient().basePath = HostAddress
        LHHTTPClient.sharedClientWithIdentifier(ToolKitServerClientIdentifier).basePath = HostAddress
        LHHTTPClient.sharedClientWithIdentifier(FileServerClientIdentifier).basePath = FileServerAddress
        LHHTTPClient.sharedClientWithIdentifier(GetAreaServerClientIdentifier).basePath = GetAreaListHost
        
    }
    
    
}
