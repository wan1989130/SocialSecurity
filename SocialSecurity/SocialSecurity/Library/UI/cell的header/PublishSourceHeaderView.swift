//
//  PublishSourceHeaderView.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/27.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

typealias PublishSourceHeaderViewBlock = (_ button:UIButton) -> Void
class PublishSourceHeaderView: UIView {
    @IBOutlet weak var iconTitleImageView: UIImageView!
    @IBOutlet weak var titleButton: UIButton!
    
    @IBOutlet weak var arrowBtn: UIButton!
    var block:PublishSourceHeaderViewBlock?
    func update(block: PublishSourceHeaderViewBlock?){
        if block != nil{
            self.block = block
        }
        
    }
    @IBAction func click(_ sender: Any) {
        if block != nil{
            block!(arrowBtn)
        }
    }
    

}
