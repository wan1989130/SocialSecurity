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
        if String.isNilOrEmpty(contentTextField.text){
            LHAlertView.showTipAlertWithTitle("请输入反馈内容")
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var contentTextField: UITextView!
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
        
    }
    fileprivate func initData(){
        dataController = FeedBackDataController(delegate: self)
    }
}
extension FeedBackViewController{}
