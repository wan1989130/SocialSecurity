//
//  ApplyCollectionTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ApplyCollectionTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    var delegate:BaseViewController!
    var dataArray:Array<ApplyToolModel> = [ApplyToolModel]()
    @IBOutlet weak var oneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        oneLabel.layer.borderColor = UIColor(hexString: "28C8C8")?.cgColor
        oneLabel.layer.borderWidth = 2
        oneLabel.layer.cornerRadius = 15
        oneLabel.backgroundColor = UIColor.white
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
        layout.itemSize = CGSize(width:(ScreenWidth - 4)/3,height:(ScreenWidth - 4)/3)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
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
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        
        
      
    }
    
}
