//
//  IsScanQueryDataModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/27.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class IsScanQueryDataModel: BaseModel {
    var data = IsScanQueryModel()
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
        
        
        
    }
}
class IsScanQueryModel:BaseModel{
    var isCan = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        isCan <- map["isCan"]
       
        
        
        
    }
}
