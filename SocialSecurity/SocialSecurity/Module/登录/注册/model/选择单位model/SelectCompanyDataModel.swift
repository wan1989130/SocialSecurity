//
//  CarSourceSquareDataModel.swift
//  Logistics
//
//  Created by c on 2018/6/6.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper

class SelectCompanyDataModel: BaseModel {
    var data:Array<SelectCompanyModel> = [SelectCompanyModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["obj"]
    }
}

class SelectCompanyModel: BaseModel {
    
    var isNewRecord = false
    override func mapping(map: Map) {
        super.mapping(map: map)
     
        isNewRecord <- map["isNewRecord"]
        
       
        
    }
    
}
