//
//  DeliverGoodsSaveModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class DeliverGoodsSaveModel: BaseModel {
//    name   货物名称
    var cid = MyConfig.shared().companyId//用户所属单位id（companyId）
    var userId = MyConfig.shared().projectId//用户id
    var smsNum   = ""//物流单号(自动生成)
    var photo    = ""//货物图片（多张图片拼接|/userfiles/…/639612303.jpg|/userfiles/…/c.jpg|…）
    var sendDate = ""//发货时间
    var sendName = ""//发货人姓名
    var sendPhone   = ""//发货人电话
    var sendCard    = ""//发货人身份证号码
    var sendAid = ""//发货人所属区域
    var sendAddress = ""//发货地址
    var sendPhoto = ""//证件头像（多张图片拼接|/userfiles/…/639612303.jpg|/userfiles/…/c.jpg|…）
    var imageSendPhoto:UIImage?//证件头像
    var sendSex = ""//发货人性别
    var sendMz = ""//发货人民族
    var sendCsrq = ""//发货人出生日期
    var sendCardAddress = ""//身份证住址
    var sendQfjg = ""//发货人签发机关
    var sendYxqx = ""//发货人有效期限
    var remarks = ""//备注信息（选填）
    var getName = ""//收货人姓名
    var getPhone = ""//收货人电话
    var getCode = ""//收货人邮政编码
    var getAid = ""//收货人所属区域
    var getAddress = ""//收货地址
    var sendANameParentP = ""//发货省
    var sendANameParent = ""//发货市
    var sendAName = ""//发货区
    var getANameParentP = ""//收货省
    var getANameParent = ""//发货市
    var getAName = ""//发货区
    var sendCardFullface = ""//近身照
    
    var tempSendAddress = ""//发货的省市区
    var tempGetAddress = ""//收货的省市区
    var provinceSend = ""
    var citySend = ""
    var districtSend = ""
    
    var provinceGet = ""
    var cityGet = ""
    var districtGet = ""
    
    var assetSendPersonPhoto:PHAsset?//发货人近照
    var imageSendPersonPhoto:UIImage?//发货人
    
   var sendPhotoStatusModel = [SendPhotoStatusModel]()
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        cid <- map["cid"]
        userId <- map["userId"]
        smsNum <- map["smsNum"]
        photo <- map["photo"]
        sendDate <- map["sendDate"]
        sendName <- map["sendName"]
        sendPhone <- map["sendPhone"]
        sendCard <- map["sendCard"]
        sendAid <- map["sendAid"]
        sendAddress <- map["sendAddress"]
        sendPhoto <- map["sendPhoto"]
        sendSex <- map["sendSex"]
        sendMz <- map["sendMz"]
        sendCsrq <- map["sendCsrq"]
        sendCardAddress <- map["sendCardAddress"]
        sendQfjg <- map["sendQfjg"]
        sendYxqx <- map["sendYxqx"]
        remarks <- map["remarks"]
        getName <- map["getName"]
        getPhone <- map["getPhone"]
        getCode <- map["getCode"]
        getAid <- map["getAid"]
        getAddress <- map["getAddress"]
        sendANameParentP <- map["sendANameParentP"]
        sendANameParent <- map["sendANameParent"]
        sendAName <- map["sendAName"]
        
        getANameParentP <- map["getANameParentP"]
        getANameParent <- map["getANameParent"]
        getAName <- map["getAName"]
        
        sendCardFullface  <- map["sendCardFullface"]
       
    }
}
class SendPhotoStatusModel:BaseModel{
    //货物照片
    var assetSendGoods:PHAsset = PHAsset()
    var imageSendGoods:UIImage = UIImage()
    var urlSendGoods = ""
    var isSelect = false
    var isSuccess = false
}
