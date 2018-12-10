//
//  ConfirmLoginView.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

typealias BindAccountLoginBlock = (_ id:String) ->Void
class ConfirmLoginView: UIView {
    
    @IBOutlet var tableView: UITableView!

    var isFlag = false//是否勾选了学生或者学校
    
    var cellCount = 0
    
    var model:BindAccountModel!
    var bindAccountLoginBlock:BindAccountLoginBlock!
    @IBAction func loginBtnClick(_ sender: Any) {
       
        
        
        
        
    }
    func update(dic:NSMutableDictionary){
        if dic["model"] != nil {
            self.model = dic["model"] as! BindAccountModel
        }
        if dic["block"] != nil {
            self.bindAccountLoginBlock = dic["block"] as! BindAccountLoginBlock
        }
    
        initUI()
    }
    fileprivate func initUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("ConfirmLoginPwdTableViewCell")
        tableView.register("ConfirmLoginSelectStrOrSchoolTableViewCell")
        
    }
}
extension ConfirmLoginView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = ConfirmLoginPwdTableViewCell.loadCell(tableView)
           
            cell.update(model: self.model)
            return cell
            
        }else{
            let cell = ConfirmLoginSelectStrOrSchoolTableViewCell.loadCell(tableView)
           
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
           
            self.tableView.reloadData()
        }
    }
}
