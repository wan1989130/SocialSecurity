//
//  SelectMultipleStudentDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/31.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class SelectMultipleStudentDataModel: BaseModel{
    var data:Array<SelectMultipleStudentModel> = [SelectMultipleStudentModel]()
    override func mapping(map: Map) {
        data    <- map["data"]
    }
}


class SelectMultipleStudentModel: BaseModel {
    var studentNo:String = ""       //学号
    var portrait:String = ""
    var isSelected:Bool = false     //是否被选中
    var schId:String = ""     //学校id
    var stuAlias = ""//别名
    var stuJp = ""//姓名简拼
    
    override init() {
        super.init()
    }
    
    init(name:String, no:String){
        super.init()
        studentNo = no
        self.name = name
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id    <- (map["stuId"],transfromOfCustomFunction())
        name        <- map["stuName"]
        studentNo   <- map["stuNo"]
        portrait    <- map["iconUrl"]
        schId    <- (map["schId"],transfromOfCustomFunction())
        stuAlias    <- map["stuAlias"]
        stuJp    <- map["stuJp"]
        isSelected    <- map["isSelected"]
        
    }
    
    func toNSObject() -> ObjcSelectMultipleStudentModel{
        let newObj = ObjcSelectMultipleStudentModel()
        newObj.id           = self.id
        newObj.name         = self.name
        newObj.studentNo    = self.studentNo
        newObj.isSelected   = self.isSelected
        newObj.portrait     = self.portrait
        newObj.schId     = self.schId
        newObj.stuAlias     = self.stuAlias
        newObj.stuJp     = self.stuJp
        
        return newObj
    }
}

class ObjcSelectMultipleStudentModel: NSObject{
    var id = ""
    var name = ""
    var studentNo:String = ""       //学号
    var isSelected:Bool = false     //是否被选中
    var portrait:String = ""
    var schId:String = ""     //学校id
    var stuAlias = ""//别名
    var stuJp = ""//姓名简拼
    
    func toAnyObject() ->SelectMultipleStudentModel{
        let model = SelectMultipleStudentModel()
        model.id            = self.id
        model.name          = self.name
        model.studentNo     = self.studentNo
        model.isSelected    = self.isSelected
        model.portrait      = self.portrait
        model.schId      = self.schId
        model.stuAlias      = self.stuAlias
        model.stuJp      = self.stuJp
        return model
    }
    
}
