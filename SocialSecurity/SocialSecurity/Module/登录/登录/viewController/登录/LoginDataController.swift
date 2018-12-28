//
//  LoginDataController.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class LoginDataController: BaseDataController {
    
    
    
    func login(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.login(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<LoginModel>().map(JSONObject: result)
                if model != nil{
//                    let data = NSKeyedArchiver.archivedData(withRootObject: model?.data.toNSObject())
                    
                    
                    MyConfig.shared().phone = model!.data.phone
                    MyConfig.shared().headPhoto = model!.data.headPhoto
                    MyConfig.shared().shebaoUrl = model!.data.shebaoUrl
                    MyConfig.shared().zhikajinduUrl = model!.data.zhikajinduUrl
                    MyConfig.shared().yibaoUrl = model!.data.yibaoUrl
                    MyConfig.shared().userName = model!.data.userName
                    MyConfig.shared().token = model!.data.token
                    
//                    MyConfig.shared().userModel = data
//                    currentUser = model?.data
//                    MyConfig.shared().isLogin = true
                    completionBlock(true, nil)
                }else{
                    completionBlock(false, nil)
                }
            }else{
                completionBlock(false, nil)
            }
            
        }
        
    }
    
    
}

