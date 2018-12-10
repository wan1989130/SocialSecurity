//
//  SelectAreaPopupViewTableViewCell.swift
//  MiddleSchool2
//
//  Created by 李琪 on 2017/12/27.
//  Copyright © 2017年 王岩. All rights reserved.
//

import UIKit

class SelectAreaPopupViewTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.setCornerWithRadius(4)
        
    }

    func update(_ model:BaseAreaListModel){
        titleLabel.text = model.name
    }
    
    class func loadCell(_ tableView:UITableView)-> SelectAreaPopupViewTableViewCell{
        let cellId:String = "SelectAreaPopupViewTableViewCellId"
        var cell:SelectAreaPopupViewTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SelectAreaPopupViewTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SelectAreaPopupViewTableViewCell.self)){
            cell = UIView.loadViewWithName("SelectAreaPopupViewTableViewCell") as? SelectAreaPopupViewTableViewCell
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
}
