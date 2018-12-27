//
//  MyConfig.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/5.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class MyConfig {
    
    static var privateInstance = MyConfig()
    let userDefault = UserDefaults.standard
    
    class func shared() -> MyConfig{
        return privateInstance
    }
    
    //MARK:- 是否已登录
    var isLogin:Bool{
        get{
            if userDefault.object(forKey: "isLogin") == nil {
                return false
            }
            else{
                return (userDefault.object(forKey: "isLogin") as! NSNumber).boolValue
            }
        }
        set{
            userDefault.set(newValue, forKey: "isLogin")
        }
    }
    
   
    
    
    //MARK:- UserModel
    var userModel:Data{
        get{
            if userDefault.object(forKey: "userModel") == nil {
                return Data()
            }
            else{
                return userDefault.object(forKey: "userModel") as! Data
            }
        }
        set{
            userDefault.set(newValue, forKey: "userModel")
        }
    }

    
    //MARK:- 是否是新版本
    var isNewVersion:Bool{
        get{
            let versionSaveKey = kCFBundleVersionKey as String
            //1.从Info.plist中取出版本号
            let version = Bundle.main.infoDictionary![versionSaveKey] as? String
            
            //2.从沙盒中取出上次存储的版本号
            let saveVersion = UserDefaults.standard.object(forKey: versionSaveKey) as? String
            
            //版本号相同，直接执行登录操作
            if version == saveVersion{
                return false
            }
            else{
                UserDefaults.standard.set(version, forKey: versionSaveKey)
                return true
            }
            
        }
    }
   
    var phone:String{
        get{
            if userDefault.object(forKey: "phone") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "phone") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"phone")
        }
    }
    var headPhoto:String{
        get{
            if userDefault.object(forKey: "headPhoto") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "headPhoto") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"headPhoto")
        }
    }
    var shebaoUrl:String{
        get{
            if userDefault.object(forKey: "companyId") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "companyId") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"companyId")
        }
    }
    var zhikajinduUrl:String{
        get{
            if userDefault.object(forKey: "zhikajinduUrl") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "zhikajinduUrl") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"zhikajinduUrl")
        }
    }
    var yibaoUrl:String{
        get{
            if userDefault.object(forKey: "yibaoUrl") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "yibaoUrl") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"yibaoUrl")
        }
    }
    
    var userName:String{
        get{
            if userDefault.object(forKey: "userName") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "userName") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"userName")
        }
    }
    
    
    
    var token:String{
        get{
            if userDefault.object(forKey: "token") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "token") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"token")
        }
    }
    var deviceId:String{
        get{
            if userDefault.object(forKey: "deviceId") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "deviceId") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"deviceId")
        }
    }
    
    var time:String{
        get{
            if userDefault.object(forKey: "time") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "time") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"time")
        }
    }
    
    var isAutoLogin:Bool{
        get{
            if userDefault.object(forKey: "isAutoLogin") == nil{
                return false
            }else{
                return userDefault.object(forKey: "isAutoLogin") as! Bool
            }
        }
        set{
            userDefault.set(newValue,forKey:"isAutoLogin")
        }
    }
    
    //work
    var projectNameHigh:String{
        get{
            if userDefault.object(forKey: "projectNameHigh") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "projectNameHigh") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"projectNameHigh")
        }
    }
    var projectNameBase:String{
        get{
            if userDefault.object(forKey: "projectNameBase") == nil{
                return ""
            }else{
                return userDefault.object(forKey: "projectNameBase") as! String
            }
        }
        set{
            userDefault.set(newValue,forKey:"projectNameBase")
        }
    }
  
    
    //MARK:- 是否第一次进入主页
    var isFirstHome:Bool{
        get{
            if userDefault.object(forKey: "isFirstHome") == nil {
                return true
            }
            else{
                return userDefault.object(forKey: "isFirstHome") as! Bool
            }
        }
        set{
            userDefault.set(newValue, forKey: "isFirstHome")
        }
    }
    
    //MARK:- 是否第一次进入个人页
    var isFirstPerson:Bool{
        get{
            if userDefault.object(forKey: "isFirstPerson") == nil {
                return true
            }
            else{
                return userDefault.object(forKey: "isFirstPerson") as! Bool
            }
        }
        set{
            userDefault.set(newValue, forKey: "isFirstPerson")
        }
    }

    //MARK:- 是否第一次进入我的货源
    var isFirstMySource:Bool{
        get{
            if userDefault.object(forKey: "isFirstMySource") == nil {
                return true
            }
            else{
                return userDefault.object(forKey: "isFirstMySource") as! Bool
            }
        }
        set{
            userDefault.set(newValue, forKey: "isFirstMySource")
        }
    }

    //MARK:- 是否第一次进入我的车源
    var isFirstMyCarSource:Bool{
        get{
            if userDefault.object(forKey: "isFirstMyCarSource") == nil {
                return true
            }
            else{
                return userDefault.object(forKey: "isFirstMyCarSource") as! Bool
            }
        }
        set{
            userDefault.set(newValue, forKey: "isFirstMyCarSource")
        }
    }

}
