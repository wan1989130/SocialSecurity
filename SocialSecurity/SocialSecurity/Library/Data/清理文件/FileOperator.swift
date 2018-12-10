//
//  FileOperator.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/11.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation

class FileOperator {
    //删除文件
    static func deleteFile(url:String){
        let fileManager = FileManager.default
        
        if FileOperator.isExistFile(url: url){
           try! fileManager.removeItem(atPath: url)
        }
    }
    static func isExistFile(url:String) -> Bool{
        let fileManager = FileManager.default
        var exist  = fileManager.fileExists(atPath: url)
        return exist
    }
}
