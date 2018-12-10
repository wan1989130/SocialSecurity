//
//  FMDBHelper.swift
//  HandleSchool
//
//  Created by 李琪 on 16/5/9.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import UIKit
//let FMDBHelperInstance: FMDBHelper = FMDBHelper()

class FMDBHelper {

    static var FMDBHelperInstance: FMDBHelper = FMDBHelper()
    static var databaseQueue:FMDatabaseQueue?
//    let DBPath = Bundle.main.path(forResource: "demo", ofType: "db")
    
    
    var dataBase = FMDatabase(path: FMDBHelper.getDBPath())

    class func shared() -> FMDBHelper{
        return FMDBHelperInstance
    }
    
    class func getDBPath() -> String{
        let dbName = "dataSources.db"
        // 获取路径
        let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent(dbName)
        return path
//        return Bundle.main.path(forResource: "demo", ofType: "db")!

    }
 
    class func getDatabaseQueue() -> FMDatabaseQueue{
        if databaseQueue == nil{
            databaseQueue = FMDatabaseQueue(path: getDBPath())
        }
        return databaseQueue!
    }
    
    //查询记录
    func selectDBWithSQL(sql:String) -> Array<NSDictionary>{
        FMDBHelper.shared().startDB()
        var tempResultArray = [NSDictionary]()
        do{
            let rs:FMResultSet = try FMDBHelper.shared().dataBase.executeQuery(sql, values: [])
            while rs.next() {
                tempResultArray.append(rs.resultDictionary! as NSDictionary)
            }
            rs.close()
        }
        catch{
            
        }
        FMDBHelper.shared().closeDB()
        return tempResultArray
    }
    //添加记录
    func insertDBWithSQL(sql:String) -> Bool{
        var flag = false
        FMDBHelper.shared().startDB()
        
        do{
            let success = try FMDBHelper.shared().dataBase.executeUpdate(sql, withArgumentsIn: [])
            if success{
                print("添加成功")
            }else{
                print("失败")
            }
            
            flag = true
            
        }
        catch{
            
        }
        FMDBHelper.shared().closeDB()
        return flag
    }
    //修改记录
    func updateDBWithSQL(sql:String) -> Bool{
        var flag = false
        FMDBHelper.shared().startDB()
        
        do{
            let success = try FMDBHelper.shared().dataBase.executeUpdate(sql, withArgumentsIn: [])
            if success{
                print("修改成功")
            }else{
                print("修改失败")
            }
            flag = true
            
        }
        catch{
            
        }
        FMDBHelper.shared().closeDB()
        return flag
    }

    
    func getDictionary(sql:String) -> NSDictionary{
        let array = selectDBWithSQL(sql: sql)
        if array.count > 0 {
            return array[0] as NSDictionary
        }
        else{
            return NSDictionary()
        }
    }
    
    func startDB(){
        dataBase.open()
    }
    
    func closeDB(){
        dataBase.close()
    }
    
    
}
