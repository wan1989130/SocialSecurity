//
//  OcrDataModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/22.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class OcrDataModel: BaseModel {
    var data:OcrModel = OcrModel()
    override func mapping(map: Map) {
        data    <- map["data"]
    }
}
class OcrModel:BaseModel{
    var message:OcrMessageModel = OcrMessageModel()
    var cardsinfo:OcrCardInfoModel = OcrCardInfoModel()
    override func mapping(map: Map) {
        message    <- map["message"]
        cardsinfo    <- map["cardsinfo"]
    }
    
}
class OcrMessageModel:BaseModel{
    var status = -1
    var value = ""
    override func mapping(map: Map) {
        status    <- map["status"]
        value    <- map["value"]
    }
}
class OcrCardInfoModel:BaseModel{
    var card:OcrCardModel = OcrCardModel()
    override func mapping(map: Map) {
        card    <- map["card"]
        
    }
}
class OcrCardModel:BaseModel{
    var type = -1
    var item:Array<OcrCardItemModel> = [OcrCardItemModel]()
    override func mapping(map: Map) {
        type    <- map["type"]
        item    <- map["item"]
        
    }
}
class OcrCardItemModel:BaseModel{
    var content = ""
    var desc = ""
    override func mapping(map: Map) {
        content    <- map["content"]
        desc    <- map["desc"]
        
    }
    
}
