//
//  PersonRegisterSuccessDataModel.swift
//  Logistics
//
//  Created by 王岩 on 2018/6/8.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class PersonRegisterSuccessDataModel: BaseModel {
    var data:PersonRegisterSuccessModel!
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class PersonRegisterSuccessModel:BaseModel{
    var dnid:Int?
    var userId = ""
    var userName = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        dnid    <- map["dnid"]
        userId    <- map["userId"]
        userName    <- map["loginName"]
    }
}
