//
//  BindButtonTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class BindButtonTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> BindButtonTableViewCell{
        let cellId:String = "BindButtonTableViewCellId"
        var cell:BindButtonTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? BindButtonTableViewCell
        
        if (cell == nil || !cell!.isKind(of: BindButtonTableViewCell.self)){
            cell = BindButtonTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
