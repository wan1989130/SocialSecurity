//
//  MineTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/18.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell {

    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> MineTableViewCell{
        let cellId:String = "MineTableViewCellId"
        var cell:MineTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? MineTableViewCell
        
        if (cell == nil || !cell!.isKind(of: MineTableViewCell.self)){
            cell = MineTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
