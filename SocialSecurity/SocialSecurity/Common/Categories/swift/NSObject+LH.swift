//
//  NSObject+LH.swift
//  HandleSchool
//
//  Created by 李琪 on 15/12/3.
//  Copyright © 2015年 Huihai. All rights reserved.
//


extension NSObject {
    func HSLog(_ obj:Any?){
        if obj == nil{
            print("[\(NSStringFromClass(object_getClass(self)!))]:nil")
        }
        else{
            print("[\(NSStringFromClass(object_getClass(self)!))]:\(obj!)")
        }
    }
}
