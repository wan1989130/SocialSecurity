//
//  ZcznDetailViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class ZcznDetailViewController: BaseViewController {

    var model:ZcznModel!
    @IBOutlet var tableView: UITableView!
//    var dataController:ZcznDetailDataController!
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        initUI()
    }
 

}
extension ZcznDetailViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("ZcznDetailTableViewCell")
        
        
    }
    fileprivate func initData(){
//        dataController = ZcznDetailDataController(delegate: self)
//        if senderParam != nil && senderParam is Int{
//            dataController.initData(type: senderParam as! Int)  
//        }
        if senderParam != nil{
            model = senderParam as! ZcznModel
        }
    }
}
extension ZcznDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.childArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ZcznDetailTableViewCell.loadCell(tableView)
        cell.update(model: model.childArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVc = ZcznWebViewController()
        webVc.urlContent = model.childArray[indexPath.row].url
//        webVc.titleContent = dataController.dataArray[indexPath.row].title
        self.navigationController?.pushViewController(webVc, animated: true)
//        pushViewController("PhotoShowViewController",sender:model.childArray[indexPath.row])
    }
}
