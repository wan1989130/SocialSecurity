//
//  ZcznDetailDataModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class ZcznDetailDataModel: BaseModel {

    var title:String! //名称
    var url:String! //网址
    override init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map)
    }
}
