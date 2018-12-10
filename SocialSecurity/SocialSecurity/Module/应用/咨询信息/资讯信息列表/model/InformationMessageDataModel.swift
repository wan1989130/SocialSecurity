//
//  InformationMessageDataModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class InformationMessageDataModel: BaseModel {
    var data:Array<InformationMessageModel> = [InformationMessageModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["obj"]
    }
}

class InformationMessageModel: BaseModel {
    
    var isNewRecord = false
    var title = ""
    var createTime = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        isNewRecord <- map["isNewRecord"]
        title <- map["title"]
        createTime <- map["createTime"]
        
        
        
    }
    
}
