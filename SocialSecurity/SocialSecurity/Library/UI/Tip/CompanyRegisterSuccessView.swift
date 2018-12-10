//
//  CompanyRegisterSuccessView.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
protocol CompanyRegisterSuccessProtocol {
    func companyRegisterSuccessFinishProtocol() -> Void
    func companyRegisterSuccesslookProtocol() -> Void
}

class CompanyRegisterSuccessView: UIView {

    @IBOutlet weak var companyLabel: UILabel!
    @IBAction func lookClick(_ sender: Any) {
        if delegate != nil{
            self.hide()
            delegate?.companyRegisterSuccesslookProtocol()
        }
    }
    @IBAction func finshClick(_ sender: Any) {
        if delegate != nil{
            self.hide()
            delegate?.companyRegisterSuccessFinishProtocol()
        }
    }
    var delegate:CompanyRegisterSuccessProtocol?

}
