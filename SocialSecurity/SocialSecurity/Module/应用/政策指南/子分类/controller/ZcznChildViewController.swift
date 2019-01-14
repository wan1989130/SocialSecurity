//
//  ZcznChildViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/1/14.
//  Copyright © 2019年 王岩. All rights reserved.
//

import UIKit

class ZcznChildViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var model:ZcznModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        
    }


}
extension ZcznChildViewController{
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
        if senderParam != nil{
            model = senderParam as! ZcznModel
        }
    }
}
extension ZcznChildViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    //每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return model.childArray.count
        
    }
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZcznCollectionViewCell", for: indexPath) as! ZcznCollectionViewCell
        cell.update(model: model.childArray[indexPath.row])
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
        pushViewController("ZcznDetailViewController",sender:model.childArray[indexPath.row])
    }
}

extension ZcznChildViewController{
    
}
