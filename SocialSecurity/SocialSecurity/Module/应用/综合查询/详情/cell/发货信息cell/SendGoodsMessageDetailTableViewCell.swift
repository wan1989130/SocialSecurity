//
//  SendGoodsMessageDetailTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class SendGoodsMessageDetailTableViewCell: UITableViewCell,UITextViewDelegate {
    
    
    
    @IBOutlet weak var smsNumTextField: UITextField!//物流单号
    @IBOutlet weak var nameTextField: UITextField!//货物名称
    @IBOutlet weak var sendPhoneTextField: UITextField!//发货人电话
    @IBOutlet weak var sendDateButton: UIButton!//发货时间
    
    @IBOutlet weak var sendAddressButton: UIButton!//发货人地址
    @IBOutlet weak var sendAddressIconButton: UIButton!//发货人地址和发货时间右图标
    @IBOutlet weak var detailAddressLabel: UILabel!//详细地址
    
    @IBOutlet weak var selectAddressButton: UIButton!
    @IBOutlet weak var selectTimeButton: UIButton!

    var tableView:UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
        
      
        
        
    }

    //详情用
    func updateDetail(model:DeliverGoodsSaveModel){
        sendAddressIconButton.isHidden = true
        smsNumTextField.isEnabled = false
        nameTextField.isEnabled = false
        sendPhoneTextField.isEnabled = false
        sendDateButton.isEnabled = false
        
        sendAddressButton.isEnabled = false
        
        smsNumTextField.text = model.smsNum
        nameTextField.text = model.name
        sendPhoneTextField.text = model.sendPhone
        sendDateButton.setTitle(model.sendDate, for: .normal)
        detailAddressLabel.text = model.sendAddress
        sendAddressButton.setTitle(model.sendANameParentP + model.sendANameParent + model.sendAName, for: .normal)
    }
    
    
 
    class func loadCell(_ tableView:UITableView)-> SendGoodsMessageDetailTableViewCell{
        let cellId:String = "SendGoodsMessageDetailTableViewCellId"
        var cell:SendGoodsMessageDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SendGoodsMessageDetailTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SendGoodsMessageDetailTableViewCell.self)){
            cell = SendGoodsMessageDetailTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
