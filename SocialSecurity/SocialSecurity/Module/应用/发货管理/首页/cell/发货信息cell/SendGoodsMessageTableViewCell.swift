//
//  SendGoodsMessageTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
typealias RefreshBlock = (_ content:String) -> Void

@objc protocol SelectSendAddressDelegate {
    func selectAddress()
    func selectTime()
}
class SendGoodsMessageTableViewCell: UITableViewCell,UITextViewDelegate {
    @IBOutlet weak var smsNumTextField: UITextField!//物流单号
    @IBOutlet weak var nameTextField: UITextField!//货物名称
    @IBOutlet weak var sendPhoneTextField: UITextField!//发货人电话
    @IBOutlet weak var sendDateButton: UIButton!//发货时间
    
    @IBOutlet weak var sendAddressButton: UIButton!//发货人地址
    @IBOutlet weak var sendAddressIconButton: UIButton!//发货人地址和发货时间右图标
    @IBOutlet weak var detailAddress: UIPlaceholderTextView!//详细地址
    
    @IBOutlet weak var selectAddressButton: UIButton!
    @IBOutlet weak var selectTimeButton: UIButton!
    @IBAction func selectTimeClick(_ sender: Any) {
        delegate?.selectTime()
    }
    var block:RefreshBlock?
    var model:DeliverGoodsSaveModel!
    
    var delegate:SelectSendAddressDelegate?
    @IBAction func addressClick(_ sender: Any) {
        
        delegate?.selectAddress()
    }
    
    var tableView:UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        smsNumTextField.delegate = self
        nameTextField.delegate = self
        sendPhoneTextField.delegate = self
        
        
        
        detailAddress.delegate = self
//        detailAddress.layer.cornerRadius = 4
//        detailAddress.layer.masksToBounds = true
//        detailAddress.layer.borderWidth = 1
//        detailAddress .layer.borderColor = UIColor.lightGray.cgColor
        //加下面一句话的目的是，是为了调整光标的位置，让光标出现在UITextView的正中间
        //        detailAddress.textContainerInset = UIEdgeInsetsMake(10,0, 10, 0)
//        detailAddress.placeholder = "请输入"
        self.selectionStyle = .none
        
        detailAddress.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        detailAddress.isScrollEnabled = false
        detailAddress.showsVerticalScrollIndicator = false
        detailAddress.showsHorizontalScrollIndicator = false
        detailAddress.textColor = UIColor.darkText
        
    }

  
    func update(tableView:UITableView,model:DeliverGoodsSaveModel){
        self.model = model
        smsNumTextField.text = model.smsNum
        nameTextField.text = model.name
        sendPhoneTextField.text = model.sendPhone
        if model.tempSendAddress != ""{
            selectAddressButton.setTitle(model.tempSendAddress, for: .normal)
        }else{
            selectAddressButton.setTitle("请选择", for: .normal)
        }
        
        detailAddress.text = model.sendAddress
        if model.sendDate != ""{
            selectTimeButton.setTitle(model.sendDate, for: .normal)
        }else{
            selectTimeButton.setTitle("请选择", for: .normal)
        }
        
        
        self.tableView = tableView
    }

    
    
    func textViewDidChange(_ textView: UITextView) {
    
        var temBounds = textView.bounds
        
        let constraint = CGSize(width: temBounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let size = textView.sizeThatFits(constraint)
        temBounds.size = size
        textView.bounds = bounds
        model.sendAddress = textView.text
        UIView.performWithoutAnimation {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }

  
 
    class func loadCell(_ tableView:UITableView)-> SendGoodsMessageTableViewCell{
        let cellId:String = "SendGoodsMessageTableViewCellId"
        var cell:SendGoodsMessageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SendGoodsMessageTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SendGoodsMessageTableViewCell.self)){
            cell = SendGoodsMessageTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
extension SendGoodsMessageTableViewCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == smsNumTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            model.smsNum = newText
            //            if newText.characters.count >= 10{
            //                awardNameTextField.text = (newText as NSString).substring(to: 10)
            //                awardModel.awardName = awardNameTextField.text!
            //                return false
            //            }else{
            //                awardModel.awardName = newText
            //            }
        }else if textField == nameTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            model.name = newText
            
        }else if textField == sendPhoneTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            model.sendPhone = newText
            
        }
        
        return true
    }
}
