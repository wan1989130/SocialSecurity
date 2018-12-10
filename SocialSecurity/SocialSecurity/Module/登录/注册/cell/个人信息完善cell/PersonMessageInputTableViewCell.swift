//
//  PersonMessageInputTableViewCell.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class PersonMessageInputTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var keyLabel: UILabel!
    var limit:Int!
    var value = ""
    var key = ""
    var model:PersonMessageMode!
    override func awakeFromNib() {
        super.awakeFromNib()
        valueTextField.delegate = self
    }
    func update(key:String,value:String,placeholder:String,limit:Int,model:PersonMessageMode,imageName:String){
        keyLabel.text = key
        valueTextField.text = value
        valueTextField.placeholder = placeholder
        self.limit = limit
        self.value = value
        self.model = model
        self.key = key
        titleImageView.image = UIImage(named: imageName)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
      
        if newText.characters.count >= limit{
            valueTextField.text = (newText as NSString).substring(to: limit)
            if key == "姓        名："{
                model.realName = (newText as NSString).substring(to: limit)
            }else if key == "电        话："{
                model.phone = (newText as NSString).substring(to: limit)
            }else if key == "身份证号："{
                model.idCard = (newText as NSString).substring(to: limit)
            }else if key == "常用住址："{
                model.address = (newText as NSString).substring(to: limit)
            }else if key == "详细地址："{
                model.addressDetail = (newText as NSString).substring(to: limit)
            }
            return false
            
        }
        if key == "姓        名："{
            model.realName = newText
        }else if key == "电        话："{
            model.phone = newText
        }else if key == "身份证号："{
            model.idCard = newText
        }else if key == "常用住址："{
            model.address = newText
        }else if key == "详细地址："{
            model.addressDetail = newText
        }

        return true
    }

    class func loadCell(_ tableView:UITableView)-> PersonMessageInputTableViewCell{
        let cellId:String = "PersonMessageInputTableViewCellId"
        var cell:PersonMessageInputTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? PersonMessageInputTableViewCell
        
        if (cell == nil || !cell!.isKind(of: PersonMessageInputTableViewCell.self)){
            cell = PersonMessageInputTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
    
}
