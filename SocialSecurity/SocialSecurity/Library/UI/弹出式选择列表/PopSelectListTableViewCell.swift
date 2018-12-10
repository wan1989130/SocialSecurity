//
//  PopSelectListTableViewCell.swift
//  MiddleSchool2_teacher
//
//  Created by 王岩 on 2017/5/15.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class PopSelectListTableViewCell: UITableViewCell {
    @IBOutlet var contentLabel: UILabel!
    var contentText : String{
        get{
            return contentLabel.text == nil ? "":contentLabel.text!
        }
        set{
            contentLabel.text = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func loadCell(_ tableView:UITableView)-> PopSelectListTableViewCell{
        let cellId:String = "PopSelectListTableViewCellId"
        var cell:PopSelectListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? PopSelectListTableViewCell
        
        if (cell == nil || !cell!.isKind(of: PopSelectListTableViewCell.self)){
            cell = PopSelectListTableViewCell.loadViewWithName("PopSelectListTableViewCell") as? PopSelectListTableViewCell
        }
        cell!.selectionStyle = .none
        return cell!
    }
}
