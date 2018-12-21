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
//        csrqTextField.text = model.csrq
//        zjyxqTextField.text = model.csrq
//
//
//        xmTextField.isEnabled = isWrite
//        xbTextField.isEnabled = isWrite
//        zjlxTextField.isEnabled = isWrite
//        zjhmTextField.isEnabled = isWrite
//        csrqTextField.isEnabled = isWrite
//        zjyxqTextField.isEnabled = isWrite
//        mzTextField.isEnabled = isWrite
//        txdzTextView.isEditable = isWrite
        
        
        self.tableView = tableView
        yjdzTextView.text = "aaaa请输入通信地址请输入通信地址请输入通信地址请输入通信地址请输入通信地址1请输入通信地址2"
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
}
extension CaijiQiTaTableViewCell:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == (yjdzTextView as UITextView){
            
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
