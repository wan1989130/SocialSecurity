//
//  CompanyRegisterPhotoTableViewCell.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

typealias CompanyRegisterPhotoDeleteBlock = () ->Void
class CompanyRegisterPhotoTableViewCell: UITableViewCell {

    @IBAction func deleteBtnClick(_ sender: UIButton) {
        sender.isHidden = true
        if block != nil{
            block()
        }
    }
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var mustImageView: UIImageView!
    var block:CompanyRegisterPhotoDeleteBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(block:@escaping CompanyRegisterPhotoDeleteBlock){
        self.block = block
    }

    class func loadCell(_ tableView:UITableView)-> CompanyRegisterPhotoTableViewCell{
        let cellId:String = "CompanyRegisterPhotoTableViewCellId"
        var cell:CompanyRegisterPhotoTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CompanyRegisterPhotoTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CompanyRegisterPhotoTableViewCell.self)){
            cell = CompanyRegisterPhotoTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
