//
//  PhotoShowTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/1/14.
//  Copyright © 2019年 王岩. All rights reserved.
//

import UIKit

class PhotoShowTableViewCell: UITableViewCell {

    @IBOutlet weak var showImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> PhotoShowTableViewCell{
        let cellId:String = "PhotoShowTableViewCellId"
        var cell:PhotoShowTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? PhotoShowTableViewCell
        
        if (cell == nil || !cell!.isKind(of: PhotoShowTableViewCell.self)){
            cell = PhotoShowTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
}
