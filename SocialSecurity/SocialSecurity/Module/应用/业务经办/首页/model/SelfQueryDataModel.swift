//
//  SelfQueryDataModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/27.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SelfQueryDataModel: BaseModel {
    var data:SelfQueryItemModel = SelfQueryItemModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class SelfQueryItemModel:BaseModel{
    var status = ""
    var statusMsg = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        status    <- map["status"]
        statusMsg    <- map["statusMsg"]
    }
}
