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
        //第一个
        let childModel1 = ZcznModel()
        childModel1.text = "被征地农民养老保险"
        childModel1.image = UIImage.init(named: "logo")
        let childChildModel1 = ZcznModel()
 
        childChildModel1.title = "长春市人民政府办公厅关于印发长春市统一被征地农民基本养老保险制度实施方案实施细则的通知（2012年11月19日长春市人民政府办公厅 长府办发[2012]44号公布）"
        childChildModel1.url = "sb_11"
        childModel1.childArray.append(childChildModel1)
        //第二个
        let childModel2 = ZcznModel()
        childModel2.text = "城乡居民养老保险"
        childModel2.image = UIImage.init(named: "logo")
        let childChildModel21 = ZcznModel()
        
        childChildModel21.title = "吉林省关于建立城乡居民基本养老保险待遇确定和基础养老金正常调整机制的实施意见"
        childChildModel21.url = "sb_21"
        childModel2.childArray.append(childChildModel21)
        let childChildModel22 = ZcznModel()
        
        childChildModel21.title = "吉林省关于调整城乡居民基本养老保险基础养老金标准、个人缴费标准的通知"
        childChildModel22.url = "sb_22"
        childModel2.childArray.append(childChildModel22)
        let childChildModel23 = ZcznModel()
        
        childChildModel21.title = "长春市人民政府关于印发长春市统一城乡居民基本养老保险实施方案的通知（长府发[2014]19 号）"
        childChildModel23.url = "sb_23"
        childModel2.childArray.append(childChildModel23)
        
        //第三个
        let childModel3 = ZcznModel()
        childModel3.text = "城镇企业职工基本养老保险"
        childModel3.image = UIImage.init(named: "logo")
        let childChildModel31 = ZcznModel()
        
        childChildModel31.title = "关于进一步加强企业职工基本养老保险省级统筹行政管理工作的通知"
        childChildModel31.url = "sb_31"
        childModel3.childArray.append(childChildModel31)
        let childChildModel32 = ZcznModel()
        
        childChildModel32.title = "人力资源社会保障部办公厅财政部办公厅关于公布2016年职工基本养老保险个人账户记账利率等参数的通知（人社厅发[2017]71号）"
        childChildModel32.url = "sb_32"
        childModel3.childArray.append(childChildModel32)
        let childChildModel33 = ZcznModel()
        
        childChildModel33.title = "长春市人民政府关于印发长春市统一城乡居民基本养老保险实施方案的通知（长府发[2014]19 号）"
        childChildModel33.url = "sb_33"
        childModel3.childArray.append(childChildModel33)
        
        //第四个
        let childModel4 = ZcznModel()
        childModel4.text = "机关事业单位养老保险"
        childModel4.image = UIImage.init(named: "logo")
        let childChildModel41 = ZcznModel()
        childChildModel41.title = "人力资源社会保障部办公厅关于印发《机关事业单位基本养老保险关系和职业年金转移接续经办规程（暂行）》的通知"
        childChildModel41.url = "sb_41"
        childModel4.childArray.append(childChildModel41)
        let childChildModel42 = ZcznModel()
        childChildModel42.title = "人社部财政部关于贯彻落实《国务院关于机关事业单位工作人员养老保险制度改革的决定》的通知"
        childChildModel42.url = "sb_42"
        childModel4.childArray.append(childChildModel42)
        let childChildModel43 = ZcznModel()
        childChildModel43.title = "人社部规[2017]1号 人力资源和社会保障部、财政部关于机关事业单位基本养老保险关系和职业年金转移接续有关问题的通知"
        childChildModel43.url = "sb_43"
        childModel4.childArray.append(childChildModel43)
        
        
        //第五个
        let childModel5 = ZcznModel()
        childModel5.text = "失业保险"
        childModel5.image = UIImage.init(named: "logo")
        let childChildModel51 = ZcznModel()
        childChildModel51.title = "关于失业保险支持参保职工提升职业技能有关问题的补充通知"
        childChildModel51.url = "sb_51"
        childModel5.childArray.append(childChildModel51)
        let childChildModel52 = ZcznModel()
        childChildModel52.title = "关于失业保险支持参保职工提升职业技能有关问题的通知"
        childChildModel52.url = "sb_52"
        childModel5.childArray.append(childChildModel52)
        let childChildModel53 = ZcznModel()
        childChildModel53.title = "关于提高失业保险金标准的通知（吉人社办字[2017]21号）"
        childChildModel53.url = "sb_53"
        childModel5.childArray.append(childChildModel53)
        let childChildModel54 = ZcznModel()
        childChildModel54.title = "关于提高失业保险金标准的通知（吉人社办字〔2018〕47号）"
        childChildModel54.url = "sb_54"
        childModel5.childArray.append(childChildModel54)
        
        //第六个
        let childModel6 = ZcznModel()
        childModel6.text = "其他"
        childModel6.image = UIImage.init(named: "logo")
        let childChildModel61 = ZcznModel()
        childChildModel61.title = "关于领取失业保险金人员参加职工基本医疗保险有关问题的通知"
        childChildModel61.url = "sb_61"
        childModel6.childArray.append(childChildModel61)
        let childChildModel62 = ZcznModel()
        childChildModel62.title = "长春市企业退休人员档案管理中心档案利用的意见"
        childChildModel62.url = "sb_62"
        childModel6.childArray.append(childChildModel62)
        let childChildModel63 = ZcznModel()
        childChildModel63.title = "长春市人民政府办公厅关于转发长春市企业退休人员档案管理中心档案实行集中统一管理有关有关问题的通知"
        childChildModel63.url = "sb_63"
        childModel6.childArray.append(childChildModel63)
        let childChildModel64 = ZcznModel()
        childChildModel64.title = "转发人力资源和社会保障部、财政部《关于领取失业保险金人员参加职工基本医疗保险有关问题的通知》的通知"
        childChildModel64.url = "sb_64"
        childModel6.childArray.append(childChildModel64)
        
        
    
        model1.childArray.append(childModel1)
        model1.childArray.append(childModel2)
        model1.childArray.append(childModel3)
        model1.childArray.append(childModel4)
        model1.childArray.append(childModel5)
        model1.childArray.append(childModel6)
        
        
        
        toolArray.append(model1)
//        toolArray.append(model2)
//        toolArray.append(model3)
//        toolArray.append(model4)
//        toolArray.append(model5)
        
    }
}
