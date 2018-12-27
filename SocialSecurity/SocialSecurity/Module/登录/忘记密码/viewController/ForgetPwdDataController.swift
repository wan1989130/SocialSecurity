//
//  ForgetPwdDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class ForgetPwdDataController: BaseDataController {

    //发送验证码
    func getCode(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getCode(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<BaseModel>().map(JSONObject: result)
                if model != nil && model!.msg != nil{
                    LHAlertView.showTipAlertWithTitle(model!.msg!)
                    completionBlock(true, nil)
                }
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    //忘记密码
    func forgetPassword(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.forgetPassword(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<BaseModel>().map(JSONObject: result)
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
