//
//  SelectCompanyViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class SelectCompanyViewController: BaseViewController {

    @IBOutlet weak var noDataLabel: UILabel!
    var searchName = ""
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var dataController:SelectCompanyDataController!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择所单位"
        initData()
        initUI()
        queryByNameList()
    }



}
extension SelectCompanyViewController{
    fileprivate func initData(){
        dataController = SelectCompanyDataController(delegate: self)
        
    }
    
    fileprivate func initUI(){
        searchBar.delegate = self
        initTableView()
    }
    
    fileprivate func initTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("SelectCompanyTableViewCell")
    }
}
extension SelectCompanyViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectCompanyTableViewCell.loadCell(tableView)
       cell.nameLabel.text = dataController.dataArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissBlock?(dataController.dataArray[indexPath.row])
        self.back()
    }
    
}
extension SelectCompanyViewController{
    fileprivate func queryByNameList() {
        
        let parameter:NSMutableDictionary = [
            "name":searchName
        ]
        
        dataController.selectCompany(parameter: parameter) { (isSucceed, result) in
            if isSucceed {
                if self.dataController.dataArray.count == 0{
                    self.noDataLabel.isHidden = false
                }else{
                    self.noDataLabel.isHidden = true
                }
                self.tableView.reloadData()
                
            }
        }
    }
}
extension SelectCompanyViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchName = searchBar.text ?? ""
        queryByNameList()
        
        //        searchBar.resignFirstResponder()
    }
  
}
