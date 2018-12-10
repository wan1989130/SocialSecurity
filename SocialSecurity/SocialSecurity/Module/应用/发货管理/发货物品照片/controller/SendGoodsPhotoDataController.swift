//
//  SendGoodsPhotoDataController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/13.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SendGoodsPhotoDataController: BaseDataController {
    var uploadPhotoModel = UploadPhotoLogisticsDataModel()
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
}
