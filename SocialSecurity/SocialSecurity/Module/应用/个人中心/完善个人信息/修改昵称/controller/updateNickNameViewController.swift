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
        if String.isNilOrEmpty(nickTextField.text){
            LHAlertView.showTipAlertWithTitle("请输入昵称")
            return
        }
        dismissBlock!(nickTextField.text)
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBOutlet weak var finishButton: UIButton!
    var dataController:updateNickNameDataController!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "修改昵称"
        initData()
        initUI()
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
extension updateNickNameViewController{}
