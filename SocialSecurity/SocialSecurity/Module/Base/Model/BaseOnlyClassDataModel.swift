//
//  BaseOnlyClassDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/13.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class BaseOnlyClassDataModel: BaseModel {
    var data:BaseOnlyClassListModel = BaseOnlyClassListModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
    
}

class BaseOnlyClassListModel: BaseModel {

    var lists:Array<BaseOnlyClassItemModel> = [BaseOnlyClassItemModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id    <- (map["defaultId"],transfromOfCustomFunction())
        name    <- map["defaultName"]
        lists    <- map["classList"]
    }
    var currentClassIndex:Int{
        get{
            if lists.count <= 0 {
                return -1
            }
            else{
                for i in 0..<lists.count{
                    if self.id == lists[i].id{
                        return i
                    }
                }
                return -1
            }
        }
        set{
            
            if newValue >= 0 && newValue < lists.count{
                id = lists[newValue].id
                name = lists[newValue].name
                
            }
        }
    }
    
}
class BaseOnlyClassItemModel: BaseModel {

    var classCode = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        id    <- (map["classId"],transfromOfCustomFunction())
        name    <- map["className"]
        classCode    <- map["classCode"]
    }
    
}
