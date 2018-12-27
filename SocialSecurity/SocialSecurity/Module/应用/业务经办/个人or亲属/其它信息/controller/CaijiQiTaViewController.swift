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
    func ryztClick() {
        print("人员状态")
    }
    
    func gjClick() {
        print("国籍")
    }
    
    func hjxzClick() {
        print("户籍性质")
    }
    
    func klmyhClick() {
        print("户籍性质")
    }
    
    func zszyClick() {
        print("专属职业")
    }
    
    func zshyClick() {
        print("专属行业")
    }
    
    func yjqyClick() {//邮寄区域
        weak var weakSelf = self
        AddressSelectView.show(withProvince: dataController.saveModel.provinceId, city: dataController.saveModel.cityId, district: dataController.saveModel.regionId) { (province , city, district) in
            let str = "\(province.region_name!)\(city.region_name!)\(district.region_name!)"
            weakSelf?.dataController.saveModel.provinceId = province.region_id!
            weakSelf?.dataController.saveModel.cityId = city.region_id!
            weakSelf?.dataController.saveModel.regionId = district.region_id!
            
        }
        
    }
    
    func nextClick() {//下一步
        if checkFun(){
            let dic:NSMutableDictionary = [
                "title":self.title,
                "type":dataController.type,
                "saveModel":dataController.saveModel
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
        if model.lxsj == ""{
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
