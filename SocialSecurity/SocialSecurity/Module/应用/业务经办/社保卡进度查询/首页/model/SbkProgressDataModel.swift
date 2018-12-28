//
//  SbkProgressDataModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SbkProgressDataModel: BaseModel {
    var data = [SbkProgressItemModel]()
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
class SbkProgressItemModel:BaseModel{
    //name姓名
    var zhengjianNum = ""
    var status = ""
    var statusMsg = ""
    var remark = ""
    var type = ""//类型0个人办理1亲属代办
    override func mapping(map: Map) {
        super.mapping(map: map)
        zhengjianNum <- map["zhengjianNum"]
        status <- map["status"]
        statusMsg <- map["statusMsg"]
        remark <- map["remark"]
        type <- map["type"]
    }
}
