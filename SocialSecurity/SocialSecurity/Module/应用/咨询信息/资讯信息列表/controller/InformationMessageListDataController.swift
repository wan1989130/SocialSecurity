//
//  InformationMessageListDataController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class InformationMessageListDataController: BaseDataController {

    var model:InformationMessageDataModel = InformationMessageDataModel()
    var dataArray:Array<InformationMessageModel> = [InformationMessageModel]()
    var lastPage = -1
    ////资讯信息列表
    func informationList(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.informationList(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<InformationMessageDataModel>().map(JSONObject: result)!
                self.lastPage = self.model.lastPage
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
