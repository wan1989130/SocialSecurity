//
//  FilterModel.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class FilterModel: BaseModel {
    //name 货物名称   【选填，搜索条件】
    var cid = MyConfig.shared().companyId//用户所属单位id（companyId）【必填】
    var userId = MyConfig.shared().projectId//用户id 【必填】
    var stime = ""//开始时间   【选填，搜索条件】（时间格式20181022）
    var etime = ""//结束时间   【选填，搜索条件】（时间格式20181022）
//    var name = ""//货物名称   【选填，搜索条件】
    var smsNum = ""//物流单号   【选填，搜索条件】
    var sendName = ""//发货人姓名 【选填，搜索条件】
    var sendPhone  = ""//发货人电话 【选填，搜索条件】
    var startTime = ""//收件量统计时间筛选条件（年份+月份，格式：201809）
    override func mapping(map: Map) {
        cid    <- map["cid"]
        userId    <- map["userId"]
        stime    <- map["stime"]
        etime    <- map["etime"]
        smsNum    <- map["smsNum"]
        sendName    <- map["sendName"]
        sendPhone    <- map["sendPhone"]
        startTime    <- map["startTime"]
    }
}
