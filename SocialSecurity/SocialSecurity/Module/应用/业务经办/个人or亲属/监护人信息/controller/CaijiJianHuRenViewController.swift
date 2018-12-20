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
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        initUI()
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
        jhrzjhmTextField.text = dataController.saveModel.jhrzjhm
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
                
                var dataArray = [DictionaryModel]()
                let model1 = DictionaryModel(id: "0", name: "身份证")
                let model2 = DictionaryModel(id: "1", name: "护照")
                let model3 = DictionaryModel(id: "2", name: "驾驶证")
                dataArray.append(model1)
                dataArray.append(model2)
                dataArray.append(model3)
                
                weak var weakSelf = self
                let dic:NSMutableDictionary = [
                    "array":dataArray,
                    "selectIndex":selectIndex
                ]
                pushViewController("SelectViewController", sender: dic) { (info) in
                    let dic = info as! NSMutableDictionary
                    let model = dic["model"] as! DictionaryModel
                    print(model.name)
                    weakSelf?.jhrzjlxTextField.text = model.name
                }
                return false
            }
            
        }
        return true
    }
}
extension CaijiJianHuRenViewController{
    
}
