//
//  LHHTTPClient.swift
//  HandleSchool
//
//  Created by 李琪 on 16/1/28.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import UIKit
import ObjectMapper
typealias LHHTTPResultHandler = (_ result:LHHTTPResult) -> Void
typealias LHHTTPResultJsonHandler = (_ isSuccess:Bool,_ result:Any?) -> Void

class LHHTTPClient: NSObject {
    var baseParameters:NSDictionary?
    var basePath:String = ""
    static var sharedClients = NSMutableDictionary()
    static var hud:MBProgressHUD!
    static var manager = AFHTTPSessionManager()
    var currentVc:UIViewController!
//    获取当前controller
    func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
  
    func showHud(){
//        LHHTTPClient.hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        if currentViewController() is InformationMessageViewController{
            currentVc = currentViewController()!.children[0]
            LHHTTPClient.hud = MBProgressHUD.showAdded(to: currentVc.view!, animated: true)
            LHHTTPClient.hud.label.text = "数据加载中"
        }else{
            currentVc = currentViewController()!
  
            LHHTTPClient.hud = MBProgressHUD.showAdded(to: currentVc.view!, animated: true)
            
            LHHTTPClient.hud.label.text = "数据加载中"
        }
        
       
    }
    func hideHud(vc:UIViewController?){
        if vc != nil{
            MBProgressHUD.hide(for: vc!.view!, animated: true)
        }

    }
    class func sharedClient() ->LHHTTPClient{
        return LHHTTPClient.sharedClientWithIdentifier("master")
    }
    
    class func sharedClientWithIdentifier(_ identifier:String) -> LHHTTPClient{
        var client = sharedClients[identifier]
        if client == nil{
            client = LHHTTPClient()
            sharedClients.setObject(client!, forKey: identifier as NSCopying)
        }
        return client as! LHHTTPClient
    }
    
    func POSTFILE( data:Array<Data>, parameters:NSDictionary?,completionBlock:@escaping LHResponseHandler){
        var hideVc:UIViewController?
        
            showHud()
        
        
        print("上传文件-路径:\n\(basePath)")
       //上传参数
        let result = self.getJSONStringFromDictionary(dictionary: parameters as! NSDictionary)
        print("上传参数 = \(result)")
        
        let manager = AFHTTPSessionManager()
        
        manager.responseSerializer = AFJSONResponseSerializer()
        
//                manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.timeoutInterval = 40
        manager.post(basePath, parameters: parameters, constructingBodyWith: { (formData) in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMddHHmmssSSS"
            if parameters != nil {
                if parameters?["typeFile"] != nil{
                    if parameters?["typeFile"] as! String == "1"{
                        for item in data{
                            let fileName = formatter.string(from: Date())+".mp3"
                            formData.appendPart(withFileData: item, name: "file", fileName: fileName, mimeType: "audio/mp3")
                        }
                    }else{
                        for item in data{
                            let fileName = formatter.string(from: Date())+".jpg"
                            formData.appendPart(withFileData: item, name: "file_fields", fileName: fileName, mimeType: "image/jpeg")
                        }
                    }

                }
            }
            
        }, progress: { (progress) in
            
        }, success: { (task, responseObject) in
            let result = self.getJSONStringFromDictionary(dictionary: responseObject as! NSDictionary)
            print("返回的数据 = \(result)")
            
            
            //                        print("data = \(myBaseModel?.data)")
            if LHHTTPClient.hud != nil{
                self.hideHud(vc: hideVc)
            }
            completionBlock(true, responseObject, nil)
        }) { (task, error) in
            if LHHTTPClient.hud != nil{
                self.hideHud(vc: hideVc)
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completionBlock(false, nil, error as NSError)
        }

    }
    
    func POST(_ path:String, parameters:NSDictionary?, verson:String?,autoAlert:Bool, completionBlock:@escaping LHResponseHandler){
        if autoAlert{
                showHud()
        }
        let result = self.getJSONStringFromDictionary(dictionary: parameters as! NSDictionary)
        print("请求参数json = \(result)")
//        print("请求参数 = \(parameters)")
        //将固定的地址与接口名拼接在一起
        var headerURLString:String!
        if verson == nil{
            headerURLString = basePath + path
        }
        else{
            headerURLString = basePath + verson! + "/" + path
        }
        print("访问网络url:\n\(headerURLString!)")
        //创建完整的URL的String对象
        let completeURLString:String! = headerURLString!
        let completeParams = NSMutableDictionary()
        if baseParameters != nil{
            completeParams.addEntries(from: baseParameters! as! [AnyHashable: Any])
        }
        if parameters != nil && parameters!.isKind(of: NSDictionary.self){
            completeParams.addEntries(from: parameters! as! [AnyHashable: Any])
        }
        let fileDic = NSMutableDictionary()
        for key in completeParams.allKeys{
            if completeParams[key] is LHHTTPFileParamEntity{
                fileDic.setObject(completeParams[key] as Any, forKey: key as! NSCopying)
                completeParams.removeObject(forKey: key)
            }
        }
        
//        manager.requestSerializer = AFJSONRequestSerializer()
        LHHTTPClient.manager.requestSerializer = AFHTTPRequestSerializer()

        //header 中加token
//        var token = ""
//        if MyConfig.shared().userModel.count > 0{
//            let userNSObjectModel = NSKeyedUnarchiver.unarchiveObject(with: MyConfig.shared().userModel) as! UserNSObjectModel
//            token = userNSObjectModel.token
//        }
//        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
//        manager.requestSerializer.setValue(HSEncryptionManager.sharedInstance().getToken(), forHTTPHeaderField: "ticket")
//        let now = Date()
//        let timeInterval:TimeInterval = now.timeIntervalSince1970
//        let timeStamp = Int(timeInterval)
//        manager.requestSerializer.setValue(String(timeStamp), forHTTPHeaderField: "time")
        LHHTTPClient.manager.requestSerializer.timeoutInterval = 40
//        manager.requestSerializer.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        LHHTTPClient.manager.responseSerializer = AFJSONResponseSerializer()
        LHHTTPClient.manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json","text/html","text/xml","text/plain", "text/json", "text/javascript") as? Set<String>
        
        LHHTTPClient.manager.post(completeURLString,
                     parameters: completeParams,
                     progress: nil,
                     success: { (task, responseObject) in
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                       let result = self.getJSONStringFromDictionary(dictionary: responseObject as! NSDictionary)
                        print("返回的数据 = \(result)")
                        completionBlock(true, responseObject, nil)
                        
                        
        },
                     failure: { (task, error) in
                        //取消请求
                        if (error as NSError).code == -999{
                            return
                        }
                   UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        completionBlock(false, nil, error as NSError)
        })
        
    }
    
    func GET(_ path:String, parameters:NSDictionary?, verson:String?,autoAlert:Bool, completionBlock:@escaping LHResponseHandler){
        var hideVc:UIViewController?
        if autoAlert{
            
            showHud()
            
        }
        //将固定的地址与接口名拼接在一起
        var headerURLString:String!
        if verson == nil{
            headerURLString = basePath + path
        }
        else{
            headerURLString = basePath + verson! + "/" + path
        }
         print("访问网络url:\n\(headerURLString!)")
        
        //创建完整的URL的String对象
        var completeURLString = headerURLString!
        
        let completeParams = NSMutableDictionary()
        if baseParameters != nil{
            completeParams.addEntries(from: baseParameters! as! [AnyHashable: Any])
        }
        
        if parameters != nil && parameters!.isKind(of: NSDictionary.self){
            completeParams.addEntries(from: parameters! as! [AnyHashable: Any])
        }
        
        if completeParams.count > 0{
            completeURLString = completeURLString + "?" + parameterStringForDictionary(completeParams)
        }
        
        // 启动系统风火轮
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.stringEncoding = String.Encoding.utf8.rawValue
        manager.requestSerializer.timeoutInterval = 40
        
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.stringEncoding = String.Encoding.utf8.rawValue
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json","text/html","text/xml", "text/json", "text/javascript") as? Set<String>
        manager.get(headerURLString, parameters: completeParams, progress: { (progress) in
        }, success: { (URLSessionDataTaskInfo, info) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if info == nil {
                
                completionBlock(true, "", nil)
            }
            else{
                _ = self.getJSONStringFromDictionary(dictionary: info as! NSDictionary)
                if LHHTTPClient.hud != nil{
                    self.hideHud(vc: hideVc)
                }
                completionBlock(true, info, nil)
            }
            
            
        }) { (URLSessionDataTaskInfo, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if LHHTTPClient.hud != nil{
                self.hideHud(vc: hideVc)
            }
            completionBlock(false, "", error as NSError)
        }
    }
    
    func GETAPPSTORE(_ path:String, parameters:NSDictionary?, verson:String?, completionBlock:@escaping LHResponseHandler){
        //将固定的地址与接口名拼接在一起
        var headerURLString:String!
        if verson == nil{
            headerURLString = basePath + path
        }
        else{
            headerURLString = basePath + verson! + "/" + path
        }
        
        
        //创建完整的URL的String对象
        var completeURLString = headerURLString!
        
        let completeParams = NSMutableDictionary()
        if baseParameters != nil{
            completeParams.addEntries(from: baseParameters! as! [AnyHashable: Any])
        }
        
        if parameters != nil && parameters!.isKind(of: NSDictionary.self){
            completeParams.addEntries(from: parameters! as! [AnyHashable: Any])
        }
        
        if completeParams.count > 0{
            completeURLString = completeURLString + "?" + parameterStringForDictionary(completeParams)
        }
        
        // 启动系统风火轮
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.stringEncoding = String.Encoding.utf8.rawValue
        manager.requestSerializer.timeoutInterval = 40
        
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.stringEncoding = String.Encoding.utf8.rawValue
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json","text/html","text/xml", "text/json", "text/javascript") as? Set<String>
        manager.get(headerURLString, parameters: completeParams, progress: { (progress) in
        }, success: { (URLSessionDataTaskInfo, info) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if info == nil {
                completionBlock(true, "", nil)
            }
            else{
                let result = NSString(data: (info as! Data), encoding: String.Encoding.utf8.rawValue)! as String
                completionBlock(true, result, nil)
            }
            
            
        }) { (URLSessionDataTaskInfo, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completionBlock(false, "", error as NSError)
        }
    }

    func parameterStringForDictionary(_ parameters:NSDictionary) -> String{
        let stringParameters = NSMutableArray()
        parameters.enumerateKeysAndObjects(options: []) { (key, obj, stop) -> Void in
            if obj is String{
                stringParameters.add("\(key)=\((obj as! String).encodedURLParameter()!)")
            }
            else if obj is NSNumber{
                stringParameters.add("\(key)=\(obj)")
            }
            else{
                stringParameters.add("\(key)=")
            }
        }
        return stringParameters.componentsJoined(by: "&")
    }
    
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
}
