//
//  PhotoShowTitleTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/1/14.
//  Copyright © 2019年 王岩. All rights reserved.
//

import UIKit

class PhotoShowTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> PhotoShowTitleTableViewCell{
        let cellId:String = "PhotoShowTitleTableViewCellId"
        var cell:PhotoShowTitleTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? PhotoShowTitleTableViewCell
        
        if (cell == nil || !cell!.isKind(of: PhotoShowTitleTableViewCell.self)){
            cell = PhotoShowTitleTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
