//
//  ConnactUsViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2019/1/11.
//  Copyright © 2019年 王岩. All rights reserved.
//

import UIKit

class ConnactUsViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = viewBgColor
      title = "联系我们"
        
    }
    func callFun(phone:String){
        let alertVC :UIAlertController = UIAlertController.init(title:"确定要拨打 \(phone)电话吗?", message:"", preferredStyle: .alert)
        let falseAA :UIAlertAction = UIAlertAction.init(title:"取消", style: .cancel, handler:nil)
        let trueAA :UIAlertAction = UIAlertAction.init(title:"确定", style: .default) { (alertAction)in
            //拨打电话进行报警
            UIApplication.shared.openURL(URL.init(string:"tel://\(phone)")! )
        }
        alertVC.addAction(falseAA)
        alertVC.addAction(trueAA)
        self.present(alertVC, animated:true, completion: nil)
    }

    @IBAction func oneClick(_ sender: Any) {
        callFun(phone: "85858607")
    }
    @IBAction func twoClick(_ sender: Any) {
        callFun(phone: "80808301")
    }
    
    @IBAction func threeClick(_ sender: Any) {
        callFun(phone: "81668722")
    }
   
}
