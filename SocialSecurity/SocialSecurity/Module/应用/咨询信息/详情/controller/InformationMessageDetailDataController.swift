//
//  InformationMessageDetailDataController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class InformationMessageDetailDataController: BaseDataController {

    var model:InformationMessageDetailDataModel = InformationMessageDetailDataModel()
    //查询所有单位名称
    func informationDetail(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.informationDetail(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<InformationMessageDetailDataModel>().map(JSONObject: result)!
               
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
