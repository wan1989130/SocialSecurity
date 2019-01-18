//
//  LoginViewController.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/10.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var bgView: UIView!
    //注册
    @IBAction func registerClick(_ sender: Any) {
        pushViewController("PersonRegisterViewController")
    }
   
    @IBOutlet var loginBtn: UIButton!
    //密码
    @IBOutlet weak var passwordTextField: UITextField!
    //用户名
    @IBOutlet weak var userNameTextField: UITextField!
    
    var dataController:LoginDataController!
    
    
    //忘记密码
    @IBOutlet var forgetPasswordBtn: UIButton!
  
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func forgetPwdButtonClicked(_ sender: UIButton) {

        pushViewController("ForgetPwdViewController")
    }
 
   

    
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
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
//                self.showMainTab()
//        return
        closeKeyboard()

        if !checkFun(){
            return
        }
//        self.showMainTab()
        let parameter:NSMutableDictionary = [
            "phone":userNameTextField.text!,
            "password":passwordTextField.text!,

        ]
        weak var weakSelf = self
        dataController.login(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
       
                weakSelf?.showMainTab()
            }else {

            }
        }
    }
    
    func checkFun() -> Bool{

        
        if !userNameTextField.text!.isLegalMobile(){
            return false
        }
        if String.isNilOrEmpty(passwordTextField.text){
            LHAlertView.showTipAlertWithTitle("密码不能为空")
            return false
        }
        return true
    }
}

extension LoginViewController{
    //跳转至主页
    fileprivate func showMainTab(){
        
        
        
     
//        MyConfig.shared().isLogin = true
        
        let tabbarVC = BaseTabBarViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
    
    fileprivate func initData(){
        dataController = LoginDataController(delegate: self)
        
    }
    
    fileprivate func initUI(){
        bgView.layer.cornerRadius = 5
        bgView.layer.borderColor = UIColor(hexString: "005191")?.cgColor
        bgView.layer.borderWidth = 1
        
     
        if MyConfig.shared().phone != "" && MyConfig.shared().phone != ""{
            userNameTextField.text = MyConfig.shared().phone
        }
    }
   
}
extension LoginViewController{
   
   
    
}
