//
//  InformationMessageListTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class InformationMessageListTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(model:InformationMessageModel){
        titleLabel.text = model.title
        timeLabel.text = model.createTime
    }

    class func loadCell(_ tableView:UITableView)-> InformationMessageListTableViewCell{
        let cellId:String = "InformationMessageListTableViewCellId"
        var cell:InformationMessageListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? InformationMessageListTableViewCell
        
        if (cell == nil || !cell!.isKind(of: InformationMessageListTableViewCell.self)){
            cell = InformationMessageListTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
