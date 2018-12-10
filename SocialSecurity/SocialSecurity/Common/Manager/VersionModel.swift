//
//  VersionModel.swift
//  Logistics
//
//  Created by 王岩 on 2018/6/22.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper

class VersionDataModel: BaseModel {
    var data:VersionModel = VersionModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class VersionModel: BaseModel {
    var updateStatus = ""
    var versionDesc = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        updateStatus <- map["updateStatus"]
        versionDesc <- map["versionDesc"]
    }
}
