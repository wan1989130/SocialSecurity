//
//  UpdatePasswordViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/18.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: BaseViewController {
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func isShowOldPasswordBtn(_ sender: Any) {
        let button = sender as! UIButton
        
        oldPasswordTextField.isSecureTextEntry = !oldPasswordTextField.isSecureTextEntry
        oldPasswordTextField.font = UIFont.init(name: "System", size: 14)
        oldPasswordTextField.font = UIFont.systemFont(ofSize: 14)
        if oldPasswordTextField.isSecureTextEntry{
            button.setImage(UIImage(named: "icon_password_hide"), for: .normal)
            
            
        }else{
            button.setImage(UIImage(named: "icon_password_show"), for: .normal)
            
        }
    }
    @IBAction func isShowNewPasswordBtn(_ sender: Any) {
        let button = sender as! UIButton
        
        newPasswordTextField.isSecureTextEntry = !newPasswordTextField.isSecureTextEntry
        newPasswordTextField.font = UIFont.init(name: "System", size: 14)
        newPasswordTextField.font = UIFont.systemFont(ofSize: 14)
        if newPasswordTextField.isSecureTextEntry{
            button.setImage(UIImage(named: "icon_password_hide"), for: .normal)
            
            
        }else{
            button.setImage(UIImage(named: "icon_password_show"), for: .normal)
            
        }
    }
    @IBAction func isShowConfirmPasswordBtn(_ sender: Any) {
        let button = sender as! UIButton
        
        confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
        confirmPasswordTextField.font = UIFont.init(name: "System", size: 14)
        confirmPasswordTextField.font = UIFont.systemFont(ofSize: 14)
        if confirmPasswordTextField.isSecureTextEntry{
            button.setImage(UIImage(named: "icon_password_hide"), for: .normal)
            
            
        }else{
            button.setImage(UIImage(named: "icon_password_show"), for: .normal)
            
        }
    }
    
    var dataController:UpdatePasswordDataController!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "修改密码"
        initData()
        initUI()
    }


}
extension UpdatePasswordViewController{
    fileprivate func initUI(){
        
        self.view.backgroundColor = viewBgColor
    }
    fileprivate func initData(){
        dataController = UpdatePasswordDataController(delegate: self)
    }
}
extension UpdatePasswordViewController{
    fileprivate func loadRequest(){
        closeKeyboard()
        if checkFun(){
        
            
            let parameter:NSMutableDictionary = [
                "phone":MyConfig.shared().phone,
                "oldPassword":oldPasswordTextField.text,
                "newPassword":newPasswordTextField.text,
            ]
            weak var weakSelf = self
            dataController.updatePassword(parameter: parameter) { (isSucceed, info) in
                if isSucceed {
                    if weakSelf == nil{return}
                    weakSelf?.navigationController?.popViewController(animated: true)
                }else {
                    //TODO
                    
                }
            }
        }
        
    }
    func checkFun() -> Bool{
        if String.isNilOrEmpty(oldPasswordTextField.text){
            LHAlertView.showTipAlertWithTitle("旧密码不能为空")
            return false
        }
        if String.isNilOrEmpty(newPasswordTextField.text){
            LHAlertView.showTipAlertWithTitle("新密码不能为空")
            return false
        }
        if String.isNilOrEmpty(confirmPasswordTextField.text){
            LHAlertView.showTipAlertWithTitle("确认密码不能为空")
            return false
        }
        if newPasswordTextField.text != confirmPasswordTextField.text{
            LHAlertView.showTipAlertWithTitle("新密码与确认密码不一致")
            return false
        }
        return true
    }
    
}
