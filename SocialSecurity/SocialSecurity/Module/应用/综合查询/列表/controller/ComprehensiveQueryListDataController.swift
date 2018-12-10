//
//  ComprehensiveQueryListDataController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class ComprehensiveQueryListDataController: BaseDataController {
    var model:ComprehensiveQueryListDataModel = ComprehensiveQueryListDataModel()
        var dataArray:Array<ComprehensiveQueryListModel> = [ComprehensiveQueryListModel]()
    
    
    
    //获取发货信息列表与统计分析钻取页共用
    func shippingList(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.shippingList(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<ComprehensiveQueryListDataModel>().map(JSONObject: result)!
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
