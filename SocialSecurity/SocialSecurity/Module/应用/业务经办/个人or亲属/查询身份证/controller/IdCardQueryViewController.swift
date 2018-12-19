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
        pushViewController("CaijiBasicViewController",sender:self.title)
    }
    @IBOutlet weak var idBgView: UIView!
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
        idBgView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        idBgView.layer.borderWidth = 1
        
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
