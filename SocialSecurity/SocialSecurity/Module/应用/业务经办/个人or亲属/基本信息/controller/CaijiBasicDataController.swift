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
    var dictionaryModel:DictionaryDataModel!
    var cellCount = 0
    var isCan = false
    var type = ""//0录入1修改2查看
//    var dataArray:Array<CaijiBasicDisplayModel> = []
    var saveModel = CaijiSaveModel()
    var isCanQueryModel = IsScanQueryDataModel()
    func scanQuery(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.scanQuery(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<IsScanQueryDataModel>().map(JSONObject: result)
                if model != nil{
                    self.isCanQueryModel = model!
                    if model?.data.isCan == "0"{//0是可以非0不可以拍照
                        self.isCan = true
                    }else{
                        self.isCan = false
                        
                    }
                    completionBlock(true,nil)
                }else{
                    completionBlock(false, nil)
                }
                
            }else{
                completionBlock(false, nil)
            }
            
        }
        
    }
    //扫描身份证使用
    func scanCountQuery(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.scanCountQuery(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                
                completionBlock(true,nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    //国标项
    func getDictionary(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getDictionary(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<DictionaryDataModel>().map(JSONObject: result)
                if model != nil{
                    self.dictionaryModel = model!
                    self.cellCount = 3
                    completionBlock(true,nil)
                }else{
                    completionBlock(false,nil)
                }
               
            }else{
                completionBlock(false, nil)
            }
        }
    }
    
    
    
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
