//
//  SbkProgressDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SbkProgressDataController: BaseDataController {

    var saveModel:CaijiSaveModel!
    var dataArray = [SbkProgressItemModel]()
    //查看详情
    func queryDetail(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.queryDetail(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<CaijiSaveDataModel>().map(JSONObject: result)
                if model != nil{
                    self.saveModel = model?.data
                    completionBlock(true, nil)
                }
            }else{
                completionBlock(false, nil)
            }
            
        }
        
    }
    //采集进度查询
    func allPeopleQuery(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.allPeopleQuery(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<SbkProgressDataModel>().map(JSONObject: result)
                if model != nil{
                    self.dataArray = model!.data
                    completionBlock(true, nil)
                }
            }else{
                completionBlock(false, nil)
            }
            
        }
        
    }
}
