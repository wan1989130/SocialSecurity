//
//  IxcjTypeDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class IxcjTypeDataController: BaseDataController {
    var toolArray:Array<ZcznModel> = [ZcznModel]()
    override init(delegate: UIViewController) {
        super.init(delegate: delegate)
        let model1 = ZcznModel()
        model1.text = "个人办理"
        model1.image = UIImage(named: "logo")
        let model2 = ZcznModel()
        model2.text = "亲属代办"
        model2.image = UIImage(named: "logo")
        let model3 = ZcznModel()
        model3.text = "采集进度查询"
        model3.image = UIImage(named: "logo")
        
        toolArray.append(model1)
        toolArray.append(model2)
        toolArray.append(model3)
    
        
    }
}
