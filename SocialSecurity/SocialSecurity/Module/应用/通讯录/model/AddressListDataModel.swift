//
//  SelectMultipleStudentDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/31.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class AddressListDataModel: BaseModel{
    var data:Array<AddressListModel> = [AddressListModel]()
    override func mapping(map: Map) {
        data    <- map["obj"]
    }
}


class AddressListModel: BaseModel {
    var phone = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        phone <- map["phone"]
       
        
    }
}
