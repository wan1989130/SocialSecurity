//
//  InformationMessageListViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ESPullToRefresh
class InformationMessageListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    var dataController:InformationMessageListDataController!
    var categoryId = ""
    var pageIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initUI()
        informationQueryByPage(loadType: .first)
    }
   



}
extension InformationMessageListViewController{
    fileprivate func initData(){
        dataController = InformationMessageListDataController(delegate: self)
        
    }
    
    fileprivate func initUI(){
        self.edgesForExtendedLayout = .top
        initTableView()
    }
    
    fileprivate func initTableView(){
        
   
        
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.clear
        
        tableView.register("InformationMessageListTableViewCell")
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
////            tableView.estimatedRowHeight = 0;
//            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            tableView.scrollIndicatorInsets = tableView.contentInset
//        } else {
//            // Fallback on earlier versions
//        }
     
//        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock:{
//            self.tableView.mj_footer.resetNoMoreData()
//            self.informationQueryByPage(loadType: .top)
//        })
//
//        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock:{
//            self.pageIndex = self.pageIndex + 1
//            self.informationQueryByPage(loadType: .down)
//        })
        let animator = ESRefreshHeaderAnimator()
        animator.pullToRefreshDescription = "下拉刷新"
        animator.releaseToRefreshDescription = "松开刷新"
        animator.loadingDescription = "加载中..."
        
        self.tableView.es.addPullToRefresh(animator: animator) {
            self.tableView.es.resetNoMoreData()
            self.informationQueryByPage(loadType: .top)
        }
        let animator2 = ESRefreshFooterAnimator()
        animator2.noMoreDataDescription = "没有更多的了"
        animator2.loadingMoreDescription = "正在加载更多"
        animator2.loadingDescription = "加载中..."
        
        self.tableView.es.addInfiniteScrolling(animator: animator2) {
            self.pageIndex = self.pageIndex + 1
            self.informationQueryByPage(loadType: .down)
        }
       
       
      
        
        
    
    }
}
// MARK: - TABLEVIEW代理
extension InformationMessageListViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = InformationMessageListTableViewCell.loadCell(tableView)
        cell.update(model: dataController.dataArray[indexPath.row])
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
       
        pushViewController("InformationMessageDetailViewController",sender:dataController.dataArray[indexPath.row].id)
    }
}
// MARK: - 接口
extension InformationMessageListViewController {
    fileprivate func informationQueryByPage(loadType:DirectionType) {
        if loadType == .first || loadType == .top{
            self.dataController.dataArray.removeAll()
            pageIndex = 1
        }
        let parameter:NSMutableDictionary = [
            "pageNo":String(pageIndex),
            "categoryId":self.categoryId
            ]
        dataController.informationList(parameter: parameter) { (isSucceed, result) in
            self.endLoad()
            if self.pageIndex <= self.dataController.lastPage{
                if loadType == .top {
                    self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
                    

                    self.dataController.dataArray.removeAll()
                }else if loadType == .down{
                    self.tableView.es.stopLoadingMore()
                }
                if self.dataController.model.data.count > 0{
                    for item in self.dataController.model.data{
                        self.dataController.dataArray.append(item)
                    }
                }
            }else{
                if loadType == .top {
                    self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
                }else if loadType == .down{
//                    self.tableView.es.stopLoadingMore()
                    self.tableView.es.noticeNoMoreData()
                }
            }
            self.tableView.reloadData()
        }
    }
}
