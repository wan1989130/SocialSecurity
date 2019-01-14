//
//  IxcjTypeViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class IxcjTypeViewController: BaseViewController {

    var isMax:Bool = true
    @IBOutlet var collectionView: UICollectionView!
    var dataController:IxcjTypeDataController!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "社会保障卡信息采集"
        initData()
        initUI()
        loadRequest()
    }

    deinit {
        print(("分类页面销毁"))
    }

}
extension IxcjTypeViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(ScreenWidth)/3,height:(ScreenWidth)/3)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        //        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        //注册一个cell
        
        collectionView.register(UINib.init(nibName: "ZcznCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ZcznCollectionViewCell")
        collectionView?.backgroundColor = UIColor.clear
        
    }
    fileprivate func initData(){
        dataController = IxcjTypeDataController(delegate: self)
    }
}
extension IxcjTypeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    //每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return dataController.toolArray.count
        
    }
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZcznCollectionViewCell", for: indexPath) as! ZcznCollectionViewCell
        cell.updateType(model: dataController.toolArray[indexPath.row])
        if indexPath.row > 2{
            cell.topLabel.isHidden = true
        }else{
            cell.topLabel.isHidden = false
        }
        if indexPath.row % 3 > 0{
            cell.leftLabel.isHidden = true
        }else{
            cell.leftLabel.isHidden = false
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataController.model == nil{
            return
        }
        if dataController.model.data.nowCount != "0" && !isMax{
            LHAlertView.showTipAlertWithTitle("您已办理过个人办理，无法再次办理")
            return
        }
        if dataController.model.data.nowCount == "0" && indexPath.row == 1{
            LHAlertView.showTipAlertWithTitle("请先进行个人办理")
            return
        }
        
        if indexPath.row <= 1 && isMax {
            LHAlertView.showTipAlertWithTitle("录入次数已达最大限制\(dataController.model.data.maxCount)")
            return
        }
        
        if indexPath.row == 0{
            let dic:NSMutableDictionary = [
                "title":"个人办理",
                "type":"0"
            ]
            pushViewController("IdCardQueryViewController",sender:dic)
        }else if indexPath.row == 1 {
            let dic:NSMutableDictionary = [
                "title":"亲属代办",
                "type":"0"
            ]
            pushViewController("IdCardQueryViewController",sender:dic)
        }else if indexPath.row == 2{//社保卡进度查询
            pushViewController("SbkProgressViewController")
        }
    }
}
extension IxcjTypeViewController{
    
    fileprivate func loadRequest(){
        let parameter:NSMutableDictionary = ["phone":MyConfig.shared().phone]
        weak var weakSelf = self
        dataController.getWriteCount(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                if weakSelf?.dataController.model.data.maxCount == weakSelf?.dataController.model.data.nowCount{
                    weakSelf?.isMax = true
                }else{
                    weakSelf?.isMax = false
                }
                weakSelf?.collectionView.reloadData()
            }else {
                //TODO
                
            }
        }
    }
}
