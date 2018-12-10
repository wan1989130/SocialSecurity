//
//  SendGoodsSaveButtonTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
@objc protocol SendGoodsSaveDelegate {
    func saveClick()
}
class SendGoodsSaveButtonTableViewCell: UITableViewCell {

    @IBAction func saveClick(_ sender: Any) {
        delegate?.saveClick()
    }
    var delegate:SendGoodsSaveDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> SendGoodsSaveButtonTableViewCell{
        let cellId:String = "SendGoodsSaveButtonTableViewCellId"
        var cell:SendGoodsSaveButtonTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SendGoodsSaveButtonTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SendGoodsSaveButtonTableViewCell.self)){
            cell = SendGoodsSaveButtonTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
