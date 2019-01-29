//
//  YwjbDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class YwjbDataController: BaseDataController {

    var selfQueryIsSuccess = false
    var model:SelfQueryDataModel!
    var toolArray:Array<ApplyToolModel> = [ApplyToolModel]()
    override init(delegate: UIViewController) {
        super.init(delegate: delegate)
        let model1 = ApplyToolModel()
        model1.text = "社会保障卡信息采集"
        model1.image = UIImage(named: "xxcj")
        let model2 = ApplyToolModel()
        model2.text = "制卡进度查询"
        model2.image = UIImage(named: "zkjd")
        let model3 = ApplyToolModel()
        model3.text = "社保查询"
        model3.image = UIImage(named: "sbcx")
        let model4 = ApplyToolModel()
        model4.text = "医保查询"
        model4.image = UIImage(named: "ybcx")
        toolArray.append(model1)
        toolArray.append(model2)
        toolArray.append(model3)
        toolArray.append(model4)
        
    }
    
    func selfQuery(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.selfQuery(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<SelfQueryDataModel>().map(JSONObject: result)
                if model != nil{
                    self.selfQueryIsSuccess = true
                    self.model = model
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
