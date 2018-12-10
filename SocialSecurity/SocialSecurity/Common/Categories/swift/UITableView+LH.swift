//
//  UITableView+LH.swift
//  MiddleSchool2_student
//
//  Created by 李琪 on 2017/6/12.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

extension UITableView {

    func register(_ name:String){
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
        let cellNib: UINib = UINib(nibName: name, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: name + "Id")
    }

}
