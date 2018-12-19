//
//  CaijiBasicNormalTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CaijiBasicNormalTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> CaijiBasicNormalTableViewCell{
        let cellId:String = "CaijiBasicNormalTableViewCellId"
        var cell:CaijiBasicNormalTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CaijiBasicNormalTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CaijiBasicNormalTableViewCell.self)){
            cell = CaijiBasicNormalTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
    
}
