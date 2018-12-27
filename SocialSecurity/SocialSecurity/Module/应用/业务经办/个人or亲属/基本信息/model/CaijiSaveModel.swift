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
    var xb = ""
    var zjlx = ""//证件类型
    var zjhm = ""//证件号码
    var csrq = ""//出生日期
    var zjyxq = ""//证件有效期
    var mz = ""//民族
    var txdz = ""//通信地址
    
    var jhrzjlx = "" //监护人证件类型
    var jhrzh = "" //监护人证件号码
    var jhrxm = "" //监护人姓名
    
    var ryzt = ""//人员状态
    var gj = ""//国籍
    var hjxz = ""//户籍性质
    var lxsj = ""//联系手机
    var lxdh = ""//固定电话  ？？？
    var yzbm = ""//邮政编码
    var klmyh = ""//卡联名银行
    var zszy = ""//专属职业
    var zshy = ""//专属行业
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
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        xb <- map["xb"]
        zjlx <- map["zjlx"]
        zjhm <- map["zjhm"]
        csrq <- map["csrq"]
        zjyxq <- map["zjyxq"]
        mz <- map["mz"]
        txdz <- map["txdz"]
        
        jhrzjlx <- map["jhrzjlx"]
        jhrzh <- map["jhrzh"]
        jhrxm <- map["jhrxm"]
        
        ryzt <- map["ryzt"]
        gj <- map["gj"]
        hjxz <- map["hjxz"]
        lxsj <- map["lxsj"]
        lxdh <- map["lxdh"]
        yzbm <- map["yzbm"]
        klmyh <- map["klmyh"]
        zszy <- map["zszy"]
        zshy <- map["zshy"]
        yjdz <- map["yjdz"]
        zp <- map["zp"]
        dbr_xm <- map["dbr_xm"]
        dbr_sfzhm <- map["dbr_sfzhm"]
        dbr_lxdh <- map["dbr_lxdh"]
        
        
    }
   
}
