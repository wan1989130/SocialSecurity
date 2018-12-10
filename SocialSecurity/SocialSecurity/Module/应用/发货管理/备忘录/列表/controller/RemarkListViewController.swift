//
//  RemarkListViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/13.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class RemarkListViewController: BaseViewController {

    var listModel:RemarkDataModel = RemarkDataModel()
    var dataArray = [RemarkModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "备忘录"
        initData()
        initUI()
    }

   
}
extension RemarkListViewController{
    fileprivate func initData(){
        dataArray.removeAll()
        let sql = "select * from MyTable where loginName = '\(MyConfig.shared().loginName)' order by id desc"
        let resultArr = FMDBHelper.shared().selectDBWithSQL(sql: sql)
        if resultArr.count > 0{
            for dic in resultArr{
                let model = RemarkModel()
                model.autoId = dic["id"] as! Int
                model.time = dic["time"] as! String
                model.showTime = dic["showTime"] as! String
                model.content = dic["content"] as! String
                model.loginName = dic["loginName"] as! String
                dataArray.append(model)
            }
        }
     
    }
    
    fileprivate func initUI(){
        
        initTableView()
        loadRightBarButtonItem()
    }
    /**
     * 加载导航栏右侧按钮
     */
    fileprivate func loadRightBarButtonItem(){
        let button =   UIButton(type: .system)
        button.frame = CGRect(x:0, y:0, width:30, height:30)
        button.setTitle("新建", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let rightBarBtn = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    fileprivate func initTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.clear
        tableView.register("RemarkTableViewCell")
    }
    
    @objc func rightItemClick(){
        let dic:NSMutableDictionary = [
            "listModel":listModel
        ]
        
        pushViewController("AddRemarkViewController", sender: dic) { (info) in
            self.initData()
            self.tableView.reloadData()
        }
    }
}
extension RemarkListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RemarkTableViewCell.loadCell(tableView)
        cell.update(model: dataArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic:NSMutableDictionary = [
            "idModel":dataArray[indexPath.row]
        ]
        pushViewController("AddRemarkViewController",sender: dic){ (info) in
            self.initData()
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .normal, title: "删除") { (rowAction, indexPath) in
            LHAlertView.showAlertWithTitle("", msg: "确定删除该记录吗?", confirmButtonTitle: "确定", cancelButtonTitle: "取消", completionBlock: {
                self.updateDb(indexPath:indexPath)
            }, cancelBlock: {
                
            })
            
        }
        
        action.backgroundColor = UIColor.red
        
       
        return [action]
    }
    func updateDb(indexPath:IndexPath){
        
        let sql = "delete from MyTable where id = '\(dataArray[indexPath.row].autoId)'"
        FMDBHelper.shared().updateDBWithSQL(sql: sql)
        dataArray.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade) 
    }
}
