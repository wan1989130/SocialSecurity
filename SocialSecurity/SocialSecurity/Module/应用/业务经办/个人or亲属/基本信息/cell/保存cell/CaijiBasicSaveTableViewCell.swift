//
//  CaijiBasicSaveTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
protocol CaijiBasicNextProtocol:class {
    func nextClick()
}
class CaijiBasicSaveTableViewCell: UITableViewCell {

    @IBAction func nextClick(_ sender: Any) {
        pro.nextClick()
    }
    weak var pro:CaijiBasicNextProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   

    class func loadCell(_ tableView:UITableView)-> CaijiBasicSaveTableViewCell{
        let cellId:String = "CaijiBasicSaveTableViewCellId"
        var cell:CaijiBasicSaveTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CaijiBasicSaveTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CaijiBasicSaveTableViewCell.self)){
            cell = CaijiBasicSaveTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
    
}
