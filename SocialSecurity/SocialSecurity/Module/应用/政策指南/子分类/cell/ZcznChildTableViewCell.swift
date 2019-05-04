//
//  ZcznChildTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/5/4.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit

class ZcznChildTableViewCell: UITableViewCell {

    var delegate:BaseViewController!
    var model:ZcznModel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
    }

    class func loadCell(_ tableView:UITableView)-> ZcznChildTableViewCell{
        let cellId:String = "ZcznChildTableViewCellId"
        var cell:ZcznChildTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ZcznChildTableViewCell
        
        if (cell == nil || !cell!.isKind(of: ZcznChildTableViewCell.self)){
            cell = ZcznChildTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    func update(model:ZcznModel,delegate:BaseViewController){
        let height = ((ScreenWidth) / 3) * CGFloat(ceil(Double((model.childArray.count)) / 3))
        
        bgViewHeight.constant = height + 30 + 0.01
        collectionViewHeight.constant = height + 0.01
        self.model = model
        self.delegate = delegate
        initUI()
    }
    fileprivate func initUI(){
        
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
}
extension ZcznChildTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
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
        cell.topLabel.isHidden = true
        cell.bottomLabel.isHidden = true
        cell.leftLabel.isHidden = true
        cell.rightLabel.isHidden = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.pushViewController("ZcznDetailViewController",sender:model.childArray[indexPath.row])
    }
}
