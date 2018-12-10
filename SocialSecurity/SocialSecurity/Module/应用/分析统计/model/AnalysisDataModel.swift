//
//  InformationMessageDataModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class AnalysisDataModel: BaseModel {
    var data:AnalysisModel = AnalysisModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["obj"]
    }
}

class AnalysisModel: BaseModel {
    
    var sumNum = 0
    var arrayDatas = [Double]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        sumNum <- map["sumNum"]
        arrayDatas <- map["arrayDatas"]
        
        
        
        
    }
    
}
