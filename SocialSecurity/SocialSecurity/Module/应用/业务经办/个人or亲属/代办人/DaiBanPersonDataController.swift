//
//  DaiBanPersonDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class DaiBanPersonDataController: BaseDataController {
    var type = ""//0录入1修改
    var saveModel:CaijiSaveModel!
    var dictionaryModel:DictionaryDataModel!
    
    func addOrUpdate(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.addOrUpdate(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
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
