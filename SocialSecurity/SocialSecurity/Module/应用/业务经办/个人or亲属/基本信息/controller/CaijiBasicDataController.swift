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
    var type = ""//0录入1修改
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
                    self.updateDictionary()
                    completionBlock(true,nil)
                }else{
                    completionBlock(false,nil)
                }
               
            }else{
                completionBlock(false, nil)
            }
        }
    }
    func updateDictionary(){
        if type == "0"{//录入取第0个，修改不用动
            saveModel.xb = dictionaryModel.data.xbMap[0].id
            saveModel.xbName = dictionaryModel.data.xbMap[0].name
            
            saveModel.zjlx = dictionaryModel.data.zjlxMap[0].id
            saveModel.zjlxName = dictionaryModel.data.zjlxMap[0].name
            
            saveModel.mz = dictionaryModel.data.mzMap[0].id
            saveModel.mzName = dictionaryModel.data.mzMap[0].name
            
            saveModel.jhrzjlx = dictionaryModel.data.zjlxMap[0].id
            saveModel.jhrzjlxName = dictionaryModel.data.zjlxMap[0].name
            
            saveModel.ryzt = dictionaryModel.data.ryztMap[0].id
            saveModel.ryztName = dictionaryModel.data.ryztMap[0].name
            
            saveModel.gj = dictionaryModel.data.gjMap[0].id
            saveModel.gjName = dictionaryModel.data.gjMap[0].name
            
            saveModel.hjxz = dictionaryModel.data.hjxzMap[0].id
            saveModel.hjxzName = dictionaryModel.data.hjxzMap[0].name
            
            saveModel.klmyh = dictionaryModel.data.klmyhMap[0].id
            saveModel.klmyhName = dictionaryModel.data.klmyhMap[0].name
            
            saveModel.zszy = dictionaryModel.data.zszyMap[0].id
            saveModel.zszyName = dictionaryModel.data.zszyMap[0].name
            
            saveModel.zshy = dictionaryModel.data.zshyMap[0].id
            saveModel.zshyName = dictionaryModel.data.zshyMap[0].name
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let temDate = dateFormatter.date(from: saveModel.zjyxq)
            
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "yyyy-MM-dd"
            let zjyxq = dateFormatter2.string(from: temDate!)
            saveModel.zjyxq = zjyxq
            
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
