//
//  DropListTableViewCell.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/16.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class DropListTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    var title:String = ""{
        didSet{
            titleLabel.text = title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> DropListTableViewCell{
        let cellId:String = "DropListTableViewCellId"
        var cell:DropListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? DropListTableViewCell
        
        if (cell == nil || !cell!.isKind(of: DropListTableViewCell.self)){
            cell = DropListTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
        
    }
    
}
