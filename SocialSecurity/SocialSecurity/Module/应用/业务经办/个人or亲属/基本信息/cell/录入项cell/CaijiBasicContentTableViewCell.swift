//
//  CaijiBasicContentTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/20.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
protocol CaijiBasicContentSelectProtocol:class {
    func xbClick()
    func zjlxClick()
    func csrqClick()
    func zjyxqClick()
    func mzClick()
    func txdzChange(_ height:CGFloat)
}

class CaijiBasicContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var waiBgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var txdzViewHeight: NSLayoutConstraint!
    @IBOutlet weak var xmTextField: UITextField!
    @IBOutlet weak var xbTextField: UITextField!
    @IBOutlet weak var zjlxTextField: UITextField!
    @IBOutlet weak var zjhmTextField: UITextField!
    @IBOutlet weak var csrqTextField: UITextField!
    @IBOutlet weak var zjyxqTextField: UITextField!
    @IBOutlet weak var mzTextField: UITextField!
    @IBOutlet weak var txdzTextView: UIPlaceholderTextView!
    var tableView:UITableView!
    
    weak var pro:CaijiBasicContentSelectProtocol!
    var indexPath:IndexPath!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        xbTextField.delegate = self
        zjlxTextField.delegate = self
        csrqTextField.delegate = self
        zjyxqTextField.delegate = self
        mzTextField.delegate = self
        
        xmTextField.delegate = self
        zjhmTextField.delegate = self
        txdzTextView.delegate = self
        
        txdzTextView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        txdzTextView.isScrollEnabled = false
        txdzTextView.showsVerticalScrollIndicator = false
        txdzTextView.showsHorizontalScrollIndicator = false
        txdzTextView.placeholder = "请输入通信地址"
        txdzTextView.textColor = UIColor.darkGray
        
        bgView.clipsToBounds = true
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
    }
    func update(tableView:UITableView,model:CaijiSaveModel,isWrite:Bool,indexPath:IndexPath){
        self.indexPath = indexPath
        xmTextField.text = model.name
        xbTextField.text = model.sex
        zjlxTextField.text = model.zjlx
        zjhmTextField.text = model.zjhm
        csrqTextField.text = model.csrq
        zjyxqTextField.text = model.zjyxq
        mzTextField.text = model.mz
        if model.txdz != ""{
            txdzTextView.text = model.txdz
        }else{
            
        }
        
        
        xmTextField.isEnabled = isWrite
        xbTextField.isEnabled = isWrite
        zjlxTextField.isEnabled = isWrite
        zjhmTextField.isEnabled = isWrite
        csrqTextField.isEnabled = isWrite
        zjyxqTextField.isEnabled = isWrite
        mzTextField.isEnabled = isWrite
        txdzTextView.isEditable = isWrite
        
        
        self.tableView = tableView
//        txdzTextView.text = "aaaa请输入通信地址请输入通信地址请输入通信地址请输入通信地址请输入通信地址1请输入通信地址2"
         var temBounds = txdzTextView.bounds
        let constraint = CGSize(width: temBounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let size = txdzTextView.sizeThatFits(constraint)
        temBounds.size = size
        //            textView.bounds = bounds2
        waiBgViewHeight.constant = 44 * 8 + size.height + 16
        txdzViewHeight.constant = size.height + 16
        
    }
    
    class func loadCell(_ tableView:UITableView)-> CaijiBasicContentTableViewCell{
        let cellId:String = "CaijiBasicContentTableViewCellId"
        var cell:CaijiBasicContentTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CaijiBasicContentTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CaijiBasicContentTableViewCell.self)){
            cell = CaijiBasicContentTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
   
    
}
extension CaijiBasicContentTableViewCell:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == xbTextField{
            pro.xbClick()
            return false
        }else if textField == zjlxTextField{
            pro.zjlxClick()
            return false
        }else if textField == csrqTextField{
            pro.csrqClick()
            return false
        }else if textField == zjyxqTextField{
            pro.zjyxqClick()
            return false
        }else if textField == mzTextField{
            pro.mzClick()
            return false
        }
        return true
    }
}
extension CaijiBasicContentTableViewCell:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == (txdzTextView as UITextView){
            
            var flag = false
            for item in self.tableView.visibleCells{
                if item == self{
                    flag = true
                }
            }
            if !flag{
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
            var temBounds = textView.bounds
            
            let constraint = CGSize(width: temBounds.size.width, height: CGFloat.greatestFiniteMagnitude)
            let size = textView.sizeThatFits(constraint)
            temBounds.size = size
//            textView.bounds = bounds2
            waiBgViewHeight.constant = 44 * 8 + size.height + 16
            txdzViewHeight.constant = size.height + 16
//            model.sendCardAddress = textView.text
            pro.txdzChange(waiBgViewHeight.constant + 16)
            UIView.performWithoutAnimation {
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
        
    }
}
