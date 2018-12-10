//
//  BindAccountShowSchoolTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class BindAccountShowSchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(model:SchoolModel){
        contentLabel.text = model.schoolName
    }
    
    class func loadCell(_ tableView:UITableView)-> BindAccountShowSchoolTableViewCell{
        let cellId:String = "BindAccountShowSchoolTableViewCellId"
        var cell:BindAccountShowSchoolTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? BindAccountShowSchoolTableViewCell
        
        if (cell == nil || !cell!.isKind(of: BindAccountShowSchoolTableViewCell.self)){
            cell = BindAccountShowSchoolTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
