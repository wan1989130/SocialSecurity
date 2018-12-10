//
//  PersonMessageTipTableViewCell.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class PersonMessageTipTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> PersonMessageTipTableViewCell{
        let cellId:String = "PersonMessageTipTableViewCellId"
        var cell:PersonMessageTipTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? PersonMessageTipTableViewCell
        
        if (cell == nil || !cell!.isKind(of: PersonMessageTipTableViewCell.self)){
            cell = PersonMessageTipTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
