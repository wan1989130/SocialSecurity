//
//  BaseClassesModel.swift
//  SeniorHighSchoolProject
//
//  Created by 李琪 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
/**
 * 数据解析Model
 */
class BaseClassesDataModel: BaseModel {
    //name:完整的当前选中的班级名
    var gradeId:String = ""     //当前年级ID
    var gradeName:String = ""   //当前年级名
    var gradeCode:String = ""   //当前年级Code
    var classId:String = ""     //当前班级ID
    var className:String = ""   //当前班级名
    var classCode:String = ""   //当前班级Code
    var grades:Array<BaseGradeModel> = [BaseGradeModel]()
    
    
    var currentGradeIndex:Int{
        get{
            if grades.count <= 0 {
                return -1
            }
            else{
                for i in 0..<grades.count{
                    if self.gradeId == grades[i].id{
                        return i
                    }
                }
                return -1
            }
        }
        set{
            
            if newValue >= 0 && newValue < grades.count{
                resetGrade()
                gradeId = grades[newValue].id
                gradeName = grades[newValue].name
                gradeCode = grades[newValue].gradeCode
                if grades[newValue].classes.count > 0{
                    classId = grades[newValue].classes[0].id
                    className = grades[newValue].classes[0].name
                    classCode = grades[newValue].classes[0].classCode
                }
                
            }
        }
    }
    
    var currentClassIndex:Int{
        get{
            if currentGradeIndex < 0 {
                return -1
            }
            else{
                let targetClasses = grades[currentGradeIndex].classes
                for i in 0..<targetClasses.count{
                    if self.classId == targetClasses[i].id{
                        return i
                    }
                }
                return -1
            }
        }
        set{
            
            if newValue >= 0 && newValue < grades[currentGradeIndex].classes.count{
                resetClass()
                classId = grades[currentGradeIndex].classes[newValue].id
                className = grades[currentGradeIndex].classes[newValue].name
                classCode = grades[currentGradeIndex].classes[newValue].classCode
            }
        }
    }
    
    func resetGrade(){
        gradeId = ""
        gradeName = ""
        gradeCode = ""
        name = ""
    }
    
    func resetClass(){
        classId = ""
        className = ""
        classCode = ""
        name = ""
    }
    
    
    
    override func mapping(map: Map) {
        code    <- map["code"]
        msg     <- map["msg"]
        
        let dataMapDic = map["data"].JSON as NSDictionary
        let tempDic = dataMapDic["data"]
        if tempDic == nil{
            return
        }
        let dataDic = tempDic as! NSDictionary
        
        if dataDic["defaultGradeId"] != nil && !(dataDic["defaultGradeId"] is NSNull){
            gradeId = String(dataDic["defaultGradeId"] as! Int64)
        }
        if dataDic["defaultGradeName"] != nil && !(dataDic["defaultGradeName"] is NSNull) {
            gradeName = dataDic["defaultGradeName"] as! String
        }
        if dataDic["defaultClassId"] != nil && !(dataDic["defaultClassId"] is NSNull){
            classId = String(dataDic["defaultClassId"] as! Int64)
        }
        if dataDic["defaultClassName"] != nil && !(dataDic["defaultClassName"] is NSNull){
            className = dataDic["defaultClassName"] as! String
        }
        if dataDic["defaultGradeId"] != nil && !(dataDic["defaultGradeId"] is NSNull){
            name = dataDic["defaultName"] as! String
        }
        else{
            name = gradeName + className
        }
        
        if dataDic["gradeList"] != nil{
            let gradeList = dataDic["gradeList"] as! NSArray
            for item in gradeList{
                let gradeModel = Mapper<BaseGradeModel>().map(JSONObject: item)
                if gradeModel != nil{
                    grades.append(gradeModel!)
                }
            }
        }
        
        for grade in grades{
            if grade.id == gradeId{
                gradeCode = grade.gradeCode
                for classModel in grade.classes{
                    if classModel.id == classId{
                        classCode = classModel.classCode
                        break
                    }
                }
                break
            }
        }
    }
}

class BaseGradeModel: BaseModel{
    var gradeCode:String = ""
    var classes:Array<BaseClassModel> = [BaseClassModel]()
    var flag = false //false折叠
    override func mapping(map: Map) {
        id <- (map["gradeId"] ,transfromOfCustomFunction())
        name <- map["gradeName"]
        gradeCode <- map["gradeCode"]
        classes <- map["classList"]
        
        for classModel in classes{
            classModel.gradeId = id
            classModel.gradeName = name
            classModel.gradeCode = gradeCode
        }
    }
}

class BaseClassModel: BaseModel{
    var gradeId:String = ""
    var gradeName:String = ""
    var gradeCode:String = ""
    var classCode:String = ""
    override func mapping(map: Map) {
        id <- (map["classId"],transfromOfCustomFunction())
        name <- map["className"]
        classCode <- map["classCode"]
    }
}
