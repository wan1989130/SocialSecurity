//
//  DeliverGoodsDataController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class DeliverGoodsDataController: BaseDataController {
    var uploadPhotoModel = UploadPhotoLogisticsDataModel()
    var uploadCardModel = UploadPhotoLogisticsDataModel()
    var model:InformationMessageDataModel = InformationMessageDataModel()
    var dataArray:Array<InformationMessageModel> = [InformationMessageModel]()
    var lastPage = -1
    
    var areaModel = AreaDataModel()
    var tempSavemodel:SendAndGetPersonMessageDataModel?
    //资讯信息列表
    func informationList(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.informationList(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<InformationMessageDataModel>().map(JSONObject: result)!
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    
    //区域获取
    func areaList(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        
        MSDataProvider.areaList(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.areaModel = Mapper<AreaDataModel>().map(JSONObject: result)!
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    
    //上传图片
    func uploadPhoto(imgDataArray:Array<Data>,parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.uploadFile(delegate: self.delegate!, imgDataArray: imgDataArray,parameter:parameter) { (isSuccess, result) in
            if isSuccess{
                self.uploadPhotoModel = Mapper<UploadPhotoLogisticsDataModel>().map(JSONObject: result)!
                
                completionBlock(true, nil)
            }else{
                
                completionBlock(false, nil)
            }
        }
    }
    //上传图片
    func uploadCard(imgDataArray:Array<Data>,parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.uploadFile(delegate: self.delegate!, imgDataArray: imgDataArray,parameter:parameter) { (isSuccess, result) in
            if isSuccess{
                self.uploadCardModel = Mapper<UploadPhotoLogisticsDataModel>().map(JSONObject: result)!
                
                completionBlock(true, nil)
            }else{
                
                completionBlock(false, nil)
            }
        }
    }
    
    //发货管理录入
    func addShippingInfo(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.addShippingInfo(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<ComprehensiveQueryDetailDataModel>().map(JSONObject: result)!
                if model != nil && model.msg != nil{
                    LHAlertView.showTipAlertWithTitle(model.msg!)
                }
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    //根据发货人身份证号查找发货人、收货人信息
    func getUserByCard(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getUserByCard(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<SendAndGetPersonMessageDataModel>().map(JSONObject: result)!
                if model.data.sendCard != ""{
                    self.tempSavemodel = model
                }
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
