//
//  AnalysisDataController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class AnalysisDataController: BaseDataController {

    
    var model:AnalysisDataModel = AnalysisDataModel()
    var dataArray:Array<Double> = [Double]()
    var lastPage = -1
    //查询所有单位名称
    func goodsStatistics(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.goodsStatistics(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<AnalysisDataModel>().map(JSONObject: result)!
                self.dataArray = self.model.data.arrayDatas
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    
}
