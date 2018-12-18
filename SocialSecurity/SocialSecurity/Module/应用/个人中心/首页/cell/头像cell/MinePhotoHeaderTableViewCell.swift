//
//  MinePhotoHeaderTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/18.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class MinePhotoHeaderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> MinePhotoHeaderTableViewCell{
        let cellId:String = "MinePhotoHeaderTableViewCellId"
        var cell:MinePhotoHeaderTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? MinePhotoHeaderTableViewCell
        
        if (cell == nil || !cell!.isKind(of: MinePhotoHeaderTableViewCell.self)){
            cell = MinePhotoHeaderTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
