//
//  SelectMultipleStudentDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/31.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class ComprehensiveQueryListDataModel: BaseModel{
    var data:Array<ComprehensiveQueryListModel> = [ComprehensiveQueryListModel]()
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["obj"]
    }
}


class ComprehensiveQueryListModel: BaseModel {
    //name 货物名称
    var isNewRecord = false
    var smsNum = ""//物流单号
    var getAName = ""//收货人区域名称
//    var age30 = ""
    var sendPhone = ""//发货人电话
//    var unknownSex = ""
    var sendANameParent = ""//发货人区域父父级名称
    var photo = ""//货物图片（多张图片拼接|/userfiles/…/639612303.jpg|/userfiles/…/c.jpg|…）
    
    var getName = ""//收货人姓名
    var getAid = ""//收货人所属区域
    var getPhone = ""//收货人电话
    var getANameParentP = ""//收货人区域父父级名称
    var getANameParent = ""//收货人区域父级名称
    var remarks = ""//备注
    var sendCard = ""//发货人身份证号码
    var sendCsrq = ""//发货人出生日期
    var sendSex = ""//发货人性别
    var sendMz = ""//发货人民族
    var sendAid = ""//发货人所属区域
    var sendName = ""//发货人姓名
    var sendAName = ""//发货人区域名称
    var sendAddress = ""//发货地址
    var sendPhoto = ""//发货人证件头像
    var sendCardAddress = ""//发货地址
    var sendCardFullface = ""//发货人照片
    var getAddress = ""//收货地址
    var sendANameParentP = ""//发货人区域父父级名称
    var sendDate = ""//发货时间
    override func mapping(map: Map) {
        super.mapping(map: map)
        isNewRecord <- map["isNewRecord"]
        smsNum <- map["smsNum"]
        getAName <- map["getAName"]
        sendPhone <- map["sendPhone"]
        sendANameParent <- map["sendANameParent"]
        getName <- map["getName"]
        getAid <- map["getAid"]
        getPhone <- map["getPhone"]
        getANameParentP <- map["getANameParentP"]
        getANameParent <- map["getANameParent"]
        remarks <- map["remarks"]
        sendCard <- map["sendCard"]
        sendCsrq <- map["sendCsrq"]
        sendSex <- map["sendSex"]
        sendMz <- map["sendMz"]
        sendAid <- map["sendAid"]
        sendName <- map["sendName"]
        sendAddress <- map["sendAddress"]
        sendPhoto <- map["sendPhoto"]
        sendCardAddress <- map["sendCardAddress"]
        sendCardFullface <- map["sendCardFullface"]
        getAddress <- map["getAddress"]
        sendANameParentP <- map["sendANameParentP"]
        sendDate <- map["sendDate"]

        
        
    }
}
