//
//  SendAndGetPersonMessageDataModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/16.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SendAndGetPersonMessageDataModel: BaseModel {
    var data:DeliverGoodsSaveModel = DeliverGoodsSaveModel()
    override func mapping(map: Map) {
        data    <- map["obj"]
    }
}
