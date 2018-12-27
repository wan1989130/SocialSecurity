//
//  UploadFileSocialSecurityDataModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/27.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class UploadFileSocialSecurityDataModel: BaseModel {
    var data = UploadFileSocialSecurityModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
        
    }
}
class UploadFileSocialSecurityModel:BaseModel{
    var imageUrl = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        imageUrl    <- map["imageUrl"]
        
    }
}
