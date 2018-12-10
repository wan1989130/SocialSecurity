//
//  NotifyDataModel.swift
//  Logistics
//
//  Created by 王岩 on 2018/6/15.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class NotifyDataModel: BaseModel {

    var data:NotifyModel = NotifyModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
    
}
class NotifyModel:BaseModel{
    var type = ""//1.货源，2.车源
    var sourceId = ""//货源或车源id
    var lineCode = ""//220102-220281
    var isRead = ""//0否1是
    override func mapping(map: Map) {
        super.mapping(map: map)
        type    <- map["type"]
        sourceId    <- map["sourceId"]
        lineCode    <- map["lineCode"]
        isRead    <- map["isRead"]
    }
}
