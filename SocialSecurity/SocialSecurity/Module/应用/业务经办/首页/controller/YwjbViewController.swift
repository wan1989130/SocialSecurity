//
//  YwjbViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class YwjbViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    var dataController:YwjbDataController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRequest()
    }

}
extension YwjbViewController{
    fileprivate func initUI(){
       self.view.backgroundColor = viewBgColor

        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("ApplyCollectionTableViewCell")
        tableView.register("ApplyBannerTableViewCell")
        
    }
    fileprivate func initData(){
        dataController = YwjbDataController(delegate: self)
    }
    
   
}
extension YwjbViewController{
    fileprivate func loadRequest(){
        let parameter:NSMutableDictionary = ["phone":MyConfig.shared().phone]
        weak var weakSelf = self
        dataController.selfQuery(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                weakSelf?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .none)
                
            }else {
                //TODO
                
            }
        }
    }
  
}

extension YwjbViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = ApplyBannerTableViewCell.loadCell(tableView)
                        let arr = ["https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4267222417,1017407570&fm=200&gp=0.jpg","https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3144465310,4114570573&fm=117&gp=0.jpg"]
                        cell.initCell(dataArray: arr)
//            cell.initCell(model: dataController.bannerModel)
            return cell
        }else{
            let cell = ApplyCollectionTableViewCell.loadCell(tableView)
            cell.initCell(delegate: self, dataArray: dataController.toolArray)
            cell.backgroundColor = UIColor.clear
            cell.pro = self
            if dataController.model != nil{
                cell.update(model: dataController.model.data)
            }
            
//            cell.statusView.removeAllSubviews()
//           cell.statusViewHeight.constant = 0
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return ScreenWidth * 480 / 1080
        }else {
            let height = ((ScreenWidth) / 3) * CGFloat(ceil(Double((4)) / 3))
            return height + 60 + 0.01
        }
        
    }
}
extension YwjbViewController:ApplyCollectionIndexClickProtocol{
    func collectionIndexClick(index: Int) {
        if index == 0{
            pushViewController("IxcjTypeViewController")
        }else if index == 1{
            let webVc = CommonWebViewController()
            webVc.urlContent = Protocolhtml
            webVc.titleContent = "制卡进度查询"
            self.navigationController?.pushViewController(webVc, animated: true)
        }else if index == 2{
            let webVc = CommonWebViewController()
            webVc.urlContent = Protocolhtml
            webVc.titleContent = "社保查询"
            self.navigationController?.pushViewController(webVc, animated: true)
        }else if index == 3{
            let webVc = CommonWebViewController()
            webVc.urlContent = Protocolhtml
            webVc.titleContent = "医保查询"
            self.navigationController?.pushViewController(webVc, animated: true)
        }
    }
}
