//
//  ApplyTipTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/4/15.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit
@objc protocol ApplyTipTableViewCellClickProtocol:NSObjectProtocol {
    func ZhiKaClick()
}
class ApplyTipTableViewCell: UITableViewCell {

    weak var pro:ApplyTipTableViewCellClickProtocol!
    @IBOutlet weak var zhiKaImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
       zhiKaImageView.isUserInteractionEnabled = true
        zhiKaImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click)))
    }
    @objc func click(){
        pro.ZhiKaClick()
    }

    class func loadCell(_ tableView:UITableView)-> ApplyTipTableViewCell{
        let cellId:String = "ApplyTipTableViewCellId"
        var cell:ApplyTipTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ApplyTipTableViewCell
        
        if (cell == nil || !cell!.isKind(of: ApplyTipTableViewCell.self)){
            cell = ApplyTipTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
