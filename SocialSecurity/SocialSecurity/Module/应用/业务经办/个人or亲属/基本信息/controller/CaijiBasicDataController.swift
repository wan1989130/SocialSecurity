//
//  CaijiBasicDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper

class CaijiBasicDataController: BaseDataController {
    var type = ""//0录入1修改2查看
//    var dataArray:Array<CaijiBasicDisplayModel> = []
    var saveModel = CaijiSaveModel()
//    func initData() {
//        dataArray.removeAll()
//        dataArray.append(CaijiBasicDisplayModel(key: "姓名", value: saveModel.name,placeHolder:"请输入姓名", type: .name,isMust:true,isSelect:false))
//        dataArray.append(CaijiBasicDisplayModel(key: "性别", value: saveModel.sex,placeHolder:"请选择性别", type: .sex,isMust:true,isSelect:true))
//        dataArray.append(CaijiBasicDisplayModel(key: "证件类型", value: saveModel.zjlx,placeHolder:"请选择证件类型", type: .zjlx,isMust:false,isSelect:true))
//        dataArray.append(CaijiBasicDisplayModel(key: "证件号码", value: saveModel.zjhm,placeHolder:"请输入证件号码", type: .name,isMust:true,isSelect:false))
//        dataArray.append(CaijiBasicDisplayModel(key: "出生日期", value: saveModel.csrq,placeHolder:"请选择出生日期", type: .name,isMust:true,isSelect:true))
//        dataArray.append(CaijiBasicDisplayModel(key: "证件有效期", value: saveModel.zjyxq,placeHolder:"请选择证件有效期", type: .name,isMust:true,isSelect:true))
//        dataArray.append(CaijiBasicDisplayModel(key: "民族", value: saveModel.mz,placeHolder:"请选择民族", type: .name,isMust:true,isSelect:true))
//        dataArray.append(CaijiBasicDisplayModel(key: "通信地址", value: saveModel.txdz,placeHolder:"请输入通信地址", type: .name,isMust:true,isSelect:false))
//       
//    }
}
