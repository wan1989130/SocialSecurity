//
//  updateNickNameViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/18.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class updateNickNameViewController: BaseViewController {
    @IBOutlet weak var nickTextField: UITextField!
    @IBAction func saveClick(_ sender: UIButton) {
        
     loadRequest()
    }
   
    @IBOutlet weak var finishButton: UIButton!
    var dataController:updateNickNameDataController!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "修改昵称"
        initData()
        initUI()
    }

    deinit {
        print("修改昵称")
    }
   

}
extension updateNickNameViewController{
    fileprivate func initUI(){
//        self.view.backgroundColor = UIColor(hexString: "ECF5FE")
        
        
    }
    fileprivate func initData(){
        dataController = updateNickNameDataController(delegate: self)
    }
}
extension updateNickNameViewController{
    fileprivate func loadRequest(){
        closeKeyboard()
        if String.isNilOrEmpty(nickTextField.text){
            LHAlertView.showTipAlertWithTitle("昵称不能为空")
            return
        }
        
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone,
            "nickName":nickTextField.text
        ]
        weak var weakSelf = self
        dataController.updateNickName(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                if weakSelf == nil{return}
                MyConfig.shared().userName = weakSelf!.nickTextField.text!
                weakSelf?.navigationController?.popViewController(animated: true)
            }else {
                //TODO
                
            }
        }
    }
}
