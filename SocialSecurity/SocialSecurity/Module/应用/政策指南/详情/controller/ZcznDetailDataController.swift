//
//  ZcznDetailDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class ZcznDetailDataController: BaseDataController {

    var dataArray = [ZcznDetailDataModel]()
    func initData(type:Int){
//        if type == 0{
            for i in 0..<20{
                let model1 = ZcznDetailDataModel()
                model1.title = "政策指南\(i)"
                model1.url = "http://www.ccshbx.org.cn/czqyzgjbylbx/273024.jhtml"
                dataArray.append(model1)
            }
            
//        }
    }
}
