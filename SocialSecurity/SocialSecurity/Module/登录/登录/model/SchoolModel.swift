//
//  SchoolModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation
import ObjectMapper
class SchoolModel: BaseModel {
    var schoolId:String = ""  //
    var schoolName:String = "" //
    var isSelected:String = "0"
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        schoolId      <- (map["schoolId"],transfromOfCustomFunction())
        schoolName       <- map["schoolName"]
        isSelected       <- map["isSelected"]
        if isSelected == ""{
            isSelected = "0"
        }
        
    }
    func toNSObject() -> SchoolNSObjectModel{
        let newObj = SchoolNSObjectModel()
        
        newObj.schoolId = self.schoolId
        newObj.schoolName = self.schoolName
        newObj.isSelected = self.isSelected
      
        
        
        return newObj
    }
    
}

class SchoolNSObjectModel: NSObject,NSCoding {
    var schoolId:String = ""  //
    var schoolName:String = "" //
    var isSelected:String = "0"
    override init() {
        super.init()
    }
    
    
    func toAnyObject() -> SchoolModel{
        let newObj = SchoolModel()
        newObj.schoolId = self.schoolId
        newObj.schoolName = self.schoolName
        newObj.isSelected = self.isSelected
        
        return newObj
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(schoolId, forKey: "schoolId")
        aCoder.encode(schoolName, forKey: "schoolName")
        aCoder.encode(isSelected, forKey: "isSelected")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        schoolId = aDecoder.decodeObject(forKey: "schoolId") == nil ? "" : aDecoder.decodeObject(forKey: "schoolId") as! String
        schoolName = aDecoder.decodeObject(forKey: "schoolName") == nil ? "" : aDecoder.decodeObject(forKey: "schoolName") as! String

        isSelected = aDecoder.decodeObject(forKey: "isSelected") == nil ? "" : aDecoder.decodeObject(forKey: "isSelected") as! String


    }
}
