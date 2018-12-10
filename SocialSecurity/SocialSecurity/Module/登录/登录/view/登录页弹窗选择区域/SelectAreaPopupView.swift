//
//  SelectAreaPopupView.swift
//  MiddleSchool2
//
//  Created by 李琪 on 2017/12/27.
//  Copyright © 2017年 王岩. All rights reserved.
//

import UIKit

class SelectAreaPopupView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var alertLabel: UILabel!
    
    
    var completionBlock:(() -> Void)?
    
    var areaList:Array<BaseAreaListModel> = [BaseAreaListModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.setCornerWithRadius(8)
        pointLabel.setCornerWithRadius(3)
        initTableView()
    }
    
    func update(list:Array<BaseAreaListModel>, completionBlock:(() -> Void)?){
        self.completionBlock = completionBlock
        areaList = list
        tableView.isScrollEnabled = false
        if areaList.count <= 1 {
            tableViewHeightConstraint.constant = 44
        }
        else if areaList.count > 4{
            tableViewHeightConstraint.constant = 44 * 4
        }
        else{
            tableView.isScrollEnabled = true
            tableViewHeightConstraint.constant = 44 * CGFloat(areaList.count)
        }
        
        tableView.reloadData()
        
        var alertText = "提示:如果您所属区域不在区域列表范围内,请选择\"其他\"。"
        if list.count > 0{
            alertText = "提示:如果您所属区域不在区域列表范围内,请选择\"\(list[0].name)\"。"
        }
        alertLabel.text = alertText
    }
    
    func show(){
        self.drawInView(UIApplication.shared.keyWindow!)
        tableView.reloadData()
    }
    
    class func show(list:Array<BaseAreaListModel>, completionBlock:(() -> Void)?){
        let v = UIView.loadViewWithName("SelectAreaPopupView") as! SelectAreaPopupView
        v.update(list: list, completionBlock: completionBlock)
        v.show()
    }

    fileprivate func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register("SelectAreaPopupViewTableViewCell")
    }

}

extension SelectAreaPopupView: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectAreaPopupViewTableViewCell.loadCell(tableView)
        cell.update(areaList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UserDefaults.standard.setValue(self.areaList[indexPath.row].id, forKey: AreaIdSandBoxKey)
        UserDefaults.standard.setValue(self.areaList[indexPath.row].name, forKey: AreaNameSandBoxKey)
        HostAddress = self.areaList[indexPath.row].serviceUrl
        UserDefaults.standard.set(self.areaList[indexPath.row].serviceUrl, forKey: HostAddressSandBoxKey)

//        
//        UserDefaults.standard.set("", forKey: FileServerAddressSandBoxKey)
//        UserDefaults.standard.set("", forKey: FileServerUploadAddressSandBoxKey)
//        UserDefaults.standard.set("", forKey: AgreementHostSandBoxKey)
//        UserDefaults.standard.set("", forKey: ProjectFileServerWorkNameSandBoxKey)
        UserDefaults.standard.synchronize()
        MSDataProvider.initBaseClient()
        
        completionBlock?()
        self.removeFromSuperview()
    }
}
