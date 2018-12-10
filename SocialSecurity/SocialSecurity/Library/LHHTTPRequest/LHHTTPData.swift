//
//  LHHTTPData.swift
//  MiddleSchool2_student
//
//  Created by 李琪 on 2017/5/25.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

typealias LHResponseHandler = (_ requestSucceed:Bool, _ response:Any?, _ error:NSError?) -> Void

class LHHTTPResult {
    var isSucceed:Bool = false
    var code:Int = -1
    var resultInfo:AnyObject?
    var errorTitle:String = ""
    var fileResponses:Array<LHHTTPFileResponseEntity> = [LHHTTPFileResponseEntity]()
    
    init(){
        
    }

    init(withJson jsonDic:NSDictionary) {
        if jsonDic["code"] != nil{
            if jsonDic["code"] is NSNumber{
                code = (jsonDic["code"] as! NSNumber).intValue
            }
            else{
                code = Int(jsonDic["code"] as! String) == nil ? -1 : Int(jsonDic["code"] as! String)!
            }
        }
        if code == 0{
            isSucceed = true
        }
        else{
            isSucceed = false
        }
        
        if jsonDic["msg"] != nil{
            errorTitle = jsonDic["msg"] as! String
        }
       
        if jsonDic["data"] != nil{
            resultInfo = jsonDic["data"] as AnyObject
        }
    }
    
    init(fileResponse jsonDic:NSDictionary){
        if jsonDic["status"] != nil{
            isSucceed = jsonDic["status"] as! String == "1"
        }
        
        if jsonDic["success"] != nil{
            code = (jsonDic["success"] as! NSNumber).intValue
        }
        
        if jsonDic["megs"] != nil{
            errorTitle = jsonDic["megs"] as! String
        }
        
        resultInfo = jsonDic
        
        if jsonDic["results"] != nil && jsonDic["results"] is NSArray{
            for item in jsonDic["results"] as! NSArray{
                if item is NSDictionary{
                    fileResponses.append(LHHTTPFileResponseEntity(item: item as! NSDictionary))
                }
            }
            
        }
        
    }
}

class LHHTTPFileResponseEntity{
    var originalFileName = ""   //原始文件名             "201706131006119750.jpg",
    var size:UInt64 = 0         //文件大小,单位(B)        3380
    var realFileName = ""       //文件服务器中存储的文件名  "a9115ddc96ae47e6a6cb8b2599ed4407.jpg"
    var path = ""               //文件所在的服务器目录     "resources/0/20170613/"
    var status = false          //是否成功
    var thumbnailPath = ""      //缩略图路径             "thumbnail/0/20170613/a9115ddc96ae47e6a6cb8b2599ed4407.jpg"
    var accessPath = ""         //原图路径               "resources/0/20170613/a9115ddc96ae47e6a6cb8b2599ed4407.jpg"

    
    init(){
        
    }
    
    init(item:NSDictionary){
        if item["originalFileName"] != nil{
            originalFileName = item["originalFileName"] as! String
        }
        if item["size"] != nil{
            size = (item["size"] as! NSNumber).uint64Value
        }
        if item["realFileName"] != nil{
            realFileName = item["realFileName"] as! String
        }
        if item["path"] != nil{
            path = item["path"] as! String
        }
        if item["status"] != nil{
            status = (item["status"] as! String == "1")
        }
        if item["thumbnailPath"] != nil{
            thumbnailPath = item["thumbnailPath"] as! String
        }
        if item["accessPath"] != nil{
            accessPath = item["accessPath"] as! String
        }
    }
}

class LHHTTPFileParamEntity{
    var fileName = ""
    var fileType = ""
    var fileContent:Data?
    
    class func entity(withFileName fileName:String, fileContent content:Data) -> LHHTTPFileParamEntity?{
        let eneity = LHHTTPFileParamEntity()
        let array = fileName.components(separatedBy: ".")
        if array.count < 2{
            return nil
        }
        eneity.fileName = array[0]
        eneity.fileType = array[1]
        
        if UIImage(data: content) != nil{
            let compressedImage = LHImageCompressor.compressImage(UIImage(data: content))
            eneity.fileContent = compressedImage?.jpegData(compressionQuality: 1)
            eneity.fileType = "jpg"
        }
        else{
            eneity.fileContent = content
        }
        return eneity
    }
    
    class func entity(withFileName fileName:String, fileType type:String, fileContent content:Data) -> LHHTTPFileParamEntity?{
        let eneity = LHHTTPFileParamEntity()

        eneity.fileName = fileName
        eneity.fileType = type
        
        if UIImage(data: content) != nil{
            let compressedImage = LHImageCompressor.compressImage(UIImage(data: content))
            eneity.fileContent = compressedImage?.jpegData(compressionQuality: 1)
            eneity.fileType = "jpg"
        }
        else{
            eneity.fileContent = content
        }
        return eneity
    }
}
