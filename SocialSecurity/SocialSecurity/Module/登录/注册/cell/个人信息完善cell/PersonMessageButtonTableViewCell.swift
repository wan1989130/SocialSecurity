//
//  PersonMessageButtonTableViewCell.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

protocol PersonMessageFinishProtocol {
    func personMessageFinishProtocol() -> Void
}
class PersonMessageButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var confirmBtn: UIButton!
    @IBAction func click(_ sender: Any) {
        if delegate != nil{
            delegate.personMessageFinishProtocol()
        }
    }
    var delegate:PersonMessageFinishProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    class func loadCell(_ tableView:UITableView)-> PersonMessageButtonTableViewCell{
        let cellId:String = "PersonMessageButtonTableViewCellId"
        var cell:PersonMessageButtonTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? PersonMessageButtonTableViewCell
        
        if (cell == nil || !cell!.isKind(of: PersonMessageButtonTableViewCell.self)){
            cell = PersonMessageButtonTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
    
}
