//
//  AddressListTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class AddressListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(model:AddressListModel){
        nameLabel.text = model.name
    }
    class func loadCell(_ tableView:UITableView)-> AddressListTableViewCell{
        let cellId:String = "AddressListTableViewCellId"
        var cell:AddressListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? AddressListTableViewCell
        
        if (cell == nil || !cell!.isKind(of: AddressListTableViewCell.self)){
            cell = AddressListTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
