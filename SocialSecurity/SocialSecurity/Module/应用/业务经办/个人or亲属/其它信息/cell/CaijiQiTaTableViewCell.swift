//
//  CaijiQiTaTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/21.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

protocol CaijiQiTaContentSelectProtocol:class {
    func ryztClick()
    func gjClick()
    func hjxzClick()
    func klmyhClick()
    func zszyClick()
    func zshyClick()
    func yjqyClick()
}
class CaijiQiTaTableViewCell: UITableViewCell {
    @IBOutlet weak var ryztTextField: UITextField!//人员状态
    @IBOutlet weak var gjTextField: UITextField!//国籍
    @IBOutlet weak var hjxzTextField: UITextField!//户籍性质
    @IBOutlet weak var lxsjTextField: UITextField!//联系手机
    @IBOutlet weak var gddhTextField: UITextField!//固定电话
    @IBOutlet weak var yzbmTextField: UITextField!//邮政编码
    @IBOutlet weak var klmyhTextField: UITextField!//卡联名银行
    @IBOutlet weak var zszyTextField: UITextField!//专属置业
    @IBOutlet weak var zshyTextField: UITextField!//专属行业
    @IBOutlet weak var yjqyTextField: UITextField!//邮寄区域
   
    @IBOutlet weak var yjdzTextView: UIPlaceholderTextView!//邮寄地址
 
    var model:CaijiSaveModel!
    @IBOutlet weak var waiBgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var yjdzViewHeight: NSLayoutConstraint!
    var tableView:UITableView!
    @IBOutlet weak var bgView: UIView!
    weak var pro:CaijiQiTaContentSelectProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        ryztTextField.delegate = self
        gjTextField.delegate = self
        hjxzTextField.delegate = self
        lxsjTextField.delegate = self
        gddhTextField.delegate = self
        
        yzbmTextField.delegate = self
        klmyhTextField.delegate = self
        zszyTextField.delegate = self
        zshyTextField.delegate = self
        yjqyTextField.delegate = self
        yjdzTextView.delegate = self
        
        
        yjdzTextView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        yjdzTextView.isScrollEnabled = false
        yjdzTextView.showsVerticalScrollIndicator = false
        yjdzTextView.showsHorizontalScrollIndicator = false
        yjdzTextView.placeholder = "请输入通信地址"
        
        bgView.clipsToBounds = true
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
    }

    func update(tableView:UITableView,model:CaijiSaveModel,isWrite:Bool){
        self.model = model
        ryztTextField.text = model.ryztName
        gjTextField.text = model.gjName
        hjxzTextField.text = model.hjxzName
        lxsjTextField.text = model.lxsjStr1
        gddhTextField.text = model.lxdhStr1
        yzbmTextField.text = model.yzbm
        klmyhTextField.text = model.klmyhName
        zszyTextField.text = model.zszyName
        zshyTextField.text = model.zshyName
        if model.provinceName == ""{
            yjqyTextField.text = ""
        }else{
            yjqyTextField.text = model.provinceName + "-" + model.cityName + "-" + model.regionName
        }
        if model.yjdz == ""{
            yjdzTextView.placeholder = "请输入通信地址"
        }else{
            yjdzTextView.text = model.yjdz
        }
        
//

        
        
        
        
        self.tableView = tableView
//        yjdzTextView.text = "aaaa请输入通信地址请输入通信地址请输入通信地址请输入通信地址请输入通信地址1请输入通信地址2"
        var temBounds = yjdzTextView.bounds
        let constraint = CGSize(width: temBounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let size = yjdzTextView.sizeThatFits(constraint)
        temBounds.size = size
        //            textView.bounds = bounds2
        waiBgViewHeight.constant = 44 * 11 + size.height + 16 + 20
        yjdzViewHeight.constant = size.height + 16
        
    }
    
    
    class func loadCell(_ tableView:UITableView)-> CaijiQiTaTableViewCell{
        let cellId:String = "CaijiQiTaTableViewCellId"
        var cell:CaijiQiTaTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CaijiQiTaTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CaijiQiTaTableViewCell.self)){
            cell = CaijiQiTaTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
extension CaijiQiTaTableViewCell:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == ryztTextField{
            pro.ryztClick()
            return false
        }else if textField == gjTextField{
            pro.gjClick()
            return false
        }else if textField == hjxzTextField{
            pro.hjxzClick()
            return false
        }else if textField == hjxzTextField{
            pro.hjxzClick()
            return false
        }else if textField == klmyhTextField{
            pro.klmyhClick()
            return false
        }else if textField == zszyTextField{
            pro.zszyClick()
            return false
        }else if textField == zshyTextField{
            pro.zshyClick()
            return false
        }else if textField == yjqyTextField{
            pro.yjqyClick()
            return false
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == yzbmTextField{//邮政编码
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.characters.count >= 6{
                yzbmTextField.text = (newText as NSString).substring(to: 6)
                model.yzbm = yzbmTextField.text!
                return false
            }else{
                model.jhrzh = newText
            }
        }else if textField == lxsjTextField{//联系手机
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.characters.count >= 11{
                lxsjTextField.text = (newText as NSString).substring(to: 11)
                model.lxsjStr1 = lxsjTextField.text!
                return false
            }else{
                model.jhrxm = newText
            }
        }else if textField == gddhTextField{//固定电话
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.characters.count >= 20{
                gddhTextField.text = (newText as NSString).substring(to: 20)
                model.lxdhStr1 = yzbmTextField.text!
                return false
            }else{
                model.lxdhStr1 = newText
            }
        }
        return true
    }
}
extension CaijiQiTaTableViewCell:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == (yjdzTextView as UITextView){
            if (textView.markedTextRange == nil && textView.text.characters.count >= 100) {
                if textView.text != nil{
                    textView.text = (textView.text! as NSString).substring(to: 100)
                    
                    model.yjdz = textView.text
                }
            }else{
                model.yjdz = textView.text
            }
            
            var temBounds = textView.bounds
            let constraint = CGSize(width: temBounds.size.width, height: CGFloat.greatestFiniteMagnitude)
            let size = textView.sizeThatFits(constraint)
            temBounds.size = size
            //            textView.bounds = bounds2
            waiBgViewHeight.constant = 44 * 11 + size.height + 16 + 20
            yjdzViewHeight.constant = size.height + 16
            //            model.sendCardAddress = textView.text
            UIView.performWithoutAnimation {
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
        
    }
}
