//
//  YwjbViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class YwjbViewController: BaseViewController {

    var isMax:Bool = true
    @IBOutlet var tableView: UITableView!
    var dataController:YwjbDataController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        getUrls()
        
        
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
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.register("ApplyCollectionTableViewCell")
        tableView.register("ApplyBannerTableViewCell")
        tableView.register("ApplyTipTableViewCell")
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
                weakSelf?.getWriteCount()
                
               
                
            }else {
                //TODO
                weakSelf?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .none)
                
            }
        }
    }
    fileprivate func getUrls(){
        let parameter:NSMutableDictionary = ["phone":MyConfig.shared().phone]
        dataController.getUrls(parameter: parameter) { (isSucceed, info) in
           
        }
    }
    
    fileprivate func getWriteCount(){
        let parameter:NSMutableDictionary = ["phone":MyConfig.shared().phone]
        weak var weakSelf = self
        dataController.getWriteCount(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                if weakSelf?.dataController.writeModel.data.maxCount == weakSelf?.dataController.writeModel.data.nowCount{
                    weakSelf?.isMax = true
                }else{
                    weakSelf?.isMax = false
                }
                
            }else {
                //TODO
                
            }
            UIView.performWithoutAnimation{
                weakSelf?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .none)
            }
        }
    }
  
}

extension YwjbViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = ApplyBannerTableViewCell.loadCell(tableView)
//                        let arr = ["https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4267222417,1017407570&fm=200&gp=0.jpg","https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3144465310,4114570573&fm=117&gp=0.jpg"]
            let arr = ["banner1","banner2"]
                        cell.initCell(dataArray: arr)
//            cell.initCell(model: dataController.bannerModel)
            return cell
        }else if indexPath.section == 2{
//            let cell = ApplyCollectionTableViewCell.loadCell(tableView)
            //因为cell中有布局需要隐藏remove，所以不复用
                 let cell = Bundle.main.loadNibNamed("ApplyCollectionTableViewCell", owner: self, options: nil)?.last as! ApplyCollectionTableViewCell
            cell.selectionStyle = .none
            cell.initCell(delegate: self, dataArray: dataController.toolArray)
            cell.backgroundColor = UIColor.clear
            cell.pro = self
            //接口获取失败的话不显示
            if dataController.selfQueryIsSuccess{
                cell.statusViewHeight.constant = 60
                
            }else{
                cell.statusView.removeAllSubviews()
                cell.statusViewHeight.constant = 0
            }
            if dataController.model != nil{
                cell.update(model: dataController.model.data)
            }
            
            
//            cell.statusView.removeAllSubviews()
//           cell.statusViewHeight.constant = 0
            return cell
        }else if indexPath.section == 1{
            let cell = ApplyTipTableViewCell.loadCell(tableView)
            cell.pro = self
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return ScreenWidth * 480 / 1080
        }else if indexPath.section == 2{
            let height = ((ScreenWidth) / 2) * CGFloat(ceil(Double((dataController.toolArray.count)) / 2))
//            return height  + 0.01 + 60
            if dataController.selfQueryIsSuccess && dataController.model.data.status != "0"{
                return height  + 0.01 + 60
            }else{
               return height  + 0.01
            }
            
        }else{
            return UITableView.automaticDimension
        }
        
    }
}
extension YwjbViewController:ApplyCollectionIndexClickProtocol,ApplyTipTableViewCellClickProtocol{
    func collectionIndexClick(index: Int) {
//        if index == 0{
//            pushViewController("IxcjTypeViewController")
//        }else if index == 1{
//            let webVc = CommonWebViewController()
//            webVc.urlContent = MyConfig.shared().zhikajinduUrl
//            webVc.titleContent = "制卡进度查询"
//            webVc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(webVc, animated: true)
//        }else if index == 2{
//            LHAlertView.showTipAlertWithTitle("暂未开放，敬请期待")
////            let webVc = CommonWebViewController()
////            webVc.urlContent = MyConfig.shared().shebaoUrl
////            webVc.titleContent = "社保查询"
////            webVc.hidesBottomBarWhenPushed = true
////            self.navigationController?.pushViewController(webVc, animated: true)
//        }else if index == 3{
//            LHAlertView.showTipAlertWithTitle("暂未开放，敬请期待")
////            let webVc = CommonWebViewController()
////            webVc.urlContent = MyConfig.shared().yibaoUrl
////            webVc.titleContent = "医保查询"
////            webVc.hidesBottomBarWhenPushed = true
////            self.navigationController?.pushViewController(webVc, animated: true)
//        }
        
        if index <= 1 && isMax {
            LHAlertView.showTipAlertWithTitle("录入次数已达最大限制\(dataController.writeModel.data.maxCount)")
            return
        }
        if index == 0 && dataController.writeModel.data.nowCount != "0"{
            LHAlertView.showTipAlertWithTitle("您已办理过个人办理，无法再次办理")
            return
        }
        if dataController.writeModel.data.nowCount == "0" && index == 1{
            LHAlertView.showTipAlertWithTitle("请先进行个人办理")
            return
        }
        
        
        
        if index == 0{
            let dic:NSMutableDictionary = [
                "title":"个人办理",
                "type":"0"
            ]
            pushViewController("IdCardQueryViewController",sender:dic)
        }else if index == 1 {
            let dic:NSMutableDictionary = [
                "title":"亲属代办",
                "type":"0"
            ]
            pushViewController("IdCardQueryViewController",sender:dic)
        }else if index == 2{//社保卡进度查询
            pushViewController("SbkProgressViewController")
        }
        
    }
    func ZhiKaClick() {
        let webVc = CommonWebViewController()
        webVc.urlContent = MyConfig.shared().zhikajinduUrl
        webVc.titleContent = "制卡进度查询"
        webVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVc, animated: true)
    }
}
