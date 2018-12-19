//
//  CaijiBasicViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CaijiBasicViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    var dataController:CaijiBasicDataController!
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        initUI()
    }


  

}
extension CaijiBasicViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("CaijiBasicIdCardTableViewCell")
        tableView.register("CaijiBasicNormalTableViewCell")
        tableView.register("CaijiBasicSaveTableViewCell")
        
    }
    fileprivate func initData(){
        dataController = CaijiBasicDataController(delegate: self)
        if senderParam != nil{
            title = senderParam as! String
        }
    }
    
}
extension CaijiBasicViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = CaijiBasicIdCardTableViewCell.loadCell(tableView)
            cell.update(flag: true)
            return cell
        }else if indexPath.row == 8{
            let cell = CaijiBasicSaveTableViewCell.loadCell(tableView)
            return cell
        }else{
            let cell = CaijiBasicNormalTableViewCell.loadCell(tableView)
            return cell
            
        }
    }
    
}
extension CaijiBasicViewController{
    
}
extension CaijiBasicViewController{
    
}
