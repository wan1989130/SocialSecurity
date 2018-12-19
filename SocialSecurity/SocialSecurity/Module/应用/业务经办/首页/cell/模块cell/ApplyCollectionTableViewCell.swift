//
//  ApplyCollectionTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
@objc protocol ApplyCollectionIndexClickProtocol {
    func collectionIndexClick(index:Int)
}
class ApplyCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusViewHeight: NSLayoutConstraint!
    @IBOutlet var collectionView: UICollectionView!
    var delegate:BaseViewController!
    var dataArray:Array<ApplyToolModel> = [ApplyToolModel]()
    @IBOutlet weak var oneLabel: UILabel!
    var pro:ApplyCollectionIndexClickProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        oneLabel.layer.borderColor = UIColor(hexString: "005191")?.cgColor
        oneLabel.layer.borderWidth = 2
        oneLabel.layer.cornerRadius = 15
        oneLabel.backgroundColor = UIColor.white
        oneLabel.clipsToBounds = true
    }
    
    
 
    func initCell(delegate:BaseViewController,dataArray:Array<ApplyToolModel>){
        
        self.delegate = delegate
        self.dataArray = dataArray
        initUI()
    }
    class func loadCell(_ tableView:UITableView)-> ApplyCollectionTableViewCell{
        let cellId:String = "ApplyCollectionTableViewCellId"
        var cell:ApplyCollectionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ApplyCollectionTableViewCell
        
        if (cell == nil || !cell!.isKind(of: ApplyCollectionTableViewCell.self)){
            cell = ApplyCollectionTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
    
}
extension ApplyCollectionTableViewCell{
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

        collectionView.register(UINib.init(nibName: "ApplyViewControllerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ApplyViewControllerCollectionViewCell")
        collectionView?.backgroundColor = UIColor.clear
    }
}
//MARK: - Private
extension ApplyCollectionTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    //每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return dataArray.count
        
    }
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApplyViewControllerCollectionViewCell", for: indexPath) as! ApplyViewControllerCollectionViewCell
        cell.update(model: dataArray[indexPath.row])
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
        pro.collectionIndexClick(index: indexPath.row)
    }
}
