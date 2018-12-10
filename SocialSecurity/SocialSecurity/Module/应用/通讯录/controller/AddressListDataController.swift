//
//  AddressListDataController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class AddressListDataController: BaseDataController {
    var model:AddressListDataModel = AddressListDataModel()
//    var dataArray:Array<AddressListModel> = [AddressListModel]()
    
    var students:Array<AddressListModel> = [AddressListModel]()
    var sectionTitles:Array<String> = [String]()
    var groupedStudents:Array<Array<AddressListModel>> = [[AddressListModel]]()   //按首字母分组后的学生数组,首字母与sectionTitles对应
    
    //通讯录列表查询(无分页)
    func telephoneList(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.telephoneList(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<AddressListDataModel>().map(JSONObject: result)!
                self.students = self.model.data
                self.sortStudents()
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    fileprivate func sortStudents(){
        sectionTitles = BMChineseSort.IndexWithArray(stringArr: students)
        groupedStudents = BMChineseSort.sortObjectArray(stringArray: students) as! Array<Array<AddressListModel>>
    }
    
}
