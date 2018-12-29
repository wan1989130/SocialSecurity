//
//  DaiBanPersonViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class DaiBanPersonViewController: BaseViewController {

    @IBAction func nextClick(_ sender: UIButton) {
        closeKeyboard()
        if checkFun(){
            addOrUpdate()
        }
       
    }
    var isWrite = true
    @IBOutlet weak var xmTextField: UITextField!//姓名
    @IBOutlet weak var sfzhTextField: UITextField!//身份证号
    @IBOutlet weak var lxsjTextField: UITextField!//联系手机
    var dataController:DaiBanPersonDataController!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }

    deinit {
        print("代办人页面销毁")
    }
   
}
extension DaiBanPersonViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        xmTextField.delegate = self
        sfzhTextField.delegate = self
        lxsjTextField.delegate = self
    }
    fileprivate func initData(){
        dataController = DaiBanPersonDataController(delegate: self)
        if senderParam != nil{
            let dic = senderParam as! NSMutableDictionary
            if dic["title"] != nil{
                title = dic["title"] as! String
            }
            if dic["type"] != nil{
                dataController.type = dic["type"] as! String
            }
            if dic["saveModel"] != nil{
                dataController.saveModel = dic["saveModel"] as! CaijiSaveModel
            }
            if dic["dictionaryModel"] != nil{
                dataController.dictionaryModel = dic["dictionaryModel"] as! DictionaryDataModel
            }
        }
        if dataController.type == "2"{
            isWrite = false
        }
        
    }
}
extension DaiBanPersonViewController{
    func checkFun() -> Bool{
        let model = dataController.saveModel!
        if model.dbr_xm == ""{
            LHAlertView.showTipAlertWithTitle("代办人姓名不能为空")
            return false
        }
        if  !model.zjhm.isLegalIdCard(){
            return false
        }
        if model.dbr_lxdh == ""{
            LHAlertView.showTipAlertWithTitle("代办人联系手机不能为空")
            return false
        }
        
        return true
    }
    
}
extension DaiBanPersonViewController{
    
    //录入和修改
    fileprivate func addOrUpdate(){
        
        let parameterDic = dataController.saveModel.toJSON()
        let parameter = NSMutableDictionary(dictionary: parameterDic)
        weak var weakSelf = self
        dataController.addOrUpdate(parameter: parameter) { (isSucceed, info) in
            if weakSelf == nil{return}
            if isSucceed {
                weakSelf!.returnMain()
            }else {
                
            }
        }
    }
    func returnMain(){
        for vc in (self.navigationController?.viewControllers)!{
            if vc is YwjbViewController{
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
}
extension DaiBanPersonViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let model = dataController.saveModel!
        if textField == xmTextField{//姓名
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.characters.count >= 15{
                xmTextField.text = (newText as NSString).substring(to: 15)
                model.dbr_xm = xmTextField.text!
                return false
            }else{
                model.jhrzh = newText
            }
        }else if textField == sfzhTextField{//代办人身份证号
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.characters.count >= 18{
                sfzhTextField.text = (newText as NSString).substring(to: 18)
                model.dbr_sfzhm = sfzhTextField.text!
                return false
            }else{
                model.jhrxm = newText
            }
        }else if textField == lxsjTextField{//代办人联系电话
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.characters.count >= 11{
                lxsjTextField.text = (newText as NSString).substring(to: 11)
                model.dbr_lxdh = lxsjTextField.text!
                return false
            }else{
                model.jhrxm = newText
            }
        }
        return true
    }
}
