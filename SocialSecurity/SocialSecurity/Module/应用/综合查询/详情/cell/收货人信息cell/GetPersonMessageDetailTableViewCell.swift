//
//  GetPersonMessageDetailTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit



class GetPersonMessageDetailTableViewCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var getNameTextField: UITextField!//收货人姓名
    @IBOutlet weak var getPhoneTextField: UITextField!//联系电话
    @IBOutlet weak var selectAddressButton: UIButton!//收货地点
    @IBOutlet weak var detailAddressLabel: UILabel!//详细地点
    @IBOutlet weak var remarkLabel: UILabel!
    
    @IBOutlet weak var remarkTextView: UIPlaceholderTextView!
    @IBOutlet weak var detailAddress: UIPlaceholderTextView!
    
    var tableView:UITableView!
    var addressBlock:RefreshBlock?
    var remarkBlock:RefreshBlock?
    var delegate:SelectGetPersonDelegate?
    @IBAction func addressClick(_ sender: Any) {
        delegate?.selectGetPersonAddress()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    
        
    }
    func updateDetail(model:DeliverGoodsSaveModel){
        getNameTextField.text = model.getName
        getPhoneTextField.text = model.getPhone
        selectAddressButton.setTitle(model.getANameParentP + model.getANameParent + model.getAName, for: .normal)
        detailAddressLabel.text = model.getAddress
        remarkLabel.text = model.remarks
    }
   
    class func loadCell(_ tableView:UITableView)-> GetPersonMessageDetailTableViewCell{
        let cellId:String = "GetPersonMessageDetailTableViewCellId"
        var cell:GetPersonMessageDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? GetPersonMessageDetailTableViewCell
        
        if (cell == nil || !cell!.isKind(of: GetPersonMessageDetailTableViewCell.self)){
            cell = GetPersonMessageDetailTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
