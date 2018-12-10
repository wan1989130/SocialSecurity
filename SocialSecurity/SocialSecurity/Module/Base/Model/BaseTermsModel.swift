//
//  BaseTermsModel.swift
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
class BaseTermsDataModel: BaseModel {
    var terms:Array<BaseTermModel> = []
    
    var currentIndex:Int{
        get{
            if terms.count <= 0 {
                return -1
            }
            else{
                for i in 0..<terms.count{
                    if self.id == terms[i].id{
                        return i
                    }
                }
                return -1
            }
        }
        set{
            if newValue >= 0 && newValue < terms.count{
                id = terms[newValue].id
                name = terms[newValue].name
            }
            else{
                id = ""
                name = ""
            }
        }
    }
    
    var termId:String{
        get{
            if currentIndex < 0{
                return ""
            }
            else{
                return terms[currentIndex].id
            }
        }
    }
    
    var termName:String{
        get{
            if currentIndex < 0{
                return ""
            }
            else{
                return terms[currentIndex].name
            }
        }
    }
    
    var termCode:String{
        get{
            if currentIndex < 0{
                return ""
            }
            else{
                return terms[currentIndex].termCode
            }
        }
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
        
        if dataDic["defaultId"] != nil && !(dataDic["defaultId"] is NSNull){
            id = String(dataDic["defaultId"] as! Int64)
        }
        if dataDic["defaultName"] != nil && !(dataDic["defaultName"] is NSNull){
            name = dataDic["defaultName"] as! String
        }
        if dataDic["lists"] != nil && !(dataDic["lists"] is NSNull){
            let termList = dataDic["lists"] as! NSArray
            for item in termList{
                let termModel = Mapper<BaseTermModel>().map(JSONObject: item)
                if termModel != nil{
                    terms.append(termModel!)
                }
            }
        }
    }
}

class BaseTermModel:BaseModel{
    var termCode:String = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        id      <- (map["termId"],transfromOfCustomFunction())
        name    <- map["termName"]
        termCode <- map["termCode"]

    }
}
