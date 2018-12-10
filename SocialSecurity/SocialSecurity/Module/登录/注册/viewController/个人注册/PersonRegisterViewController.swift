//
//  PersonRegisterViewController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class PersonRegisterViewController: BaseViewController {
    
    @IBAction func isAgreeClick(_ sender: UIButton) {
        let img = UIImage.init(named: "main_MutiCheck_Off")
        if sender.currentBackgroundImage == img{
            isAgree = true
            sender.setBackgroundImage(UIImage.init(named: "main_MutiCheck_On"), for: .normal)
        }else {
            isAgree = false
            sender.setBackgroundImage(UIImage.init(named: "main_MutiCheck_Off"), for: .normal)
        }
        
    }
    var isAgree = true //是否同意
    
    @IBAction func protocolClick(_ sender: Any) {
        
        let webVc = CommonWebViewController()
        webVc.urlContent = Protocolhtml
        webVc.titleContent = "用户服务协议"
        self.navigationController?.pushViewController(webVc, animated: true)
        
    }

    
    @IBAction func getCodeClick(_ sender: UIButton) {
        closeKeyboard()
        if !checkPhone(){
            return
        }
        loadGetVercode()
        
        
    }
    //手机号
    @IBOutlet weak var phoneTextField: UITextField!
    //验证码
    @IBOutlet weak var codeTextField: UITextField!
    //密码
    @IBOutlet weak var passwordTextField: UITextField!
    var dataController:PersonRegisterDataController!
    
    @IBOutlet var getCodeButton: UIButton!
    
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
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "创建账号"
        
        initData()
        initUI()
    }
    
    
    
}
extension PersonRegisterViewController{
    fileprivate func initUI(){
       
        
    }
    fileprivate func initData(){
        dataController = PersonRegisterDataController(delegate: self)
       
        
    }
}
extension PersonRegisterViewController{
    
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
        return true
    }
    
    
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
//    //添加注册的新用户
//    fileprivate func addUser(){
//        let parameter:NSMutableDictionary = [
//            "loginName":userNameTextField.text!,
//            "name":nameTextField.text!,
//            "pwd":passwordTextField.text!,
//            "companyId":companyModel.id
//
//            ]
//
//
//        dataController.addUser(parameter: parameter) { (isSucceed, info) in
//            if isSucceed {
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
//    }
}

