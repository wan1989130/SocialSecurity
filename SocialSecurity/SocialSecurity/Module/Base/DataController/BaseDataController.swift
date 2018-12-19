//
//  BaseDataController.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/2.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit
import ObjectMapper
typealias RequestCompleteBlock = (_ isSucceed:Bool,_ info:Any?)->Void

enum DataLoadPullDirection:Int{
    case top = 1        //下拉刷新
    case bottom = 2     //上拉刷新
    case firstLoad = 3  //首次加载
}

//左右切换方向
enum DataLoadLRChangeDirection{
    case previous       //上一个
    case next           //下一个
}

class BaseDataController: Any {
    weak var delegate:UIViewController?
  
    init(delegate:UIViewController) {
        self.delegate = delegate
    }
    

    //获取数据请求页码
    func getPageIndex(_ dataArray:Array<Any>, pageSize:Int) -> Int{
        let fullPageCount = dataArray.count / pageSize + 1
        let remainPageCount = dataArray.count % pageSize
        
        return remainPageCount == 0 ? fullPageCount : fullPageCount + 1
    }

}
