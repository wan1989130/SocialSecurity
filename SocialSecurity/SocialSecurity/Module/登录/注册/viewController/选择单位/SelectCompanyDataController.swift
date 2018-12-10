//
//  SelectCompanyDataController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SelectCompanyDataController: BaseDataController {

    var model:SelectCompanyDataModel = SelectCompanyDataModel()
    var dataArray:Array<SelectCompanyModel> = [SelectCompanyModel]()
    //查询所有单位名称
    func selectCompany(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.selectCompany(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<SelectCompanyDataModel>().map(JSONObject: result)!
                 self.dataArray = self.model.data
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
