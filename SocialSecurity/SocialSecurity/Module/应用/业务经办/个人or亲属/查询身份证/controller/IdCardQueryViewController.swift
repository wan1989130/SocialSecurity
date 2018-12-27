//
//  IdCardQueryViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class IdCardQueryViewController: BaseViewController {

    @IBAction func finishClick(_ sender: Any) {
        loadRequest()
        
    }
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var idBgView: UIView!
    var dataController:IdCardQueryDataController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        
    }
    deinit {
        print("查询身份证页面销毁")
    }

   

}
extension IdCardQueryViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        idBgView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        idBgView.layer.borderWidth = 1
        
    }
    fileprivate func initData(){
        dataController = IdCardQueryDataController(delegate: self)
        if senderParam != nil{
            let dic = senderParam as! NSMutableDictionary
            if dic["title"] != nil{
                title = dic["title"] as! String
            }
            if dic["type"] != nil{
                dataController.type = dic["type"] as! String
            }
            
        }
    }
}
extension IdCardQueryViewController{
    fileprivate func loadRequest(){
        closeKeyboard()
        
        if !(contentTextField.text?.isLegalIdCard())!{
            return
        }
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone,
            "idCard":contentTextField.text
        ]
        weak var weakSelf = self
        dataController.idCardQuery(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                if weakSelf == nil{return}
                let dic:NSMutableDictionary = [
                    "title":self.title,
                    "type":weakSelf!.dataController.type
                ]
                weakSelf!.pushViewController("CaijiBasicViewController",sender:dic)
            }else {
                //TODO
                
            }
        }
    }
}
