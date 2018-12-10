//
//  UploadPhotoLogisticsDataModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/13.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class UploadPhotoLogisticsDataModel: BaseModel {
    var data = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["obj"]
       
    }
}
