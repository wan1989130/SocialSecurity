//
//  ZcznChildViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/1/14.
//  Copyright © 2019年 王岩. All rights reserved.
//

import UIKit

class ZcznChildViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataController:ZcznChildDataController!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        title = "政策指南"
    }


}
extension ZcznChildViewController{
    
        fileprivate func initUI(){
            self.view.backgroundColor = UIColor.init(hexString: "EDEDED")
            
            self.automaticallyAdjustsScrollViewInsets = false
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register("ZcznChildTableViewCell")
            
        }
        fileprivate func initData(){
            dataController = ZcznChildDataController(delegate: self)
        }
        
        
    
}
//extension ZcznChildViewController:UICollectionViewDelegate,UICollectionViewDataSource{
//    //每个区的item个数
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//
//        return model.childArray.count
//
//    }
//    //分区个数
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    //自定义cell
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZcznCollectionViewCell", for: indexPath) as! ZcznCollectionViewCell
//        cell.update(model: model.childArray[indexPath.row])
//        if indexPath.row > 2{
//            cell.topLabel.isHidden = true
//        }else{
//            cell.topLabel.isHidden = false
//        }
//        if indexPath.row % 3 > 0{
//            cell.leftLabel.isHidden = true
//        }else{
//            cell.leftLabel.isHidden = false
//        }
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        pushViewController("ZcznDetailViewController",sender:model.childArray[indexPath.row])
//    }
//}

extension ZcznChildViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.toolArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ZcznChildTableViewCell.loadCell(tableView)
        cell.update(model: dataController.toolArray[indexPath.row], delegate: self)
        return cell
    }
}
