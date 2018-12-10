//
//  SendPersonMessageDetailTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class SendPersonMessageDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var sendCardImageView: UIImageView!//身份证图片
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var sendCardTextField: UITextField!
    @IBOutlet weak var chushengTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var minzuTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func updateDetail(model:DeliverGoodsSaveModel){
      
        
        addressLabel.text = model.sendCardAddress
        nameTextField.text = model.sendName
        sendCardTextField.text = model.sendCard
        chushengTextField.text = model.sendCsrq
        sexTextField.text = model.sendSex
        minzuTextField.text = model.sendMz
        var imageUrl = ""
        if model.sendPhoto.hasPrefix("/"){
            imageUrl = ( model.sendPhoto as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
        }else{
            imageUrl = model.sendPhoto
        }
        sendCardImageView.sd_setImage(with: URL.init(string: HostAddress + imageUrl), placeholderImage: defaultImage, options: [], completed: nil)
    }
   
    class func loadCell(_ tableView:UITableView)-> SendPersonMessageDetailTableViewCell{
        let cellId:String = "SendPersonMessageDetailTableViewCellId"
        var cell:SendPersonMessageDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SendPersonMessageDetailTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SendPersonMessageDetailTableViewCell.self)){
            cell = SendPersonMessageDetailTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
}
