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
            weakSelf!.dataController.saveModel.provinceId = province.region_id!
            weakSelf!.dataController.saveModel.cityId = city.region_id!
            weakSelf!.dataController.saveModel.regionId = district.region_id!
            
        }
        
    }
    
    func nextClick() {//下一步
        let dic:NSMutableDictionary = [
            "title":self.title,
            "type":dataController.type,
            "saveModel":dataController.saveModel
        ]
        pushViewController("CamaryViewController",sender:dic)
    }
    
    
}
