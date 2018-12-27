//
//  FeedBackViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/18.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class FeedBackViewController: BaseViewController {

    @IBAction func saveClick(_ sender: Any) {
       loadRequest()
    }
    @IBOutlet weak var contentTextField: UIPlaceholderTextView!
    var dataController:FeedBackDataController!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "意见反馈"
        initData()
        initUI()
    }


   
}
extension FeedBackViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        contentTextField.placeholder = "请输入内容"
        
    }
    fileprivate func initData(){
        dataController = FeedBackDataController(delegate: self)
    }
}
extension FeedBackViewController{
    fileprivate func loadRequest(){
        closeKeyboard()
        if String.isNilOrEmpty(contentTextField.text){
            LHAlertView.showTipAlertWithTitle("内容不能为空")
            return
        }
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone,
            "message":contentTextField.text
            ]
        weak var weakSelf = self
        dataController.suggest(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                if weakSelf == nil{return}
                weakSelf?.navigationController?.popViewController(animated: true)
            }else {
                //TODO
                
            }
        }
    }
}
