//
//  CaijiBasicViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CaijiBasicViewController: BaseViewController {

   
    var dateType = ""//0出生日期1证件有效期
    var ageSelectIndex = -1
    var csrq = ""
    @IBOutlet var tableView: UITableView!
    var dataController:CaijiBasicDataController!
    var isWrite = true
    override func viewDidLoad() {
        super.viewDidLoad()
    
 
        initData()
        initUI()
    }
    deinit {
        print("基础信息页面销毁")
    }

  

}
extension CaijiBasicViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = ScreenHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("CaijiBasicIdCardTableViewCell")
        tableView.register("CaijiBasicContentTableViewCell")
        tableView.register("CaijiBasicSaveTableViewCell")
        
    }
    fileprivate func initData(){
        dataController = CaijiBasicDataController(delegate: self)
        if senderParam != nil{
            let dic = senderParam as! NSMutableDictionary
            if dic["title"] != nil{
                title = dic["title"] as! String
            }
            if dic["type"] != nil{
                dataController.type = dic["type"] as! String
            }
            
        }
        
        
        if dataController.type == "2"{
            isWrite = false
        }
        
    }
    
   
    
}
extension CaijiBasicViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = CaijiBasicIdCardTableViewCell.loadCell(tableView)
            cell.pro = self
            cell.update(flag: false, isWrite: isWrite)
            return cell
        }else if indexPath.row == 2{
            let cell = CaijiBasicSaveTableViewCell.loadCell(tableView)
            cell.pro = self
            return cell
        }else{
            let cell = CaijiBasicContentTableViewCell.loadCell(tableView)
            cell.pro = self
           
            cell.update(tableView: tableView, model: dataController.saveModel, isWrite: isWrite)
            return cell
            
        }
    }
    
}
extension CaijiBasicViewController:CaijiBasicIdCardPhotoClickProtoco{
    func idCardClick(_ type: IdCardType) {
        if type == .zheng{
            print("正")
        }else if type == .fan{
            print("反")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
extension CaijiBasicViewController:CaijiBasicNextProtocol,CaijiBasicContentSelectProtocol{
    func zjlxClick() {
        print("证件类型")
    }
    
    func csrqClick() {//出生日期
        closeKeyboard()
        dateType = "0"
        weak var weakSelf = self
        let dateView = SelectDateView(delegate: weakSelf!,currentStr:dataController.saveModel.csrq)
        dateView.pro = weakSelf
        dateView.show()
    }
    
    func zjyxqClick() {//证件有效期
        closeKeyboard()
        dateType = "1"
        weak var weakSelf = self
        let dateView = SelectChangQiDateView(delegate: weakSelf!,currentStr:dataController.saveModel.zjyxq)
        dateView.pro = weakSelf
        dateView.show()
        
    }
    
    func mzClick() {
        print("民族")
    }
    
    func nextClick() {//下一步
        let dic:NSMutableDictionary = [
            "title":self.title,
            "type":dataController.type,
            "saveModel":dataController.saveModel
        ]
        pushViewController("CaijiJianHuRenViewController",sender:dic)
        
    }
    func xbClick() {
        var dataArray = [DictionaryModel]()
        let model1 = DictionaryModel(id: "0", name: "男")
        let model2 = DictionaryModel(id: "1", name: "女")
        let model3 = DictionaryModel(id: "2", name: "未知")
        dataArray.append(model1)
        dataArray.append(model2)
        dataArray.append(model3)
        
        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataArray,
            "selectIndex":ageSelectIndex
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            print(model.name)
            weakSelf!.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
        }

        
    }
}
extension CaijiBasicViewController:SelectDateDelegate{
    func selectDate(dateString: String) {
        if dateType == "0"{
            dataController.saveModel.csrq = dateString
            self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
        }else if dateType == "1"{
            dataController.saveModel.zjyxq = dateString
            self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
        }
        
    }
}
