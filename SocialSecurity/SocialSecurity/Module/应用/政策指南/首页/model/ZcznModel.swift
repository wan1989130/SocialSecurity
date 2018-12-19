//
//  ZcznModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class ZcznModel: BaseModel {
    var text:String! //名称
    var image:UIImage! //图标
    override init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map)
    }
}
