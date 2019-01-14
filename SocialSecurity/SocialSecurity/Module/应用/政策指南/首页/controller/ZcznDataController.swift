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
        model1.text = "社保"
        model1.image = UIImage(named: "logo")
        let childModel1 = ZcznModel()
        childModel1.text = "城镇企业职工基本养老保险"
        childModel1.image = UIImage.init(named: "logo")
        let childChildModel1 = ZcznModel()
        childChildModel1.title = "2018年工资调整"
        childChildModel1.image = UIImage.init(named: "logo")
        childChildModel1.imageArray = ["1","2","3","4","5","6","7","8","9"]
        
        let childChildModel2 = ZcznModel()
        childChildModel2.title = "2018年工资调整"
        childChildModel2.image = UIImage.init(named: "logo")
        childChildModel2.imageArray = ["1","2","3","4","5","6","7","8","9"]
        childModel1.childArray.append(childChildModel1)
        childModel1.childArray.append(childChildModel2)
        model1.childArray.append(childModel1)
        
        
        toolArray.append(model1)
//        toolArray.append(model2)
//        toolArray.append(model3)
//        toolArray.append(model4)
//        toolArray.append(model5)
        
    }
}
