//
//  ApplyModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper


class ApplyModel: BaseModel {
    
    var data:Array<ApplyToolModel> = [ApplyToolModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}


class ApplyToolModel: BaseModel {
    
    var text:String! //工具包名称
    var image:UIImage! //工具包图标
    override init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map)
    }
   
    
}
