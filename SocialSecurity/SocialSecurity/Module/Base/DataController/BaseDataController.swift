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
    var delegate:UIViewController?
    var gradesModel:BaseClassesDataModel = BaseClassesDataModel()
    var classesModel:BaseClassesDataModel = BaseClassesDataModel()

    var termsModel:BaseTermsDataModel = BaseTermsDataModel()
    //只获取班级
    var onlyClassModel:BaseOnlyClassDataModel = BaseOnlyClassDataModel()
    init(delegate:UIViewController) {
        self.delegate = delegate
    }
    //获取年级
    func loadGrades(parameter: NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getGrades(delegate: self.delegate!, parameter: parameter) { (isSucceed, result) in
            if isSucceed{
                let model = Mapper<BaseClassesDataModel>().map(JSONObject: result)
                
                if model != nil{
                    self.gradesModel = model!
                    completionBlock(true, nil)
                    return
                }
                completionBlock(false, nil)
            }else{
                completionBlock(false, nil)
            }
            
        }
    }
    //获取年班级
    func loadClasses(parameter: NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getClasses(delegate: self.delegate!, parameter: parameter) { (isSucceed, result) in
            if isSucceed{
                let model = Mapper<BaseClassesDataModel>().map(JSONObject: result)
                if model != nil{
                    self.classesModel = model!
                    completionBlock(true, nil)
                }else{
                    completionBlock(false, nil)
                }
                
            }else{
                completionBlock(false, nil)
            }
            
        }
    }
    //获取班级
    func getOnlyClass(parameter: NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getOnlyClass(delegate: self.delegate!, parameter: parameter) { (isSucceed, result) in
            if isSucceed{
                let model = Mapper<BaseOnlyClassDataModel>().map(JSONObject: result)
                if model != nil{                                        
                    self.onlyClassModel = model!
                    completionBlock(true, nil)
                }else{
                    completionBlock(false, nil)
                }
                
            }else{
                completionBlock(false, nil)
            }
            
        }
    }
    //获取学期
    func loadTerms(parameter: NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getTerms(delegate: self.delegate!, parameter: parameter) { (isSucceed, result) in
            if isSucceed{
                let model = Mapper<BaseTermsDataModel>().map(JSONObject: result)
                if model != nil{
                    self.termsModel = model!
                    completionBlock(true, nil)
                }else{
                    completionBlock(false, nil)
                }
     
                
            }else{
                
//                let result = [
//                    "code":"0",
//                    "msg":"成功",
//                    "data":[
//                        "defaultId":"1",
//                        "defaultName":"2016上学期",
//                        
//                        "lists":[["termId":"1","termName":"2016上学期"],["termId":"2","termName":"2017上学期"]]
//                    ]
//                    ] as AnyObject
//                let model = Mapper<BaseTermsDataModel>().map(JSONObject: result)
//                if model != nil{
//                    self.termsModel = model!
//                    completionBlock(true, nil)
//                }
//                
//                completionBlock(false, nil)
            }
        }
    }
    
    //获取验证码
    func getVerCode(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getVerCode(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<BaseModel>().map(JSONObject: result)

                completionBlock(true, model?.msg)
            }else{
                completionBlock(false, nil)
            }
        }
    }

    //获取数据请求页码
    func getPageIndex(_ dataArray:Array<Any>, pageSize:Int) -> Int{
        let fullPageCount = dataArray.count / pageSize + 1
        let remainPageCount = dataArray.count % pageSize
        
        return remainPageCount == 0 ? fullPageCount : fullPageCount + 1
    }

}
