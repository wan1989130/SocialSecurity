//
//  CompanyRegisterInputTableViewCell.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CompanyRegisterInputTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var keyLabel: UILabel!
    
    var limit:Int!
    var value = ""
    var key = ""
    var model:CompanyRegisterModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueTextField.delegate = self
    }
    
    func update(key:String,value:String,placeholder:String,limit:Int,model:CompanyRegisterModel){
        keyLabel.text = key
        valueTextField.text = value
        valueTextField.placeholder = placeholder
        self.limit = limit
        self.value = value
        self.model = model
        self.key = key
        if key == "负责人电话：" || key == "企业电话："{
            valueTextField.keyboardType = .numberPad
        }else{
            valueTextField.keyboardType = .default
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count >= limit{
            valueTextField.text = (newText as NSString).substring(to: limit)
            if key == "企业名称："{
                model.companyName = (newText as NSString).substring(to: limit)
            }else if key == "注册地址："{
                model.registerAddress = (newText as NSString).substring(to: limit)
            }else if key == "负  责  人："{
                model.responsiblePersonName = (newText as NSString).substring(to: limit)
            }else if key == "负责人电话："{
                model.responsiblePersonPhone = (newText as NSString).substring(to: limit)
            }else if key == "纳  税  号："{
                model.payNumber = (newText as NSString).substring(to: limit)
            }else if key == "企业电话："{
                model.companyPhone = (newText as NSString).substring(to: limit)
            }
            
            return false
        }
        if key == "企业名称："{
            model.companyName = newText
        }else if key == "注册地址："{
            model.registerAddress = newText
        }else if key == "负  责  人："{
            model.responsiblePersonName = newText
        }else if key == "负责人电话："{
            model.responsiblePersonPhone = newText
        }else if key == "纳  税  号："{
            model.payNumber = newText
        }else if key == "企业电话："{
            model.companyPhone = newText
        }
        
        
        return true
    }
    

    class func loadCell(_ tableView:UITableView)-> CompanyRegisterInputTableViewCell{
        let cellId:String = "CompanyRegisterInputTableViewCellId"
        var cell:CompanyRegisterInputTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CompanyRegisterInputTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CompanyRegisterInputTableViewCell.self)){
            cell = CompanyRegisterInputTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
