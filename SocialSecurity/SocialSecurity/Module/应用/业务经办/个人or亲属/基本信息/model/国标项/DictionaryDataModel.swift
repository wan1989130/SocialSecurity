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
    var data = IsScanQueryModel()
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
class DictionaryItemModel: BaseModel {
    var xbMap = [DictionaryModel]()
    var zjlxMap = [DictionaryModel]()
    var mzMap = [DictionaryModel]()
    var ryztMap = [DictionaryModel]()
    var gjMap = [DictionaryModel]()
    var hjxzMap = [DictionaryModel]()
    var klmyhMap = [DictionaryModel]()
    var zszyMap = [DictionaryModel]()
    var zshyMap = [DictionaryModel]()
    var jhrzjlxMap = [DictionaryModel]()
    override func mapping(map: Map) {
        super.mapping(map: map)
        xbMap <- map["xbMap"]
        zjlxMap <- map["zjlxMap"]
        mzMap <- map["mzMap"]
        ryztMap <- map["ryztMap"]
        gjMap <- map["gjMap"]
        hjxzMap <- map["hjxzMap"]
        klmyhMap <- map["klmyhMap"]
        zszyMap <- map["zszyMap"]
        zshyMap <- map["zshyMap"]
        jhrzjlxMap <- map["jhrzjlxMap"]
    }
}
class DictionaryModel:BaseModel{
    var isSelect = false
    override func mapping(map: Map) {
        super.mapping(map: map)
        
    }
}
