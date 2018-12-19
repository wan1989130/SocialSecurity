//
//  SbkProgressTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class SbkProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(){
        var str = "SbkSbkSbkSbkSbkSbkSbkSbkSbkSbkSbkSbkSbkSbkSbk"
        statusLabel.text = str
        let statusLabelSize = str.getSize(withFont: UIFont.systemFont(ofSize: 14), forWidth: ScreenWidth - 16 - 8 - 60 - 8 - 16 - 8 - 4 - 48)
        viewHeightConstraint.constant = statusLabelSize.height + 60 + 1
    }

    class func loadCell(_ tableView:UITableView)-> SbkProgressTableViewCell{
        let cellId:String = "SbkProgressTableViewCellId"
        var cell:SbkProgressTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SbkProgressTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SbkProgressTableViewCell.self)){
            cell = SbkProgressTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
