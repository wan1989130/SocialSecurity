//
//  GetUrlsDataModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/2/18.
//  Copyright © 2019年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class GetUrlsDataModel: BaseModel {
    var data:GetUrlsModel = GetUrlsModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class GetUrlsModel:BaseModel{
    var shebaoUrl = ""
    var zhikajinduUrl = ""
    var yibaoUrl:String = ""//
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        shebaoUrl       <- map["shebaoUrl"]
        zhikajinduUrl   <- map["zhikajinduUrl"]
        yibaoUrl      <- map["yibaoUrl"]
    }

}
