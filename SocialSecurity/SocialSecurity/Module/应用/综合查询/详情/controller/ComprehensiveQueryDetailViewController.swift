//
//  ComprehensiveQueryDetailViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/14.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class ComprehensiveQueryDetailViewController: BaseViewController {
    var dataController:ComprehensiveQueryDetailDataController!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "物流管理"
        initData()
        initUI()
        queryDetail()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if LHHTTPClient.manager.tasks.count > 0{
            for task in LHHTTPClient.manager.tasks{
                if task.state == .running || task.state == .suspended{
                    task.cancel()
                }
            }
        }
        MBProgressHUD.hide(for: self.view, animated: true)
//        LHHTTPClient.hud = nil
       
    }
}
extension ComprehensiveQueryDetailViewController{
    fileprivate func initData(){
        dataController = ComprehensiveQueryDetailDataController(delegate: self)
        if senderParam != nil{
            dataController.id = senderParam as! String
        }
    }
    
    fileprivate func initUI(){
        self.view.backgroundColor = UIColor(hexString: "F0F0F0")
        initTableView()
    }
    
    fileprivate func initTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.clear
        tableView.register("SendPersonMessageDetailTableViewCell")//发货人信息
        tableView.register("SendGoodsMessageDetailTableViewCell")//发货信息cell
        tableView.register("GetPersonMessageDetailTableViewCell")//发货人信息cell
        tableView.register("PhotoDetailTableViewCell")//照片
        
    }
}
extension ComprehensiveQueryDetailViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = SendPersonMessageDetailTableViewCell.loadCell(tableView)
            cell.updateDetail(model: dataController.model.data)
            return cell
        }else if indexPath.row == 1{
            let cell = SendGoodsMessageDetailTableViewCell.loadCell(tableView)
            cell.updateDetail(model: dataController.model.data)
            return cell
        }else if indexPath.row == 2{
            let cell = GetPersonMessageDetailTableViewCell.loadCell(tableView)
            cell.updateDetail(model: dataController.model.data)
            return cell
            
        }else if indexPath.row == 3{
            let cell = PhotoDetailTableViewCell.loadCell(tableView)
            cell.updateDetail(model: dataController.model.data)
            return cell
            
        }
        return UITableViewCell()
    }
}
extension ComprehensiveQueryDetailViewController{
    func queryDetail(){
        let parameter:NSMutableDictionary = [
            "id":dataController.id
            
            ]
        dataController.shippingDetail(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.tableView.reloadData()
            }else {
                
            }
        }
    }
}
