//
//  SendPersonMessageTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
@objc protocol SendPersonMessageCardClickDelegate {
    func cardImageSelect()
    func sendPersonMessageCardClickAgain()
}
class SendPersonMessageTableViewCell: UITableViewCell,UITextViewDelegate {

    @IBAction func isWriteClick(_ sender: UIButton) {
        if sender.tag == 1{
            nameTextField.isEnabled = true
            nameTextField.becomeFirstResponder()
        }else if sender.tag == 2{
            sexTextField.isEnabled = true
            sexTextField.becomeFirstResponder()
        }else if sender.tag == 3{
            mzTextField.isEnabled = true
            mzTextField.becomeFirstResponder()
        }else if sender.tag == 4{
            csrqTextField.isEnabled = true
            csrqTextField.becomeFirstResponder()
        }else if sender.tag == 5{
            cardTextField.isEnabled = true
            cardTextField.becomeFirstResponder()
        }else if sender.tag == 6{
            detailAddress.isEditable = true
            detailAddress.becomeFirstResponder()
        }
    }
    @IBOutlet weak var isWriteButton1: UIButton!
    @IBOutlet weak var isWriteButton2: UIButton!
    @IBOutlet weak var isWriteButton3: UIButton!
    @IBOutlet weak var isWriteButton4: UIButton!
    @IBOutlet weak var isWriteButton5: UIButton!
    @IBOutlet weak var isWriteButton6: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    @IBAction func againButtonClick(_ sender: Any) {
        delegate?.sendPersonMessageCardClickAgain()
    }
    @IBOutlet weak var againButton: UIButton!
    
    
    @IBOutlet weak var cardImageButton: UIButton!//身份证头像按钮
    
    @IBOutlet weak var cardImageSuccessLabel: UILabel!//身份证头像下label
    //身份证头像
    @IBAction func cardImageButtonClick(_ sender: Any) {
        delegate.cardImageSelect()
    }
    
    @IBOutlet weak var detailAddress: UIPlaceholderTextView!
    var tableView:UITableView!
    var delegate:SendPersonMessageCardClickDelegate!
    
    @IBOutlet weak var nameTextField: UITextField!//姓名
    @IBOutlet weak var sexTextField: UITextField!//性别
    @IBOutlet weak var mzTextField: UITextField!//民族
    @IBOutlet weak var csrqTextField: UITextField!//出生日期
    @IBOutlet weak var cardTextField: UITextField!//身份证
    
    var model:DeliverGoodsSaveModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        isShowWriteButton(flag: true)
        nameTextField.delegate = self
        sexTextField.delegate = self
        mzTextField.delegate = self
        csrqTextField.delegate = self
        cardTextField.delegate = self
        updateUI(isFlag: false)
        
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
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.selectImage))
        cardView.addGestureRecognizer(tap)
    }
    @objc func selectImage(){
        delegate.cardImageSelect()
    }
    func isShowWriteButton(flag:Bool){
        isWriteButton1.isHidden = flag
        isWriteButton2.isHidden = flag
        isWriteButton3.isHidden = flag
        isWriteButton4.isHidden = flag
        isWriteButton5.isHidden = flag
        isWriteButton6.isHidden = flag
    }

    @IBAction func noticeClick(_ sender: Any) {
        LHAlertView.showAlertWithTitle("", msg: "√仅识别二代身份证\n√避免反光和黑影，确保画质清晰\n√证件放正，减少杂乱背景画面") {
        }
    }
    func textViewDidChange(_ textView: UITextView) {

        if textView == (detailAddress as UITextView){
            var temBounds = textView.bounds
            
            let constraint = CGSize(width: temBounds.size.width, height: CGFloat.greatestFiniteMagnitude)
            let size = textView.sizeThatFits(constraint)
            temBounds.size = size
            textView.bounds = bounds
            model.sendCardAddress = textView.text
            UIView.performWithoutAnimation {
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
       
    }
    func updateUI(isFlag:Bool){
        nameTextField.isEnabled = isFlag
        sexTextField.isEnabled = isFlag
        mzTextField.isEnabled = isFlag
        csrqTextField.isEnabled = isFlag
        cardTextField.isEnabled = isFlag
        detailAddress.isEditable = isFlag
    }
    func update(tableView:UITableView,model:DeliverGoodsSaveModel){
        self.model = model
        nameTextField.text = model.sendName
        sexTextField.text = model.sendSex
        mzTextField.text = model.sendMz
        csrqTextField.text = model.sendCsrq
        cardTextField.text = model.sendCard
        detailAddress.text = model.sendCardAddress
        if model.imageSendPhoto != nil && model.sendPhoto != ""{
            cardImageButton.setImage(model.imageSendPhoto, for: .normal)
            cardImageSuccessLabel.isHidden = true
//            updateUI(isFlag: true)
        }else{
            cardImageButton.setImage(nil, for: .normal)
            cardImageSuccessLabel.isHidden = false
            updateUI(isFlag: false)
        }
        self.tableView = tableView
    }
    
    class func loadCell(_ tableView:UITableView)-> SendPersonMessageTableViewCell{
        let cellId:String = "SendPersonMessageTableViewCellId"
        var cell:SendPersonMessageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SendPersonMessageTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SendPersonMessageTableViewCell.self)){
            cell = SendPersonMessageTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
}
extension SendPersonMessageTableViewCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            model.sendName = newText
//            if newText.characters.count >= 10{
//                awardNameTextField.text = (newText as NSString).substring(to: 10)
//                awardModel.awardName = awardNameTextField.text!
//                return false
//            }else{
//                awardModel.awardName = newText
//            }
        }else if textField == sexTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            model.sendSex = newText
            
        }else if textField == mzTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            model.sendMz = newText
            
        }else if textField == csrqTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            model.sendCsrq = newText
            
        }else if textField == cardTextField{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.characters.count >= 18{
                cardTextField.text = (newText as NSString).substring(to: 18)
                
                return false
                
            }
            
            return true
            model.sendCard = newText
            
        }
        
        
        return true
    }
}
