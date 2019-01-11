//
//  MinePhotoHeaderTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/18.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class MinePhotoHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var headPhotoImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headPhotoImageView.layer.borderWidth = 1
        headPhotoImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
       
    }
    func update(){
        nickNameLabel.text = MyConfig.shared().userName
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let str = "&" + formatter.string(from: Date())
        headPhotoImageView.setImage(url: FileAccessHost + MyConfig.shared().headPhoto + str, placeholder: UIImage.init(named: "ic_head")!)
        phoneLabel.text = MyConfig.shared().phone
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
