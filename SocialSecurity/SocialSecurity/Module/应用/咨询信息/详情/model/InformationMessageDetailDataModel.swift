//
//  InformationMessageDetailDataModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class InformationMessageDetailDataModel: BaseModel {
    var data:InformationMessageDetailModel = InformationMessageDetailModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["obj"]
    }
}
class InformationMessageDetailModel: BaseModel {
    
    var hits = ""//浏览次数
    var isNewRecord = false
    var title = ""
    var createTime = ""
    var content = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        isNewRecord <- map["isNewRecord"]
        title <- map["title"]
        createTime <- map["createTime"]
        content <- map["content"]
        hits <- map["hits"]
        
        
        
    }
    
}
