//
//  CaijiSaveModel.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/20.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper



class CaijiSaveModel: BaseModel {
    //name 姓名
    var xmStr1 = ""
    var xb = ""
    var xbName = ""
    var zjlx = ""//证件类型
    var zjlxName = ""
    var zjhm = ""//证件号码
    var csrq = ""//出生日期
    var csrqStr = ""//
    var zjyxq = ""//证件有效期
    var mz = ""//民族
    var mzName = ""
    var txdz = ""//通信地址
    
    var jhrzjlx = "" //监护人证件类型
    var jhrzjlxName = "" //
    var jhrzh = "" //监护人证件号码
    var jhrxm = "" //监护人姓名
    
    var ryzt = ""//人员状态
    var ryztName = ""//
    var gj = ""//国籍
    var gjName = ""
    var hjxz = ""//户籍性质
    var hjxzName = ""
    var lxsjStr1 = ""//联系手机
    var lxdhStr1 = ""//固定电话  ？？？
    var yzbm = ""//邮政编码
    var klmyh = ""//卡联名银行
    var klmyhName = ""//
    var zszy = ""//专属职业
    var zszyName = ""//
    var zshy = ""//专属行业
    var zshyName = ""//
    var yjdz = ""//邮寄地址
    
    var zp = ""//照片路径 ???
    
    var dbr_xm = ""//代办人姓名
    var dbr_sfzhm = ""//代办人身份证号
    var dbr_lxdh = ""//代办人联系手机
    
    
    var provinceId = ""
    var cityId = ""
    var regionId = ""
    var provinceName = ""
    var cityName = ""
    var regionName = ""
    
    var sh = ""
    var sfdy = "0"
    var dwmc = ""
//    var createDate = ""
    var createDate1 = ""
    var lryId = ""
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        xmStr1 <- map["xmStr1"]
        xb <- map["xb"]
        xbName <- map["xbName"]
        zjlx <- map["zjlx"]
        zjlxName <- map["zjlxName"]
        zjhm <- map["zjhm"]
        csrq <- map["csrq"]
        csrqStr <- map["csrqStr"]
        zjyxq <- map["zjyxq"]
        mz <- map["mz"]
        mzName <- map["mzName"]
        txdz <- map["txdz"]
        
        jhrzjlx <- map["jhrzjlx"]
        jhrzjlxName <- map["jhrzjlxName"]
        jhrzh <- map["jhrzh"]
        jhrxm <- map["jhrxm"]
        
        ryzt <- map["ryzt"]
        ryztName <- map["ryztName"]
        gj <- map["gj"]
        gjName <- map["gjName"]
        hjxz <- map["hjxz"]
        hjxzName <- map["hjxzName"]
        lxsjStr1 <- map["lxsjStr1"]
        lxdhStr1 <- map["lxdhStr1"]
        yzbm <- map["yzbm"]
        klmyh <- map["klmyh"]
        klmyhName <- map["klmyhName"]
        zszy <- map["zszy"]
        zszyName <- map["zszyName"]
        zshy <- map["zshy"]
        zshyName <- map["zshyName"]
        yjdz <- map["yjdz"]
        zp <- map["zp"]
        dbr_xm <- map["dbr_xm"]
        dbr_sfzhm <- map["dbr_sfzhm"]
        dbr_lxdh <- map["dbr_lxdh"]
        
        provinceId <- map["provinceId"]
        provinceName <- map["provinceName"]
        cityId <- map["cityId"]
        cityName <- map["cityName"]
        regionId <- map["regionId"]
        regionName <- map["regionName"]
        
        sh <- map["sh"]
        sfdy <- map["sfdy"]
        dwmc <- map["dwmc"]
//        createDate <- map["createDate"]
        createDate1 <- map["createDate1"]
        lryId <- map["lryId"]
        
        
    }
   
}
class CaijiSaveDataModel: BaseModel {
    var data = CaijiSaveModel()
    var jsonStr = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        jsonStr <- map["data"]
        data = Mapper<CaijiSaveModel>().map(JSONString: jsonStr)!
//        data = Mapper<CaijiSaveModel>().map(JSONObject: jsonStr)!
        print("aa = \(data)")
        
    }
}
