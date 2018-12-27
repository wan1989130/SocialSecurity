//
//  LoginModel.swift
//  SwiftBaseProject
//
//  Created by 王岩 on 2017/6/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation
import ObjectMapper


class LoginModel: BaseModel{
    var data:UserModel!
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
