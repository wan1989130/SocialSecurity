 //
//  MSPlistController.swift
//  HandleSchool
//
//  Created by 李琪 on 15/11/16.
//  Copyright © 2015年 Huihai. All rights reserved.
//

import UIKit
 
let MSLoginInfoPlistFileName = "MSLoginInfoPlistFileName"
 
class MSPlistController: NSObject {
    
//    class func loadDictionaryPlistData(_ name:String) -> NSMutableDictionary?{
//        if currentUser == nil || currentUser.userId == ""{
//            return nil
//        }
//        //获取文件路径
//        let documentsDirectory:NSString = NSString.getDocumentPath() as NSString
//        let path = documentsDirectory.appendingPathComponent("\(currentUser.userId)/\(name).plist")
//        //创建文件控件器
//        let fileManager = FileManager.default
//        
//        //当文件不存在
//        if(!fileManager.fileExists(atPath: path)) {
//            return nil
//        }
//        //当文件存在
//        else {
//            return NSMutableDictionary(contentsOfFile: path)!
//        }
//    }
//    
//    class func saveDictionaryPlistData(_ name:String,info:NSMutableDictionary)->Bool{
//        //获取文件路径
//        let documentsDirectory:NSString = NSString.getDocumentPath() as NSString
//        let docPath = documentsDirectory.appendingPathComponent("\(currentUser.userId)")
//        if !FileManager.default.fileExists(atPath: docPath){
//           let _ = try? FileManager.default.createDirectory(atPath: docPath, withIntermediateDirectories: true, attributes: nil)
//        }
//        let path = documentsDirectory.appendingPathComponent("\(currentUser.userId)/\(name).plist")
//
//        //写文件
//        if info.write(toFile: path, atomically: true){
//            return true
//        }
//        else{
//            return false
//        }
//    }
//    
//    class func loadArrayPlistData(_ name:String) -> NSMutableArray{
//        if currentUser == nil || currentUser.userId == ""{
//            return NSMutableArray()
//        }
//        //获取文件路径
//        let documentsDirectory:NSString = NSString.getDocumentPath() as NSString
//        let path = documentsDirectory.appendingPathComponent("\(currentUser.userId)/\(name).plist")
//        
//        //创建文件控件器
//        let fileManager = FileManager.default
//        
//        //当文件不存在
//        if(!fileManager.fileExists(atPath: path)) {
//            return NSMutableArray()
//        }
//            //当文件存在
//        else {
//            return NSMutableArray(contentsOfFile: path)!
//        }
//    }
//    
//    class func saveArrayPlistData(_ name:String,info:NSArray)->Bool{
//        //获取文件路径
//        let documentsDirectory:NSString = NSString.getDocumentPath() as NSString
//        let docPath = documentsDirectory.appendingPathComponent("\(currentUser.userId)")
//        if !FileManager.default.fileExists(atPath: docPath){
//            let _ = try? FileManager.default.createDirectory(atPath: docPath, withIntermediateDirectories: true, attributes: nil)
//        }
//        let path = documentsDirectory.appendingPathComponent("\(currentUser.userId)/\(name).plist")
//        //写文件
//        if info.write(toFile: path, atomically: false){
//            return true
//        }
//        else{
//            return false
//        }
//    }
//    
//    class func loadLocalDictionaryPlist(_ name:String)-> NSMutableDictionary{
//        let path:String = Bundle.main.path(forResource: name, ofType: "plist")!
//        let plistInfoDictionary:NSMutableDictionary? = NSMutableDictionary(contentsOfFile: path)
//        if plistInfoDictionary == nil{
//            return NSMutableDictionary()
//        }
//        else{
//            return plistInfoDictionary!
//        }
//    }
//    
//    // MARK: - 登录专用
//    class func loadLoginUserInfo()-> NSMutableDictionary?{
//        //获取文件路径
//        let documentsDirectory:NSString = NSString.getDocumentPath() as NSString
//
//        let path = documentsDirectory.appendingPathComponent("\(MSLoginInfoPlistFileName).plist")
//        //创建文件控件器
//        let fileManager = FileManager.default
//        
//        //当文件不存在
//        if(!fileManager.fileExists(atPath: path)) {
//            return nil
//        }
//            //当文件存在
//        else {
//            return NSMutableDictionary(contentsOfFile: path)!
//        }
//    }
//    
//    class func saveLoginUserInfo(_ info:NSMutableDictionary)->Bool{
//        //获取文件路径
//        let documentsDirectory:NSString = NSString.getDocumentPath() as NSString
//
//        let path = documentsDirectory.appendingPathComponent("\(MSLoginInfoPlistFileName).plist")
//        
//        //写文件
//        if info.write(toFile: path, atomically: true){
//            return true
//        }
//        else{
//            return false
//        }
//    }
}
