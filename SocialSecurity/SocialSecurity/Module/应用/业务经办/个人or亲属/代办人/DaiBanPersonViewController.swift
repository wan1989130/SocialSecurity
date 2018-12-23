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
//        let rootVc = UIApplication.shared.keyWindow?.rootViewController
        for vc in (self.navigationController?.viewControllers)!{
            if vc is YwjbViewController{
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
       
    }
    var isWrite = true
    @IBOutlet weak var xbTextField: UITextField!//姓名
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
        }
        if dataController.type == "2"{
            isWrite = false
        }
        
    }
}
extension DaiBanPersonViewController{
    
}
extension DaiBanPersonViewController{
    
}
