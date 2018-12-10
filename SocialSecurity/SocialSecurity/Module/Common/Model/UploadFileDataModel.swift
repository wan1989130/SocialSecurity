//
//  UploadFileDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/28.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class UploadFileDataModel: BaseModel {
    var data:Array<UploadFileModel> = [UploadFileModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["results"]
        msg      <- map["megs"]
    }
}
class UploadFileModel:BaseModel{
    var accessPath = ""
    var originalFileName = ""
    var realFileName = ""
    var size = ""
    var thumbnailPath = ""
    var thumbSize = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        accessPath    <- map["accessPath"]
        originalFileName    <- map["originalFileName"]
        realFileName    <- map["realFileName"]
        size    <- map["size"]
        thumbnailPath    <- map["thumbPath"]
        thumbSize   <- map["thumbSize"]
    }
}
