//
//  ApplyCollectionTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
@objc protocol ApplyCollectionIndexClickProtocol:NSObjectProtocol {
    func collectionIndexClick(index:Int)
}
class ApplyCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var twoRadiusView: JQRadiusView!
    @IBOutlet weak var twoMsgLabel: UILabel!
    @IBOutlet weak var oneMsgLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusViewHeight: NSLayoutConstraint!
    @IBOutlet var collectionView: UICollectionView!
    var delegate:BaseViewController!
    var dataArray:Array<ApplyToolModel> = [ApplyToolModel]()
    @IBOutlet weak var oneLabel: UILabel!
    weak var pro:ApplyCollectionIndexClickProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
    }
    func update(model:SelfQueryItemModel){
//        statusView.isHidden = false
//        model.status = "2"
//        model.msg = "a,b"
        if model.status == "0"{
            statusViewHeight.constant = 0
            statusView.removeAllSubviews()
//            statusView.isHidden = true
        }else if model.status == "1"{
            if model.statusMsg != ""{
                let array = model.statusMsg.components(separatedBy: ",")
                oneMsgLabel.text = array[0]
                twoMsgLabel.text = array[1]
            }
            
            oneLabel.layer.borderColor = UIColor(hexString: "005191")?.cgColor
            oneLabel.layer.borderWidth = 2
            oneLabel.layer.cornerRadius = 15
            oneLabel.backgroundColor = UIColor.white
            oneLabel.clipsToBounds = true
            
            
            twoLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            twoLabel.layer.borderWidth = 2
            twoLabel.layer.cornerRadius = 15
            twoLabel.backgroundColor = UIColor(hexString:"aaaaaa")
            twoLabel.clipsToBounds = true
        }else if model.status == "2"{
            if model.statusMsg != ""{
                let array = model.statusMsg.components(separatedBy: ",")
                oneMsgLabel.text = array[0]
                twoMsgLabel.text = array[1]
            }
            
            oneLabel.layer.borderColor = UIColor(hexString: "005191")?.cgColor
            oneLabel.layer.borderWidth = 2
            oneLabel.layer.cornerRadius = 15
            oneLabel.backgroundColor = UIColor.white
            oneLabel.clipsToBounds = true
            
            twoRadiusView.backgroundColor = UIColor(hexString: "005191")
            twoLabel.layer.borderColor = UIColor(hexString: "005191")?.cgColor
            twoLabel.layer.borderWidth = 2
            twoLabel.layer.cornerRadius = 15
            twoLabel.backgroundColor = UIColor.white
            twoLabel.clipsToBounds = true
        }else if model.status == "3"{
            if model.statusMsg != ""{
                let array = model.statusMsg.components(separatedBy: ",")
                oneMsgLabel.text = array[0]
                twoMsgLabel.text = array[1]
            }
            
            oneLabel.layer.borderColor = UIColor(hexString: "005191")?.cgColor
            oneLabel.layer.borderWidth = 2
            oneLabel.layer.cornerRadius = 15
            oneLabel.backgroundColor = UIColor.white
            oneLabel.clipsToBounds = true
            
            
            twoRadiusView.backgroundColor = UIColor(hexString: "005191")
            twoLabel.layer.borderColor = UIColor(hexString: "005191")?.cgColor
            twoLabel.layer.borderWidth = 2
            twoLabel.layer.cornerRadius = 15
            twoLabel.backgroundColor = UIColor.white
            twoLabel.clipsToBounds = true
        }
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
        layout.itemSize = CGSize(width:(ScreenWidth)/2,height:(ScreenWidth)/2)
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
        if indexPath.row % 2 > 0{
            cell.leftLabel.isHidden = true
        }else{
            cell.leftLabel.isHidden = false
        }
        if indexPath.row == 1{
            cell.nameLabel.font = UIFont.systemFont(ofSize: 16)
            cell.nameLabel.textColor = UIColor.red
        }else{
            cell.nameLabel.font = UIFont.systemFont(ofSize: 13)
            cell.nameLabel.textColor = UIColor(hexString: "555555")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pro.collectionIndexClick(index: indexPath.row)
    }
}
