//
//  NoDataView.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/20.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
typealias RetryRequestBlock = () ->Void
class NoDataView: UIView {

    
    @IBOutlet weak var noDataImageView: UIImageView!
    
    @IBOutlet weak var noDataLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    

}
