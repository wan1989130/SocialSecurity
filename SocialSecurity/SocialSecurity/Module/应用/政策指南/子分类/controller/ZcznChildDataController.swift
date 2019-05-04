//
//  ZcznChildDataController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/5/4.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class ZcznChildDataController: BaseDataController {
    var toolArray:Array<ZcznModel> = [ZcznModel]()
    override init(delegate: UIViewController) {
        super.init(delegate: delegate)
        initSb()
        initYb()
        
        
        //        toolArray.append(model1)
        //        toolArray.append(model2)
        //        toolArray.append(model3)
        //        toolArray.append(model4)
        //        toolArray.append(model5)
        
    }
    func initSb(){
        let model1 = ZcznModel()
        model1.text = "社保"
        model1.image = UIImage(named: "zczn_sb")
        //第一个
        let childModel1 = ZcznModel()
        childModel1.text = "被征地农民养老保险"
        childModel1.image = UIImage.init(named: "bzd")
        let childChildModel1 = ZcznModel()
        
        childChildModel1.title = "长春市人民政府办公厅关于印发长春市统一被征地农民基本养老保险制度实施方案实施细则的通知（2012年11月19日长春市人民政府办公厅 长府办发[2012]44号公布）"
        childChildModel1.url = "sb_11"
        childModel1.childArray.append(childChildModel1)
        //第二个
        let childModel2 = ZcznModel()
        childModel2.text = "城乡居民养老保险"
        childModel2.image = UIImage.init(named: "cxjm")
        let childChildModel21 = ZcznModel()
        
        childChildModel21.title = "吉林省关于调整城乡居民基本养老保险基础养老金标准、个人缴费标准的通知"
        childChildModel21.url = "sb_21"
        childModel2.childArray.append(childChildModel21)
        let childChildModel22 = ZcznModel()
        
        childChildModel22.title = "吉林省关于建立城乡居民基本养老保险待遇确定和基础养老金正常调整机制的实施意见"
        childChildModel22.url = "sb_22"
        childModel2.childArray.append(childChildModel22)
        let childChildModel23 = ZcznModel()
        
        childChildModel23.title = "长春市人民政府关于印发长春市统一城乡居民基本养老保险实施方案的通知（长府发[2014]19 号）"
        childChildModel23.url = "sb_23"
        childModel2.childArray.append(childChildModel23)
        
        //第三个
        let childModel3 = ZcznModel()
        childModel3.text = "城镇企业职工基本养老保险"
        childModel3.image = UIImage.init(named: "qyzg")
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
        childModel4.image = UIImage.init(named: "jgsy")
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
        childModel5.image = UIImage.init(named: "sybx")
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
        childModel6.image = UIImage.init(named: "qt")
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
    }
    func initYb(){
        let model1 = ZcznModel()
        model1.text = "医保"
        model1.image = UIImage(named: "zczn_yb")
        //第一个
        let childModel1 = ZcznModel()
        childModel1.text = "工伤保险"
        childModel1.image = UIImage.init(named: "gs")
        let childChildModel1 = ZcznModel()
        childChildModel1.title = "部分行业企业工伤保险费缴纳办法"
        childChildModel1.url = "yb_11"
        childModel1.childArray.append(childChildModel1)
        
        let childChildModel2 = ZcznModel()
        childChildModel2.title = "关于调整工伤保险待遇的通知"
        childChildModel2.url = "yb_12"
        childModel1.childArray.append(childChildModel2)
        
        let childChildModel3 = ZcznModel()
        childChildModel3.title = "关于进一步做好建筑施工企业农民工参加工伤保险工作的通知"
        childChildModel3.url = "yb_13"
        childModel1.childArray.append(childChildModel3)
        
        let childChildModel4 = ZcznModel()
        childChildModel4.title = "吉林省工伤康复管理暂行办法"
        childChildModel4.url = "yb_14"
        childModel1.childArray.append(childChildModel4)
        
        let childChildModel5 = ZcznModel()
        childChildModel5.title = "长春市基本医疗、工伤、生育保险待遇支付与审批的管理细则"
        childChildModel5.url = "yb_15"
        childModel1.childArray.append(childChildModel5)
        
        let childChildModel6 = ZcznModel()
        childChildModel6.title = "长春市人民政府办公厅关于调整全市工伤职工伤残津贴标准和生活护理费标准的通知"
        childChildModel6.url = "yb_16"
        childModel1.childArray.append(childChildModel6)
        //第二个
        let childModel2 = ZcznModel()
        childModel2.text = "居民医疗保险"
        childModel2.image = UIImage.init(named: "jmyl")
        let childChildModel21 = ZcznModel()
        
        childChildModel21.title = "关于调整2016年城镇居民基本医疗保险缴费及补助标准的通知"
        childChildModel21.url = "yb_21"
        childModel2.childArray.append(childChildModel21)
        let childChildModel22 = ZcznModel()
        
        childChildModel22.title = "关于印发《长春市失能人员医疗照护保险实施办法（试行）》的通知"
        childChildModel22.url = "sb_22"
        childModel2.childArray.append(childChildModel22)
        let childChildModel23 = ZcznModel()
        
        childChildModel23.title = "长春市人民政府办公厅关于建立失能人员医疗照护保险制度的意见"
        childChildModel23.url = "yb_23"
        childModel2.childArray.append(childChildModel23)
        
        //第三个
        let childModel3 = ZcznModel()
        childModel3.text = "生育保险"
        childModel3.image = UIImage.init(named: "sybx")
        let childChildModel31 = ZcznModel()
        childChildModel31.title = "关于生育保险项目纳入定点医疗机构管理的通知"
        childChildModel31.url = "yb_31"
        childModel3.childArray.append(childChildModel31)
        let childChildModel32 = ZcznModel()
        childChildModel32.title = "关于育产期女职工围产保健待遇结算的通知"
        childChildModel32.url = "yb_32"
        childModel3.childArray.append(childChildModel32)
        let childChildModel33 = ZcznModel()
        childChildModel33.title = "长春市人民政府办公厅关于调整和增加城镇职工生育保险有关待遇的通知"
        childChildModel33.url = "yb_33"
        childModel3.childArray.append(childChildModel33)
        let childChildModel34 = ZcznModel()
        childChildModel34.title = "长春市人民政府办公厅关于调整完善城镇职工和居民基本医疗保险有关政策的通知"
        childChildModel34.url = "yb_34"
        childModel3.childArray.append(childChildModel34)
        let childChildModel35 = ZcznModel()
        childChildModel35.title = "长春市人民政府办公厅关于实施《吉林省城镇职工生育保险办法》的通知"
        childChildModel35.url = "yb_35"
        childModel3.childArray.append(childChildModel35)
        let childChildModel36 = ZcznModel()
        childChildModel36.title = "长春市人民政府办公厅关于印发长春市城镇居民生育保险试点实施方案的通知"
        childChildModel36.url = "yb_36"
        childModel3.childArray.append(childChildModel36)
        
        //第四个
        let childModel4 = ZcznModel()
        childModel4.text = "职工医疗保险"
        childModel4.image = UIImage.init(named: "zgyl")
        let childChildModel41 = ZcznModel()
        childChildModel41.title = "关于印发《长春市失能人员医疗照护保险实施办法（试行）》的通知"
        childChildModel41.url = "yb_41"
        childModel4.childArray.append(childChildModel41)
        let childChildModel42 = ZcznModel()
        childChildModel42.title = "人力资源社会保障部关于进一步加强基本医疗保险医疗服务监管的意见"
        childChildModel42.url = "yb_42"
        childModel4.childArray.append(childChildModel42)
        let childChildModel43 = ZcznModel()
        childChildModel43.title = "人力资源社会保障部关于完善基本医疗保险定点医药机构协议管理的指导意见"
        childChildModel43.url = "yb_43"
        childModel4.childArray.append(childChildModel43)
        let childChildModel44 = ZcznModel()
        childChildModel44.title = "长春市人民政府办公厅关于建立失能人员医疗照护保险制度的意见"
        childChildModel44.url = "yb_44"
        childModel4.childArray.append(childChildModel44)
        
        
        
        
        
        model1.childArray.append(childModel1)
        model1.childArray.append(childModel2)
        model1.childArray.append(childModel3)
        model1.childArray.append(childModel4)
        
        toolArray.append(model1)
    }
}
