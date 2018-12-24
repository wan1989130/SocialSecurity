//
//  IdCardModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class IdCardFrontModel: BaseModel {
    var words_result_num = ""//识别结果数，表示words_result的元素个数
    var words_result = IdCardKeyModel()

    override func mapping(map: Map) {
        super.mapping(map: map)
        words_result_num <- map["words_result_num"]
        words_result <- map["words_result"]
   
        
        
        
    }
}
class IdCardKeyModel:BaseModel{
    var nameModel = IdCardWordsModel()
    var csrqModel = IdCardWordsModel()
    var sfzhModel = IdCardWordsModel()
    var sexModel = IdCardWordsModel()
    var zzModel = IdCardWordsModel()
    var mzModel = IdCardWordsModel()
    
    //背面用
    var qfjgModel = IdCardWordsModel()
    var sxrqModel = IdCardWordsModel()
    var qfrqModel = IdCardWordsModel()
    override func mapping(map: Map) {
        super.mapping(map: map)
        nameModel <- map["姓名"]
        csrqModel <- map["出生"]
        sfzhModel <- map["公民身份号码"]
        sexModel <- map["性别"]
        zzModel <- map["住址"]
        mzModel <- map["民族"]
        
        qfjgModel <- map["签发机关"]
        sxrqModel <- map["失效日期"]
        qfrqModel <- map["签发日期"]
    }
}
class IdCardWordsModel:BaseModel{
    var words = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        words <- map["words"]
    }
}
