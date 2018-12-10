//
//  RemarkTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/13.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class RemarkTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(model:RemarkModel){
        timeLabel.text = model.showTime
        contentLabel.text = model.content
        if model.time == ""{
            iconImageView.isHidden = true
        }else{
            iconImageView.isHidden = false
        }
    }

    class func loadCell(_ tableView:UITableView)-> RemarkTableViewCell{
        let cellId:String = "RemarkTableViewCellId"
        var cell:RemarkTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? RemarkTableViewCell
        
        if (cell == nil || !cell!.isKind(of: RemarkTableViewCell.self)){
            cell = RemarkTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
