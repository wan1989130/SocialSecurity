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
        loadRequest()
    }


}
extension YwjbViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = UIColor(hexString: "ECF5FE")

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
//        let parameter:NSMutableDictionary = ["id":"9000"]
//        
//        dataController.getApply(parameter: parameter) { (isSucceed, info) in
//            if isSucceed {
//                self.getCarouselList()
//                //                self.tableView.reloadData()
//            }else {
//                //TODO
//                
//            }
//        }
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
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return ScreenWidth * 480 / 1080
        }else {
            let height = ((ScreenWidth - 4) / 3) * CGFloat(ceil(Double((4)) / 3)) + 1
            return height + 61 + 0.01
        }
        
    }
}
