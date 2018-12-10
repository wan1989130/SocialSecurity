//
//  SQLiteManager.swift
//  Logistics
//
//  Created by 王岩 on 2018/6/14.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
private let dbName = "dataSources.db"
class SQLiteManager{
    // 全局访问点
    static let sharedTools: SQLiteManager = SQLiteManager()
    
    // 队列方式
    var queue: FMDatabaseQueue?
   
    func creatDB(){
        
    }
    
    // 构造函数(不让外界访问,只通过全局访问点)
    private init(){
        
        // MARK: - 打开数据库
        
        // 获取路径
        let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent(dbName)
        let fileManager = FileManager.default
        let exist = fileManager.fileExists(atPath: path)
        if exist{
            print("1111111111=存在")
            
        }else{
            print("22222222222=不存在")
            // 队列方式
            queue = FMDatabaseQueue(path: path)
            // 创建表
            createTable()
        }
        // 打印路径
        print(path)
    }
    
    // MARK: - 创建表
    private func createTable() -> Void {
        
        // 获取文件
        let file = Bundle.main.path(forResource: "db.sql", ofType: nil)
        
        // 准备sql
        let sql = try! String(contentsOfFile: file!)
        
        // 执行sql
        queue?.inDatabase { (db) in
            
            let result = db.executeStatements(sql)
            
            if result {
                print("创建表成功")
            } else {
                print("创建表失败")
            }
        }
    }
    
  
    
}
