//
//  CaijiBasicIdCardTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CaijiBasicIdCardTableViewCell: UITableViewCell {
    @IBOutlet weak var idCardView: UIView!
    @IBOutlet weak var idCardViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var basicBgView: JQRadiusView!
    @IBOutlet weak var fanButton: UIButton!
    @IBOutlet weak var zhengButton: UIButton!
    
    @IBAction func fanButtonClick(_ sender: Any) {
        
    }
    @IBAction func zhengButtonClick(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        zhengButton.backgroundColor = UIColor(hexString: "005191")
        
        zhengButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) //文字大小
        zhengButton.set(image: UIImage(named: "ic_camera"), title: "拍摄", titlePosition: .bottom, additionalSpacing: 3, state: .normal)
        fanButton.backgroundColor = UIColor(hexString: "005191")
        
        fanButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) //文字大小
        fanButton.set(image: UIImage(named: "ic_camera"), title: "拍摄", titlePosition: .bottom, additionalSpacing: 3, state: .normal)
        basicBgView.layer.borderWidth = 1
        basicBgView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
    }

    func update(flag:Bool){
        if flag{
            idCardView.removeAllSubviews()
            idCardViewHeightConstraint.constant = 0
        }
        
    }
    class func loadCell(_ tableView:UITableView)-> CaijiBasicIdCardTableViewCell{
        let cellId:String = "CaijiBasicIdCardTableViewCellId"
        var cell:CaijiBasicIdCardTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CaijiBasicIdCardTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CaijiBasicIdCardTableViewCell.self)){
            cell = CaijiBasicIdCardTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
