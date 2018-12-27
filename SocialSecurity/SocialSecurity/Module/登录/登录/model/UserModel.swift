//
//  UserModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation
import ObjectMapper

enum UserType:Int{
    case error = 0
    case platform = 1//平台用户
    case administrator = 2//物流公司管理员
    case employee = 3//物流公司员工
    case driver = 4//司机
}
enum UserStatus:String{
    case error = "error"
    case pending = "1"//申请待审核
    case normal = "2"//正常
    case refer = "3"//审核未通过
    case cancel = "4"//注销
}


class UserModel: BaseModel {
    //name登录名称
    var phone = ""//loginName
    var headPhoto = ""//companyId
     var shebaoUrl = ""
    var zhikajinduUrl = ""
    var yibaoUrl:String = ""//
    var userName = ""//企业id
    var userType:UserType = .error  //用户角色
    var token:String = "" //认证标识
    override func mapping(map: Map) {
        super.mapping(map: map)
         phone      <- map["phone"]
        headPhoto      <- map["headPhoto"]
        shebaoUrl       <- map["shebaoUrl"]
        zhikajinduUrl   <- map["zhikajinduUrl"]
        yibaoUrl      <- map["yibaoUrl"]
        userName       <- map["userName"]
        userType       <- map["userType"]
        token       <- map["token"]
        
    }
    func toNSObject() -> UserNSObjectModel{
        let newObj = UserNSObjectModel()
        newObj.id = self.id
        newObj.name = self.name
        newObj.phone = self.phone
        newObj.headPhoto = self.headPhoto
        newObj.shebaoUrl = self.shebaoUrl
                newObj.zhikajinduUrl = self.zhikajinduUrl
        newObj.yibaoUrl = self.yibaoUrl
        newObj.userName = self.userName
        newObj.userType = self.userType
        newObj.token = self.token


      



        return newObj
    }
    
    
    
}
class UserNSObjectModel: NSObject,NSCoding {
    var id = ""
    var name = ""
    var phone = ""//loginName
    var headPhoto = ""//companyId
    var shebaoUrl = ""
    var zhikajinduUrl = ""
    var yibaoUrl:String = ""//
    var userName = ""//企业id
    var userType:UserType = .error  //用户角色
    var token:String = "" //认证标识
    override init() {
        super.init()
    }
    func toAnyObject() -> UserModel{
        let newObj = UserModel()
        newObj.id = self.id
        newObj.name = self.name
        newObj.phone = self.phone
        newObj.headPhoto = self.headPhoto
        newObj.shebaoUrl = self.shebaoUrl
        newObj.zhikajinduUrl = self.zhikajinduUrl
        newObj.yibaoUrl = self.yibaoUrl
        newObj.userName = self.userName
        newObj.userType = self.userType
        newObj.token = self.token
        
        return newObj
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(headPhoto, forKey: "headPhoto")
        aCoder.encode(shebaoUrl, forKey: "shebaoUrl")
        aCoder.encode(zhikajinduUrl, forKey: "zhikajinduUrl")
        aCoder.encode(yibaoUrl, forKey: "yibaoUrl")
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(userType.rawValue, forKey: "userType")
        aCoder.encode(token, forKey: "token")
      
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") == nil ? "" : aDecoder.decodeObject(forKey: "id") as! String
        name = aDecoder.decodeObject(forKey: "name") == nil ? "" : aDecoder.decodeObject(forKey: "name") as! String
        
        phone = aDecoder.decodeObject(forKey: "phone") == nil ? "" : aDecoder.decodeObject(forKey: "phone") as! String
           headPhoto = aDecoder.decodeObject(forKey: "headPhoto") == nil ? "" : aDecoder.decodeObject(forKey: "headPhoto") as! String
        shebaoUrl = aDecoder.decodeObject(forKey: "shebaoUrl") == nil ? "" : aDecoder.decodeObject(forKey: "shebaoUrl") as! String
         zhikajinduUrl = aDecoder.decodeObject(forKey: "zhikajinduUrl") == nil ? "" : aDecoder.decodeObject(forKey: "zhikajinduUrl") as! String
        yibaoUrl = aDecoder.decodeObject(forKey: "yibaoUrl") == nil ? "" : aDecoder.decodeObject(forKey: "yibaoUrl") as! String
         userName = aDecoder.decodeObject(forKey: "userName") == nil ? "" : aDecoder.decodeObject(forKey: "userName") as! String
        
        let tempuserTypeDesc:Int32 = aDecoder.decodeInt32(forKey: "userType")
        let tempType = UserType(rawValue: Int(tempuserTypeDesc))
        userType = tempType == nil ? .error : tempType!
        token = aDecoder.decodeObject(forKey: "token") == nil ? "" : aDecoder.decodeObject(forKey: "token") as! String
        
    }
}

