//
//  GetPersonMessageTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

@objc protocol SelectGetPersonDelegate {
    func selectGetPersonAddress()
}

class GetPersonMessageTableViewCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!//收货人姓名
    @IBOutlet weak var phoneTextField: UITextField!//联系电话
    
    @IBOutlet weak var remarkTextView: UIPlaceholderTextView!
    @IBOutlet weak var detailAddress: UIPlaceholderTextView!
    
    var tableView:UITableView!
    var addressBlock:RefreshBlock?
    var remarkBlock:RefreshBlock?
    var delegate:SelectGetPersonDelegate?
    @IBAction func addressClick(_ sender: Any) {
        delegate?.selectGetPersonAddress()
    }
    @IBOutlet weak var selectAddressButton: UIButton!
    
    var model:DeliverGoodsSaveModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.delegate = self
        phoneTextField.delegate = self
        
        self.selectionStyle = .none
        
        detailAddress.delegate = self
        detailAddress.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        detailAddress.isScrollEnabled = false
        detailAddress.showsVerticalScrollIndicator = false
        detailAddress.showsHorizontalScrollIndicator = false
        
        remarkTextView.delegate = self
        remarkTextView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        remarkTextView.isScrollEnabled = false
        remarkTextView.showsVerticalScrollIndicator = false
        remarkTextView.showsHorizontalScrollIndicator = false
        
    }
    func update(tableView:UITableView,model:DeliverGoodsSaveModel){
        self.model = model
        nameTextField.text = model.getName
        phoneTextField.text = model.getPhone
        if model.tempGetAddress != ""{
            selectAddressButton.setTitle(model.tempGetAddress, for: .normal)
        }else{
            selectAddressButton.setTitle("请选择", for: .normal)
        }
        
        detailAddress.text = model.getAddress
        remarkTextView.text = model.remarks
        
        
        self.tableView = tableView
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
            var temBounds = textView.bounds
            
            let constraint = CGSize(width: temBounds.size.width, height: CGFloat.greatestFiniteMagnitude)
            let size = textView.sizeThatFits(constraint)
            temBounds.size = size
            textView.bounds = bounds
        if textView == detailAddress{
            model.getAddress = textView.text
        }else if textView == remarkTextView{
           model.remarks = textView.text
        }
        
        UIView.performWithoutAnimation {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
   
    class func loadCell(_ tableView:UITableView)-> GetPersonMessageTableViewCell{
        let cellId:String = "GetPersonMessageTableViewCellId"
        var cell:GetPersonMessageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? GetPersonMessageTableViewCell
        
        if (cell == nil || !cell!.isKind(of: GetPersonMessageTableViewCell.self)){
            cell = GetPersonMessageTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
extension GetPersonMessageTableViewCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            model.getName = newText
            //            if newText.characters.count >= 10{
            //                awardNameTextField.text = (newText as NSString).substring(to: 10)
            //                awardModel.awardName = awardNameTextField.text!
            //                return false
            //            }else{
            //                awardModel.awardName = newText
            //            }
        }else if textField == phoneTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            model.getPhone = newText
            
        }
        return true
    }
}
