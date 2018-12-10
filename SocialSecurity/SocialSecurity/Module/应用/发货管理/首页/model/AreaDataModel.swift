//
//  AreaDataModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class AreaDataModel: BaseModel {
    var data:AddressModel = AddressModel()
    override func mapping(map: Map) {
        data    <- map["obj"]
    }
}
