//
//  CaijiSaveModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/20.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper

class CaijiSaveModel: BaseModel {
    //name 姓名
    var sex = ""
    var zjlx = ""//证件类型
    var zjhm = ""//证件号码
    var csrq = ""//出生日期
    var zjyxq = ""//证件有效期
    var mz = ""//民族
    var txdz = ""//通信地址
    override func mapping(map: Map) {
        super.mapping(map: map)
        sex <- map["sex"]
        zjlx <- map["zjlx"]
        zjhm <- map["zjhm"]
        csrq <- map["csrq"]
        zjyxq <- map["zjyxq"]
        mz <- map["mz"]
        txdz <- map["txdz"]
        
        
        
    }
   
}
