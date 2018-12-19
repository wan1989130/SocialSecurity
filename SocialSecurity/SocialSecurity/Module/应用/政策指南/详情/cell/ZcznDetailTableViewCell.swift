//
//  ZcznDetailTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class ZcznDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(model:ZcznDetailDataModel){
        titleLabel.text = model.title
    }
    class func loadCell(_ tableView:UITableView)-> ZcznDetailTableViewCell{
        let cellId:String = "ZcznDetailTableViewCellId"
        var cell:ZcznDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ZcznDetailTableViewCell
        
        if (cell == nil || !cell!.isKind(of: ZcznDetailTableViewCell.self)){
            cell = ZcznDetailTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
}
