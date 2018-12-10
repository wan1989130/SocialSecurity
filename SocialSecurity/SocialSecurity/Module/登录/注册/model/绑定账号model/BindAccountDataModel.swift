//
//  BindAccountDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class BindAccountDataModel: BaseModel {
    var data:BindAccountModel = BindAccountModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
    
}
class BindAccountModel: BaseModel {
    
    


    
    var phone = ""
    var verCode = ""
    
    var pwd = ""
 
    
    
    var userId = ""
    var orgId = ""
    var userType:UserType = .error
    var schoolList:Array<SchoolModel> = [SchoolModel]()
    var studentList:Array<BindAccountStudentModel> = [BindAccountStudentModel]()
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userId    <- map["userId"]
        userType    <- map["userType"]
        schoolList    <- map["schoolList"]
        studentList    <- map["studentList"]
        orgId    <- map["orgId"]
    }
}
class BindAccountStudentModel: BaseModel {
    var isSelected:String = "0"//0未选中
    var schoolName = ""
    var gradeClassName = ""
    var headUrl = ""
    var stuNo = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        schoolName    <- map["schoolName"]
        gradeClassName    <- map["gradeClassName"]
        headUrl    <- map["headUrl"]
        stuNo    <- map["stuNo"]
    }
}
