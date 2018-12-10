//
//  ForgetPwdViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class ForgetPwdViewController: BaseViewController {
    //手机号
    @IBOutlet weak var phoneTextField: UITextField!
    //验证码
    @IBOutlet weak var codeTextField: UITextField!
    //密码
    @IBOutlet weak var passwordTextField: UITextField!
    //确认密码
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func isShowPasswordBtn(_ sender: Any) {
        let button = sender as! UIButton
        
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        passwordTextField.font = UIFont.init(name: "System", size: 14)
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        if passwordTextField.isSecureTextEntry{
            button.setImage(UIImage(named: "icon_password_hide"), for: .normal)
            
            
        }else{
            button.setImage(UIImage(named: "icon_password_show"), for: .normal)
            
        }
    }
    @IBAction func isShowConfirmPasswordBtn(_ sender: Any) {
        let button = sender as! UIButton
        
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        passwordTextField.font = UIFont.init(name: "System", size: 14)
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        if passwordTextField.isSecureTextEntry{
            button.setImage(UIImage(named: "icon_password_hide"), for: .normal)
            
            
        }else{
            button.setImage(UIImage(named: "icon_password_show"), for: .normal)
            
        }
    }
    @IBOutlet var getCodeButton: UIButton!
    @IBAction func getCodeClick(_ sender: UIButton) {
        closeKeyboard()
        if !checkPhone(){
            return
        }
        loadGetVercode()
        
        
    }
    
    @IBAction func confirmClick(_ sender: Any) {
        closeKeyboard()
        if !checkFun(){
            return
        }
    }
    var dataController:ForgetPwdDataController!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "找回密码"
        initData()
        initUI()
    }


   

}
extension ForgetPwdViewController{
    fileprivate func initUI(){
        
        
    }
    fileprivate func initData(){
        dataController = ForgetPwdDataController(delegate: self)
        
        
    }
    fileprivate func checkPhone() -> Bool{
        if !(phoneTextField.text?.isLegalMobile())!{
            return false
        }
        return true
    }
    fileprivate func checkFun() -> Bool{
        if !checkPhone(){
            return false
        }
        
        if String.isNilOrEmpty(codeTextField.text){
            LHAlertView.showTipAlertWithTitle("验证码不能为空")
            return false
        }
        if String.isNilOrEmpty(passwordTextField.text){
            LHAlertView.showTipAlertWithTitle("密码不能为空")
            return false
        }
        if String.isNilOrEmpty(confirmPasswordTextField.text){
            LHAlertView.showTipAlertWithTitle("确认密码不能为空")
            return false
        }
        if passwordTextField.text != confirmPasswordTextField.text{
            LHAlertView.showTipAlertWithTitle("两次密码需要一致")
            return false
        }
        return true
    }
}
extension ForgetPwdViewController{
    //获取验证码
    fileprivate func loadGetVercode(){
        let countDown = TCCountDown()//实例化
        countDown.getCodeButton = self.getCodeButton
        countDown.isCounting = true//开启倒计时
        //        let parameter:NSMutableDictionary = [
        //            "phone":phoneTextField.text!,
        //            "type":GetCodeType.regist.rawValue
        //        ]
        //        dataController.getVerCode(parameter: parameter) { (isSucceed, info) in
        //            if isSucceed {
        //                LHAlertView.showTipAlertWithTitle(info as! String)
        //                let countDown = TCCountDown()//实例化
        //                countDown.getCodeButton = self.getCodeButton
        //                countDown.isCounting = true//开启倒计时
        //            }else {
        //            }
        //        }
    }
}
