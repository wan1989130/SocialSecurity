//
//  PersonMessageSuccessDataModel.swift
//  Logistics
//
//  Created by 王岩 on 2018/6/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class PersonMessageSuccessDataModel: BaseModel {
    var data:PersonMessageSuccessModel!
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class PersonMessageSuccessModel:BaseModel{
    var status:UserStatus = .error
    var userName = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        status    <- map["status"]
        userName    <- map["userName"]
    }
}
