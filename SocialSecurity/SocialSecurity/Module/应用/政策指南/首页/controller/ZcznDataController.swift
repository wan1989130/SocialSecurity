//
//  ZcznDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class ZcznDataController: BaseDataController {
    var toolArray:Array<ZcznModel> = [ZcznModel]()
    override init(delegate: UIViewController) {
        super.init(delegate: delegate)
        let model1 = ZcznModel()
        model1.text = "综合类"
        model1.image = UIImage(named: "logo")
        let model2 = ZcznModel()
        model2.text = "城镇职工养老"
        model2.image = UIImage(named: "logo")
        let model3 = ZcznModel()
        model3.text = "城乡居民养老"
        model3.image = UIImage(named: "logo")
        let model4 = ZcznModel()
        model4.text = "失业保险"
        model4.image = UIImage(named: "logo")
        let model5 = ZcznModel()
        model5.text = "机关事业养老保险"
        model5.image = UIImage(named: "logo")
        toolArray.append(model1)
        toolArray.append(model2)
        toolArray.append(model3)
        toolArray.append(model4)
        toolArray.append(model5)
        
    }
}
