//
//  CaijiBasicDisplayModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/20.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
enum CaijiBasicCellType{
    case name
    case sex
    case zjlx
    case zjhm
    case csrq
    case zjyxq
    case mz
    case txdz
    case error
}
class CaijiBasicDisplayModel: BaseModel {
    var type:CaijiBasicCellType = .error
    var isMust = false
    var isSelect = false
    var key = ""
    var value = ""
    var placeHolder = ""
    init(key:String, value:String,placeHolder:String,type:CaijiBasicCellType,isMust:Bool,isSelect:Bool) {
        super.init()
        self.key = key
        self.value = value
        self.placeHolder = placeHolder
        self.type = type
        self.isMust = isMust
        self.isSelect = isSelect
    }
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
   
}
