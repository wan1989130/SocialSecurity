//
//  ComprehensiveQueryListTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class ComprehensiveQueryListTableViewCell: UITableViewCell {

    @IBOutlet weak var headPhotoImageView: UIImageView!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var sendTimeLabel: UILabel!
    @IBOutlet weak var sendNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
    func update(model:ComprehensiveQueryListModel){
        goodsNameLabel.text = model.name
        sendTimeLabel.text = model.sendDate
        sendNameLabel.text = model.sendName
        addressLabel.text = model.sendANameParentP + model.sendANameParent + "→" + model.getANameParentP + model.getANameParent
        var imageUrl = ""
        if model.sendPhoto.hasPrefix("/"){
            imageUrl = ( model.sendPhoto as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
        }else{
            imageUrl = model.sendPhoto
        }
        
        headPhotoImageView.sd_setImage(with: URL.init(string: HostAddress + imageUrl), placeholderImage: defaultImage, options: [], completed: nil)
    }

    class func loadCell(_ tableView:UITableView)-> ComprehensiveQueryListTableViewCell{
        let cellId:String = "ComprehensiveQueryListTableViewCellId"
        var cell:ComprehensiveQueryListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ComprehensiveQueryListTableViewCell
        
        if (cell == nil || !cell!.isKind(of: ComprehensiveQueryListTableViewCell.self)){
            cell = ComprehensiveQueryListTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }

}
