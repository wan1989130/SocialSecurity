//
//  MSVersionManager.swift
//  HandleSchool
//
//  Created by 李琪 on 16/5/31.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import ObjectMapper
import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

var sharedVersionManager:MSVersionManager?
class MSVersionManager {
    var reachability:Reachability!
    let HSHTTPAppStoreServerID = "HSAPPStoreID"
    
    class func sharedInstance() -> MSVersionManager{
        if sharedVersionManager == nil{
            sharedVersionManager = MSVersionManager()
        }
        return sharedVersionManager!
    }
    
    init() {
        reachability = Reachability.forInternetConnection()
    }
    
    func getLocalVersion() -> String{
        return appBuildVersion
    }
    
    func checkAppStoreVersion(){
        LHHTTPClient.sharedClientWithIdentifier(HSHTTPAppStoreServerID).basePath = "http://itunes.apple.com/"
        LHHTTPClient.sharedClientWithIdentifier(HSHTTPAppStoreServerID).GETAPPSTORE("lookup", parameters: ["id":MyAppID], verson:nil) { (requestSucceed, response, error) -> Void in
            
            //请求异常时处理方式
            if error != nil{
                return
            }
            
            if (response as? String)?.jsonValue() as? NSDictionary == nil{
                return
            }
            
            let jsonData = ((response as AnyObject) as? String)?.jsonValue() as! NSDictionary
            let infoArray = jsonData["results"] as! NSArray
            
            if (infoArray.count > 0) {
                if infoArray[0] is NSDictionary{
                    let releaseInfo = infoArray[0] as! NSDictionary
                    let versionInfo = HSAppVersionInfo()
                    versionInfo.version = releaseInfo["version"] as! String
                    versionInfo.trackViewUrl = releaseInfo["trackViewUrl"] as! String
                    
                    if self.shouldUpdateApp(versionInfo.version){
                        self.checkUpdateRequest(versionNo:versionInfo.version ,trackViewUrl:versionInfo.trackViewUrl)
                    }
                }
            }
        }
    }
    
    //调接口检查更新
    func checkUpdateRequest(versionNo:String ,trackViewUrl:String){
//        let window = UIApplication.shared.keyWindow
//        let tab = window?.rootViewController as! BaseTabBarViewController
//        let nav = tab.selectedViewController as! BaseNavigationViewController
//        let baseVc = nav.childViewControllers[0]
        let parameter:NSMutableDictionary = [
            "versionNo":versionNo,
            "versionType":"2"
        ]
        MSDataProvider.getVersion(delegate: (UIApplication.shared.keyWindow?.rootViewController)!, parameter: parameter, autoAlert: false) { (isSuccess, result) in
            if isSuccess{
                let model = Mapper<VersionDataModel>().map(JSONObject: result)!
                self.updateAppShow(updateStatus: model.data.updateStatus, trackViewUrl: trackViewUrl ,versionDesc:model.data.versionDesc)
            }else{
            }
        }
    }
    
    func updateAppShow(updateStatus:String ,trackViewUrl:String ,versionDesc:String) {
        LHAlertView.showAlertWithTitle("更新", msg: versionDesc, confirmButtonTitle: "更新", cancelButtonTitle: "关闭", completionBlock: {
            UIApplication.shared.openURL(URL(string: trackViewUrl)!)
        }, cancelBlock: {
            if updateStatus == "2" {
                exit(0)
            }
        })

    }
    
    func shouldUpdateApp(_ newVersion:String) -> Bool{
        let newVersionArray = newVersion.components(separatedBy: ".")
        let localVersionArray = appBuildVersion.components(separatedBy: ".")
        
        for i in 0..<newVersionArray.count{
            if Int(localVersionArray[i]) > Int(newVersionArray[i]){
                return false
            }
            if Int(localVersionArray[i]) == Int(newVersionArray[i]){
                continue
            }
            if Int(localVersionArray[i]) < Int(newVersionArray[i]){
                return true
            }
        }
        return false
    }
}

class HSAppVersionInfo {
    var version = ""
    var trackViewUrl = ""
}
