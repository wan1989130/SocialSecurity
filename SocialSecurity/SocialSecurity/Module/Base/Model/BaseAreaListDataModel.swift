//
//  BaseAreaListDataModel.swift
//  MiddleSchool2
//
//  Created by 李琪 on 2017/12/21.
//  Copyright © 2017年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class BaseAreaListDataModel: BaseModel {
    var list:Array<BaseAreaListModel> = [BaseAreaListModel]()
    
    override func mapping(map: Map) {
        list <- map["data"]
    }
}

class BaseAreaListModel: BaseModel {
    var serviceUrl = ""
    var isSelected:Bool = false
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["serviceId"]
        name <- map["serviceName"]
        serviceUrl <- map["serviceUrl"]
        if serviceUrl.hasSuffix("/"){
            
        }else{
            serviceUrl += "/"
        }
        
    }
}
