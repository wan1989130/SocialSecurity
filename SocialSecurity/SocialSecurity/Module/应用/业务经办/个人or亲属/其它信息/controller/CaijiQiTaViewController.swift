//
//  CaijiQiTaViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/21.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CaijiQiTaViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    var dataController:CaijiQiTaDataController!
    var isWrite = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        initUI()
    }

    deinit {
        print("其它信息页面销毁")
    }

}
extension CaijiQiTaViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("CaijiQiTaTableViewCell")
        tableView.register("CaijiBasicSaveTableViewCell")
        
    }
    fileprivate func initData(){
        dataController = CaijiQiTaDataController(delegate: self)
        if senderParam != nil{
            let dic = senderParam as! NSMutableDictionary
            if dic["title"] != nil{
                title = dic["title"] as! String
            }
            if dic["type"] != nil{
                dataController.type = dic["type"] as! String
            }
            if dic["saveModel"] != nil{
                dataController.saveModel = dic["saveModel"] as! CaijiSaveModel
            }
            if dic["dictionaryModel"] != nil{
                dataController.dictionaryModel = dic["dictionaryModel"] as! DictionaryDataModel
            }
            
        }
        
        
        if dataController.type == "2"{
            isWrite = false
        }
        
    }
}
extension CaijiQiTaViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = CaijiQiTaTableViewCell.loadCell(tableView)
            cell.pro = self
            
            cell.update(tableView: tableView, model: dataController.saveModel, isWrite: isWrite)
            return cell
        }else if indexPath.row == 1{
            let cell = CaijiBasicSaveTableViewCell.loadCell(tableView)
            cell.pro = self
            return cell
        }
        return UITableViewCell()
    }
}
extension CaijiQiTaViewController:CaijiBasicNextProtocol,CaijiQiTaContentSelectProtocol{
    func ryztClick() {//人员状态
        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataController.dictionaryModel.data.ryztMap,
            "selectIndexId":dataController.saveModel.ryzt
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            if weakSelf == nil{return}
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            weakSelf!.dataController.saveModel.jhrzjlx = model.id
            weakSelf!.dataController.saveModel.jhrzjlxName = model.name
            
        }
        
    }
    
    func gjClick() {//国籍

        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataController.dictionaryModel.data.gjMap,
            "selectIndexId":dataController.saveModel.gj
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            if weakSelf == nil{return}
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            weakSelf!.dataController.saveModel.gj = model.id
            weakSelf!.dataController.saveModel.gjName = model.name
            
        }
    }
    
    func hjxzClick() {//户籍性质
        
        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataController.dictionaryModel.data.hjxzMap,
            "selectIndexId":dataController.saveModel.hjxz
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            if weakSelf == nil{return}
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            weakSelf!.dataController.saveModel.hjxz = model.id
            weakSelf!.dataController.saveModel.hjxzName = model.name
            
        }
    }
    
    func klmyhClick() {//卡联名银行
        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataController.dictionaryModel.data.klmyhMap,
            "selectIndexId":dataController.saveModel.klmyh
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            if weakSelf == nil{return}
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            weakSelf!.dataController.saveModel.klmyh = model.id
            weakSelf!.dataController.saveModel.klmyhName = model.name
            
        }
    }
    
    func zszyClick() {//专属职业
        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataController.dictionaryModel.data.zszyMap,
            "selectIndexId":dataController.saveModel.zszy
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            if weakSelf == nil{return}
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            weakSelf!.dataController.saveModel.zszy = model.id
            weakSelf!.dataController.saveModel.zszyName = model.name
            
        }
    }
    
    func zshyClick() {//专属行业
        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataController.dictionaryModel.data.zshyMap,
            "selectIndexId":dataController.saveModel.zshy
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            if weakSelf == nil{return}
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            weakSelf!.dataController.saveModel.zshy = model.id
            weakSelf!.dataController.saveModel.zshyName = model.name
            
        }
    }
    
    func yjqyClick() {//邮寄区域
        weak var weakSelf = self
        AddressSelectView.show(withProvince: dataController.saveModel.provinceId, city: dataController.saveModel.cityId, district: dataController.saveModel.regionId) { (province , city, district) in
            if weakSelf == nil{return}
            let str = "\(province.region_name!)\(city.region_name!)\(district.region_name!)"
            weakSelf!.dataController.saveModel.provinceId = province.region_id!
            weakSelf!.dataController.saveModel.cityId = city.region_id!
            weakSelf!.dataController.saveModel.regionId = district.region_id!
            weakSelf!.dataController.saveModel.provinceName = province.region_name!
            weakSelf!.dataController.saveModel.cityName = city.region_name!
            weakSelf!.dataController.saveModel.regionName = district.region_name!
            weakSelf!.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
            
        }
        
    }
    
    func nextClick() {//下一步
        if checkFun(){
            let dic:NSMutableDictionary = [
                "title":self.title,
                "type":dataController.type,
                "saveModel":dataController.saveModel,
                "dictionaryModel":dataController.dictionaryModel
            ]
            pushViewController("CamaryViewController",sender:dic)
        }
        
    }
    func checkFun() -> Bool{
        closeKeyboard()
        let model = dataController.saveModel
        if model.ryzt == ""{
            LHAlertView.showTipAlertWithTitle("人员状态不能为空")
            return false
        }
        if model.gj == ""{
            LHAlertView.showTipAlertWithTitle("国籍不能为空")
            return false
        }
        if model.hjxz == ""{
            LHAlertView.showTipAlertWithTitle("户籍性质不能为空")
            return false
        }
        if model.lxsjStr1 == ""{
            LHAlertView.showTipAlertWithTitle("联系手机不能为空")
            return false
        }
        if model.yzbm == ""{
            LHAlertView.showTipAlertWithTitle("邮政编码不能为空")
            return false
        }
        if model.klmyh == ""{
            LHAlertView.showTipAlertWithTitle("卡联名银行不能为空")
            return false
        }
        if model.zszy == ""{
            LHAlertView.showTipAlertWithTitle("专属职业不能为空")
            return false
        }
        if model.zshy == ""{
            LHAlertView.showTipAlertWithTitle("专属行业不能为空")
            return false
        }
        if model.cityId == ""{
            LHAlertView.showTipAlertWithTitle("邮寄区域不能为空")
            return false
        }
        if model.yjdz == ""{
            LHAlertView.showTipAlertWithTitle("邮寄地址不能为空")
            return false
        }
        return true
    }
    
}
