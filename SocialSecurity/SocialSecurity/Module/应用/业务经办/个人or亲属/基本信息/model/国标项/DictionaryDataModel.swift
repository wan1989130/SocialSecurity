//
//  DictionaryDataModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/27.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class DictionaryDataModel: BaseModel {
    var data = DictionaryItemModel()
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
class DictionaryItemModel: BaseModel {
    var ryztMap = [DictionaryModel]()//人员状态
    var hjxzMap = [DictionaryModel]()//户籍性质
    var xbMap = [DictionaryModel]()//性别
    var zjlxMap = [DictionaryModel]()//证件类型  监护人证件类型
    var zszyMap = [DictionaryModel]()//专属职业
    var gjMap = [DictionaryModel]()//国籍
    var zshyMap = [DictionaryModel]()//专属行业
    var mzMap = [DictionaryModel]()//民族
    var klmyhMap = [DictionaryModel]()//卡联名银行
    
    
    
    
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        ryztMap <- map["ryztMap"]
        hjxzMap <- map["hjxzMap"]
        xbMap <- map["xbMap"]
        
        zjlxMap <- map["zjlxMap"]
        mzMap <- map["mzMap"]
        
        gjMap <- map["gjMap"]
        
        klmyhMap <- map["klmyhMap"]
        zszyMap <- map["zszyMap"]
        zshyMap <- map["zshyMap"]
        
    }
}
class DictionaryModel:BaseModel{
    var isSelect = false
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
         isSelect <- map["isSelect"]
    }
}
