//
//  SbkProgressViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class SbkProgressViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    var dataController:SbkProgressDataController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "采集进度查询"
        initData()
        initUI()
        allPeopleQuery()
    }
    
}
extension SbkProgressViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("SbkProgressTableViewCell")
        
    }
    fileprivate func initData(){
        dataController = SbkProgressDataController(delegate: self)
    }
}
extension SbkProgressViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SbkProgressTableViewCell.loadCell(tableView)
        cell.update(model: dataController.dataArray[indexPath.row],index: indexPath.row)
        cell.pro = self
        return cell
    }
    
}
extension SbkProgressViewController:SbkProgressProtocol{
//    func detailWebviewClick() {
//        let webVc = DetailWebviewViewController()
//        self.navigationController?.pushViewController(webVc, animated: true)
//    }
    func detailWebviewClick(_ index: Int) {
        queryDetail(index: index)
    }
}
extension SbkProgressViewController{
    //采集进度查询
    fileprivate func allPeopleQuery(){
        
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone
        ]
        weak var weakSelf = self
        dataController.allPeopleQuery(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                if weakSelf == nil{return}
                weakSelf!.tableView.reloadData()
            }else {
                //TODO
                
            }
        }
    }
    
    //查看详情
    fileprivate func queryDetail(index:Int){
        
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone,
            "zjhm":dataController.dataArray[index].zhengjianNum
        ]
        weak var weakSelf = self
        dataController.queryDetail(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                if weakSelf == nil{return}
                weakSelf?.showWebOrShowUpdate(index: index)
            }else {
                //TODO
                
            }
        }
    }
    func showWebOrShowUpdate(index:Int){
        if  dataController.dataArray[index].status == 2{
            
            var tempTitle = ""
            if self.dataController.dataArray[index].type == "0"{
                tempTitle = "个人办理"
            }else{
                tempTitle = "亲属代办"
            }
            let dic:NSMutableDictionary = [
                "title":tempTitle,
                "type":"1",
                "saveModel":dataController.saveModel
            ]
            self.pushViewController("CaijiBasicViewController",sender:dic)
        }else if dataController.dataArray[index].status == 0 {
            let webVc = DetailWebviewViewController()
            webVc.saveModel = dataController.saveModel
            webVc.isCanUpdate = true
            webVc.type = dataController.dataArray[index].type
            self.navigationController?.pushViewController(webVc, animated: true)
        }else {
            let webVc = DetailWebviewViewController()
            webVc.saveModel = dataController.saveModel
            self.navigationController?.pushViewController(webVc, animated: true)
        }
    }
    
}
