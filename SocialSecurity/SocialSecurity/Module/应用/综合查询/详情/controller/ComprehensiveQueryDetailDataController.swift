//
//  ComprehensiveQueryDetailDataController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/14.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class ComprehensiveQueryDetailDataController: BaseDataController {
    var model:ComprehensiveQueryDetailDataModel = ComprehensiveQueryDetailDataModel()
    var id = ""
    //查询发货单详情
    func shippingDetail(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.shippingDetail(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<ComprehensiveQueryDetailDataModel>().map(JSONObject: result)!
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
