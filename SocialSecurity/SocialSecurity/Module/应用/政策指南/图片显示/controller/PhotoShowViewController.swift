//
//  PhotoShowViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/1/14.
//  Copyright © 2019年 王岩. All rights reserved.
//

import UIKit

class PhotoShowViewController: BaseViewController {

    
    @IBOutlet var tableView: UITableView!
    var model:ZcznModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }



}
extension PhotoShowViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("PhotoShowTableViewCell")
        tableView.register("PhotoShowTitleTableViewCell")
        
        
    }
    fileprivate func initData(){
//        dataController = PhotoShowViewDataController(delegate: self)
//        if senderParam != nil && senderParam is Int{
//            dataController.initData(type: senderParam as! Int)
//        }
        if senderParam != nil{
            model = senderParam as! ZcznModel
        }
    }
}
extension PhotoShowViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + model.imageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = PhotoShowTitleTableViewCell.loadCell(tableView)
            return cell
        }else{
            let cell = PhotoShowTableViewCell.loadCell(tableView)
            cell.showImageView.image = UIImage.init(named: model.imageArray[indexPath.row - 1])
            return cell
        }
       
    }
}
