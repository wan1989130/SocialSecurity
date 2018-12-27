//
//  GetWriteCountDataModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/27.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class GetWriteCountDataModel: BaseModel {
    var data:GetWriteCountItemModel = GetWriteCountItemModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class GetWriteCountItemModel:BaseModel{
    var maxCount = ""
    var nowCount = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        maxCount    <- (map["maxCount"],transfromOfCustomFunction())
        nowCount    <- (map["nowCount"],transfromOfCustomFunction())
    }
}
