//
//  CaijiJianHuRenViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/20.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CaijiJianHuRenViewController: BaseViewController {

    @IBOutlet weak var jhrxmTextField: UITextField!
    
    @IBOutlet weak var jhrzjhmTextField: UITextField!
    @IBOutlet weak var jhrzjlxTextField: UITextField!
    @IBOutlet weak var bgView: UIView!
    var dataController:CaijiJianHuRenDataController!
    var isWrite = true
    var selectIndex = -1
    @IBAction func nextClick(_ sender: Any) {
        if checkFun(){
            let dic:NSMutableDictionary = [
                "title":self.title,
                "type":dataController.type,
                "saveModel":dataController.saveModel,
                "dictionaryModel":dataController.dictionaryModel
            ]
            pushViewController("CaijiQiTaViewController",sender:dic)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        initUI()
    }


    deinit {
        print("监护人信息页面销毁")
    }
   

}
extension CaijiJianHuRenViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        bgView.clipsToBounds = true
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        jhrzjlxTextField.delegate = self
        jhrzjhmTextField.delegate = self
        jhrxmTextField.delegate = self
        
        jhrzjlxTextField.text = dataController.saveModel.jhrzjlx
        jhrzjhmTextField.text = dataController.saveModel.jhrzh
        jhrxmTextField.text = dataController.saveModel.jhrxm
        
        
    }
    fileprivate func initData(){
        dataController = CaijiJianHuRenDataController(delegate: self)
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
extension CaijiJianHuRenViewController:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == jhrzjlxTextField{
            if dataController.type == "2"{
                return false
            }else{
                
              
                
                weak var weakSelf = self
                let dic:NSMutableDictionary = [
                    "array":dataController.dictionaryModel.data.zjlxMap,
                    "selectIndexId":dataController.saveModel.jhrzjlx
                ]
                pushViewController("SelectViewController", sender: dic) { (info) in
                    if weakSelf == nil{return}
                    let dic = info as! NSMutableDictionary
                    let model = dic["model"] as! DictionaryModel
                    weakSelf!.dataController.saveModel.jhrzjlx = model.id
                    weakSelf!.dataController.saveModel.jhrzjlxName = model.name
                   
                }
                return false
            }
            
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let model = dataController.saveModel!
        if textField == jhrzjhmTextField{//监护人证件号码
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
//            if newText.characters.count >= 15{
//                jhrzjhmTextField.text = (newText as NSString).substring(to: 15)
//                model.jhrzh = newText
//                return false
//            }else{
                model.jhrzh = newText
//            }
        }else if textField == jhrxmTextField{//监护人姓名
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.characters.count >= 15{
                jhrxmTextField.text = (newText as NSString).substring(to: 15)
                model.jhrxm = jhrxmTextField.text!
                return false
            }else{
                model.jhrxm = newText
            }
        }
        return true
    }
}
extension CaijiJianHuRenViewController{
    func checkFun() -> Bool{
        closeKeyboard()
        let model = dataController.saveModel!
        if model.jhrzjlxName == "身份证"{
            if  !model.zjhm.isLegalIdCard(){
                
                return false
            }
        }else{
            if model.zjhm == ""{
                LHAlertView.showTipAlertWithTitle("监护人证件号码不能为空")
                return false
            }
        }
       
        if model.jhrxm == ""{
            LHAlertView.showTipAlertWithTitle("监护人姓名不能为空")
            return false
        }
        return true
    }
}
