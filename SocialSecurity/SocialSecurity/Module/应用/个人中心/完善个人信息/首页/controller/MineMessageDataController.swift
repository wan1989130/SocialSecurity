//
//  MineMessageDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/18.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class MineMessageDataController: BaseDataController {
    var uploadPhotoModel = UploadFileSocialSecurityDataModel()
    //上传图片
    func uploadPhoto(imgDataArray:Array<Data>,parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.uploadFile(delegate: self.delegate!, imgDataArray: imgDataArray,parameter:parameter) { (isSuccess, result) in
            if isSuccess{
                self.uploadPhotoModel = Mapper<UploadFileSocialSecurityDataModel>().map(JSONObject: result)!
                
                completionBlock(true, nil)
            }else{
                
                completionBlock(false, nil)
            }
        }
    }
    
    
    func uploadHeadPhoto(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.uploadHeadPhoto(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<BaseModel>().map(JSONObject: result)
                if model != nil && model!.msg != nil{
                    LHAlertView.showTipAlertWithTitle(model!.msg!)
                    completionBlock(true, nil)
                }
                
            }else{
                completionBlock(false, nil)
            }
            
        }
        
    }
}
