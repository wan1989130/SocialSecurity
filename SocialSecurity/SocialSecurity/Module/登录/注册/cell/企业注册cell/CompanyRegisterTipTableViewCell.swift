//
//  CompanyRegisterTipTableViewCell.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CompanyRegisterTipTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> CompanyRegisterTipTableViewCell{
        let cellId:String = "CompanyRegisterTipTableViewCellId"
        var cell:CompanyRegisterTipTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CompanyRegisterTipTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CompanyRegisterTipTableViewCell.self)){
            cell = CompanyRegisterTipTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
