//
//  RemarkModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/13.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class RemarkModel: BaseModel {
    var autoId = 0
    var time = ""//日期
    var loginName = ""//用户名
    var content = ""//内容
    var showTime = ""
    override func mapping(map: Map) {
        time    <- map["time"]
        loginName    <- map["loginName"]
        content    <- map["content"]
        showTime    <- map["showTime"]
        
    }
}
class RemarkDataModel: BaseModel {
    var data:Array<RemarkModel> = [RemarkModel]()
    override func mapping(map: Map) {
        data    <- map["data"]
    }
}
