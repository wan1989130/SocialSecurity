//
//  CompanyRegisterSuccessDataModel.swift
//  Logistics
//
//  Created by 王岩 on 2018/6/8.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class CompanyRegisterSuccessDataModel: BaseModel {
    var data:CompanyRegisterSuccessModel!
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class CompanyRegisterSuccessModel:BaseModel{
    var dnid:Int?
    var enterpriseStatus:UserStatus = .error
    override func mapping(map: Map) {
        super.mapping(map: map)
        dnid    <- map["dnid"]
        enterpriseStatus    <- map["enterpriseStatus"]
    }
}
