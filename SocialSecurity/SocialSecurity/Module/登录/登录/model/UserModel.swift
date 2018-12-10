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
    var loginName = ""//loginName
    var companyId = ""//companyId
    
     var userId = ""
    var loginPwd = ""
    var status:UserStatus = .error
        var userType:UserType = .error  //用户角色
    var phoneNum:String = ""//电话号
    
    var enterpriseId = ""//企业id
    var token:String = "" //认证标识
    var enterpriseStatus:UserStatus = .error
    var dnid:Int64 = -1
    override func mapping(map: Map) {
        super.mapping(map: map)
         name      <- map["name"]
        companyId      <- map["companyId"]
        userId       <- map["userId"]
        loginPwd   <- map["loginPwd"]
        status      <- map["status"]
        userType       <- map["userType"]
        phoneNum       <- map["loginTel"]
         enterpriseId       <- map["enterpriseId"]
        token       <- map["token"]
        enterpriseStatus       <- map["enterpriseStatus"]
        loginName       <- map["loginName"]
        dnid       <- map["dnid"]
        
    }
    func toNSObject() -> UserNSObjectModel{
        let newObj = UserNSObjectModel()
        newObj.id = self.id
        newObj.name = self.name
        newObj.userId = self.userId
        newObj.loginPwd = self.loginPwd
        newObj.status = self.status
                newObj.userType = self.userType
        newObj.phoneNum = self.phoneNum
        newObj.token = self.token

        
        newObj.enterpriseStatus = self.enterpriseStatus
        newObj.enterpriseId = self.enterpriseId
           newObj.userId = self.userId
        newObj.dnid = self.dnid
        newObj.loginName = self.loginName
        newObj.companyId = self.companyId
  
       
        
        return newObj
    }
    
    
    
}
class UserNSObjectModel: NSObject,NSCoding {
    var id = ""
    var name = ""
    var userId = ""
    var loginPwd = ""
    var status:UserStatus = .error
    var userType:UserType = .error  //用户角色
    var phoneNum:String = ""//电话号
    var loginName = ""//用户姓名
    var companyId = ""//
    var enterpriseId = ""//企业id
    var token:String = ""
    var enterpriseStatus:UserStatus = .error
    var dnid:Int64 = -1
    override init() {
        super.init()
    }
    
    
    func toAnyObject() -> UserModel{
        let newObj = UserModel()
        newObj.id = self.id
        newObj.name = self.name
        newObj.userId = self.userId
        newObj.loginPwd = self.loginPwd
        newObj.status = self.status
        newObj.userType = self.userType
        newObj.phoneNum = self.phoneNum
        newObj.token = self.token
        newObj.enterpriseStatus = self.enterpriseStatus
        newObj.enterpriseId = self.enterpriseId
        newObj.userId = self.userId
        newObj.dnid = self.dnid
        newObj.loginName = self.loginName
        newObj.companyId = self.companyId
        
        return newObj
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(loginPwd, forKey: "loginPwd")
        aCoder.encode(status.rawValue, forKey: "status")
        aCoder.encode(userType.rawValue, forKey: "userType")
        aCoder.encode(phoneNum, forKey: "phoneNum")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(enterpriseStatus.rawValue, forKey: "enterpriseStatus")
        aCoder.encode(enterpriseId, forKey: "enterpriseId")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(dnid, forKey: "dnid")
        aCoder.encode(loginName, forKey: "loginName")
        aCoder.encode(companyId, forKey: "companyId")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") == nil ? "" : aDecoder.decodeObject(forKey: "id") as! String
        name = aDecoder.decodeObject(forKey: "name") == nil ? "" : aDecoder.decodeObject(forKey: "name") as! String
        
        userId = aDecoder.decodeObject(forKey: "userId") == nil ? "" : aDecoder.decodeObject(forKey: "userId") as! String
           loginPwd = aDecoder.decodeObject(forKey: "loginPwd") == nil ? "" : aDecoder.decodeObject(forKey: "loginPwd") as! String
           status = aDecoder.decodeObject(forKey: "status") == nil ? .error : UserStatus(rawValue: aDecoder.decodeObject(forKey: "status") as! String)!
        let tempuserTypeDesc:Int32 = aDecoder.decodeInt32(forKey: "userType")
       
        let tempType = UserType(rawValue: Int(tempuserTypeDesc))
        userType = tempType == nil ? .error : tempType!
        
        phoneNum = aDecoder.decodeObject(forKey: "phoneNum") == nil ? "" : aDecoder.decodeObject(forKey: "phoneNum") as! String
         loginName = aDecoder.decodeObject(forKey: "loginName") == nil ? "" : aDecoder.decodeObject(forKey: "loginName") as! String
        companyId = aDecoder.decodeObject(forKey: "companyId") == nil ? "" : aDecoder.decodeObject(forKey: "companyId") as! String
         enterpriseId = aDecoder.decodeObject(forKey: "enterpriseId") == nil ? "" : aDecoder.decodeObject(forKey: "enterpriseId") as! String
         token = aDecoder.decodeObject(forKey: "token") == nil ? "" : aDecoder.decodeObject(forKey: "token") as! String
        enterpriseStatus = aDecoder.decodeObject(forKey: "enterpriseStatus") == nil ? .error : UserStatus(rawValue: aDecoder.decodeObject(forKey: "enterpriseStatus") as! String)!
        dnid = aDecoder.decodeInt64(forKey: "dnid")
        
    }
}

