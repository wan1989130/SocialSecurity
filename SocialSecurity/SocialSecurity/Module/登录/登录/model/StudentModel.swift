//
//  StudentModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation
import ObjectMapper
class StudentModel: BaseModel {
    var stuId:String?  //stuId
    var headUrl:String? //头像地址
    var stuName:String? //学生姓名
    var school:String? //学校名称
    var gradeClassName:String? //年级班级名称

    
    override func mapping(map: Map) {
        super.mapping(map: map)
        stuId      <- (map["stuId"],transfromOfCustomFunction())
        headUrl       <- map["headUrl"]
        stuName       <- map["stuName"]
        school       <- map["school"]
        gradeClassName       <- map["gradeClassName"]
    }
    func toNSObject() -> StudentNSObjectModel{
        let newObj = StudentNSObjectModel()
        
        newObj.stuId = self.stuId
        newObj.headUrl = self.headUrl
        newObj.stuName = self.stuName
        newObj.school = self.school
        newObj.gradeClassName = self.gradeClassName
        
        
        return newObj
    }

}

class StudentNSObjectModel: NSObject,NSCoding {
    var stuId:String?  //stuId
    var headUrl:String? //头像地址
    var stuName:String? //学生姓名
    var school:String? //学校名称
    var gradeClassName:String? //年级班级名称

    override init() {
        super.init()
    }
    
    
    func toAnyObject() -> StudentModel{
        let newObj = StudentModel()
        
        
        newObj.stuId = self.stuId
        newObj.headUrl = self.headUrl
        newObj.stuName = self.stuName
        newObj.school = self.school
        newObj.gradeClassName = self.gradeClassName
        
        return newObj
    }
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(stuId, forKey: "stuId")
        aCoder.encode(headUrl, forKey: "headUrl")
        aCoder.encode(stuName, forKey: "stuName")
        aCoder.encode(school, forKey: "school")
        aCoder.encode(gradeClassName, forKey: "gradeClassName")
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        stuId = aDecoder.decodeObject(forKey: "stuId") == nil ? "" : aDecoder.decodeObject(forKey: "stuId") as! String
        headUrl = aDecoder.decodeObject(forKey: "headUrl") == nil ? "" : aDecoder.decodeObject(forKey: "headUrl") as! String
        stuName = aDecoder.decodeObject(forKey: "stuName") == nil ? "" : aDecoder.decodeObject(forKey: "stuName") as! String
        school = aDecoder.decodeObject(forKey: "school") == nil ? "" : aDecoder.decodeObject(forKey: "school") as! String
        gradeClassName = aDecoder.decodeObject(forKey: "gradeClassName") == nil ? "" : aDecoder.decodeObject(forKey: "gradeClassName") as! String

    }
}
