//
//  IdCardQueryViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class IdCardQueryViewController: BaseViewController {

    var dataController:IdCardQueryDataController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        
    }


   

}
extension IdCardQueryViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        
        
    }
    fileprivate func initData(){
        dataController = IdCardQueryDataController(delegate: self)
        if senderParam != nil{
            title = senderParam as! String
        }
    }
}
extension IdCardQueryViewController{
    
}
