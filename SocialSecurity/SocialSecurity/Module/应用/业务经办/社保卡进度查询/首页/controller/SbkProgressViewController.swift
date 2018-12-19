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
    
    var str:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "采集进度查询"
        initData()
        initUI()
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
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SbkProgressTableViewCell.loadCell(tableView)
        cell.update()
        return cell
    }
    
}
extension SbkProgressViewController{
    
}
