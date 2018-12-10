//
//  ConfigDataModel.swift
//  集优化办学
//
//  Created by 王岩 on 2017/10/25.
//  Copyright © 2017年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class ConfigDataModel: BaseModel {
    var data:ConfigModel = ConfigModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class ConfigModel: BaseModel {
    var file_access_host = ""//上传图片路径
    var high_project_name = ""//
    var base_project_name = ""//传头像用这个 work
    var file_upload_url = ""//显示文件
    var base_img_url = ""//基础图片地址
   
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        
        file_access_host       <- map["file_access_host"]
        high_project_name       <- map["high_project_name"]
        base_project_name       <- map["base_project_name"]
        file_upload_url       <- map["file_upload_url"]
        base_img_url       <- map["base_img_url"]
        
        
        
    }
}

