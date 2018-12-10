//
//  ShowStudentOrSchoolSubmitDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class ShowStudentOrSchoolSubmitDataModel: BaseModel {
    var data:ShowStudentOrSchoolSubmitModel = ShowStudentOrSchoolSubmitModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}

class ShowStudentOrSchoolSubmitModel: BaseModel {
    var loginTel = ""
    var pwd = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        loginTel    <- map["loginTel"]
        pwd    <- map["pwd"]
    }
}
