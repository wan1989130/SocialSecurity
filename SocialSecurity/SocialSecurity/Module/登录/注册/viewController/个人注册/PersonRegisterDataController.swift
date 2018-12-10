//
//  PersonRegisterDataController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class PersonRegisterDataController: BaseDataController {

    
  
    
    var successModel:PersonRegisterSuccessDataModel = PersonRegisterSuccessDataModel()
    //账号注册验证
    func checkPassword(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.checkPassword(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<PersonRegisterSuccessDataModel>().map(JSONObject: result)
                if model != nil{
                    self.successModel = model!
                }
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    //添加注册的新用户
    func addUser(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.addUser(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<PersonRegisterSuccessDataModel>().map(JSONObject: result)
                if model != nil && model!.msg != nil{
                    LHAlertView.showTipAlertWithTitle(model!.msg!)
                }
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    
}
