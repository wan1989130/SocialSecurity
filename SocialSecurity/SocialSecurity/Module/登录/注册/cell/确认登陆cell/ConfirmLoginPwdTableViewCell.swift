//
//  ConfirmLoginPwdTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ConfirmLoginPwdTableViewCell: UITableViewCell {

    @IBOutlet weak var studentOrSchoolLabel: UILabel!
    @IBOutlet weak var pwdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func update(model:BindAccountModel){
        userNameLabel.text = model.phone
        pwdLabel.text = model.pwd
    }

    class func loadCell(_ tableView:UITableView)-> ConfirmLoginPwdTableViewCell{
        let cellId:String = "ConfirmLoginPwdTableViewCellId"
        var cell:ConfirmLoginPwdTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ConfirmLoginPwdTableViewCell
        
        if (cell == nil || !cell!.isKind(of: ConfirmLoginPwdTableViewCell.self)){
            cell = ConfirmLoginPwdTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
