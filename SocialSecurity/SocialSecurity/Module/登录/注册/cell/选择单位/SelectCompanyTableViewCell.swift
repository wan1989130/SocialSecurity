//
//  SelectCompanyTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class SelectCompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func loadCell(_ tableView:UITableView)-> SelectCompanyTableViewCell{
        let cellId:String = "SelectCompanyTableViewCellId"
        var cell:SelectCompanyTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SelectCompanyTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SelectCompanyTableViewCell.self)){
            cell = SelectCompanyTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
