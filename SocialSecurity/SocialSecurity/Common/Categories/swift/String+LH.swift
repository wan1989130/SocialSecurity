//
//  String+LH.swift
//  HandleSchool
//
//  Created by 李琪 on 16/4/27.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import UIKit
//"yyyy-MM-dd HH:mm:ss"
extension String {
    static func isNilOrEmpty(_ text:Any?) -> Bool{
        if !(text is String || text is NSString){
            return true
        }
        
        if text as? String == nil || text as! String == ""{
            return true
        }
        return false
    }
       
    
    //验证手机号
    func isLegalMobile() -> Bool{
        let phone = self
        if phone.characters.count == 0{
            LHAlertView.showTipAlertWithTitle("手机号不能为空")
            return false
        }else{
            let regex = "[1][3456789]\\d{9}"
            let pred = NSPredicate(format: "SELF MATCHES %@", regex)
            let isMatch = pred.evaluate(with: phone)
            if !isMatch {
                LHAlertView.showTipAlertWithTitle("请输入标准手机号")
                return false
            }
        }
        return true
    }
   
    
 
    //验证手机号
    func isLegalIdCard() -> Bool{
        let phone = self
        if phone.characters.count == 0{
            LHAlertView.showTipAlertWithTitle("身份证号不能为空")
            return false
        }else{
//            let regex = "/^\\d{6}(18|19|20)+\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])\\d{3}(\\d|X)$/i"
            let regex = "^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9X]$"
            let pred = NSPredicate(format: "SELF MATCHES %@", regex)
            let isMatch = pred.evaluate(with: phone)
            if !isMatch {
                LHAlertView.showTipAlertWithTitle("身份证号格式错误")
                return false
            }
        }
        return true
    }
    
    //验证邮箱
    func isLegalEmail() -> Bool{
        let email = self
        if email.characters.count == 0{
            LHAlertView.showTipAlertWithTitle("邮箱不能为空")
            return false
        }else{
            let regex = "^[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]\\.[a-zA-Z][a-zA-Z\\.]*[a-zA-Z]$"
            let pred = NSPredicate(format: "SELF MATCHES %@", regex)
            let isMatch = pred.evaluate(with: email)
            if !isMatch {
                LHAlertView.showTipAlertWithTitle("邮箱格式不正确")
                return false
            }
        }
        return true
    }
    //验证密码
    func isLegalPassword() -> Bool{
        let password = self
        let regex = ".*[A-Za-z0-9]"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatch = pred.evaluate(with: password)
        if !isMatch {
            LHAlertView.showTipAlertWithTitle("密码只能由英文字母、数字组成")
            return false
        }
        return true
    }
    //验证字符
    func isNumOrString() -> Bool{
        let password = self
        let regex = ".*[A-Za-z0-9]"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatch = pred.evaluate(with: password)
        if !isMatch {
            return false
        }
        return true
    }
    
    /**
     * 获取（中文）字符串的首字母
     */
    func firstLetter() -> String{
        return (self as NSString).firstLetter()
    }
    
    /**
     * 获取（中文）字符串中所有汉字首字母组成的字符串
     */
    func firstLetters() -> String{
        return (self as NSString).firstLetters()
    }

    
    /**
     * 获取（中文）字符串的拼音
     */
    func allLetters() -> String{
        return (self as NSString).allLetters()
    }

    func getSize(withFont font:UIFont) -> CGSize{
        return (self as NSString).getSizeWith(font)
    }
    
    func getSize(withFont font:UIFont, forWidth width:CGFloat) -> CGSize{
        return (self as NSString).getSizeWith(font, forWidth: width)
    }
    
    func getSize(withFont font:UIFont, forConstrainedToSize size:CGSize) -> CGSize{
        return (self as NSString).getSizeWith(font, constrainedTo:size)
    }
    
    static func getSize(withText text:String, forFont font:UIFont, maxWidth width:CGFloat) -> CGSize{
        return NSString.getSizeWithText(text, font:font, maxWidth:width)
    }
    
    static func getSize(withText text:String, forFont font:UIFont, ConstrainedToSize size:CGSize) -> CGSize{
        return NSString.getSizeWithText(text, font: font, constrainedTo: size)
    }
    
    static func weekDayStringFromDate(_ date:Date) -> String{
        let weekdays = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
        var calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone.init(secondsFromGMT: 0)!
        var comps:DateComponents = DateComponents()
        let unitFlag:NSCalendar.Unit = .weekday
        comps = (calendar as NSCalendar).components(unitFlag, from: date)
        return weekdays[comps.weekday! - 1]
    }
    
    static func weekDayStringFromDate(_ dateString:String) -> String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        return date == nil ? "" : String.weekDayStringFromDate(date!)
    }
    
    //根据时间转换成只有日的时间
    static func dayStringFromDate(_ dateString:String)->String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd日"
        return date == nil ? "" : dateFormatter.string(from: date!)
    }
    
    //根据时间转换成只有月日的时间
    static func monthDayStringFromDate(_ dateString:String) -> String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MM月dd日"
        return date == nil ? "" : dateFormatter.string(from: date!)
    }
    
    //根据时间转换成只有年月日的时间
    static func yearMonthDayStringFromDate(_ dateString:String) -> String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return date == nil ? "" : dateFormatter.string(from: date!)
    }
    
    //根据时间转换成只有年月日的时间
    static func yearMonthStringFromDate(_ dateString:String) -> String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy年MM月"
        return date == nil ? "" : dateFormatter.string(from: date!)
    }
    
    //根据时间转换成只有日星期的时间
    static func dayWeekDayStringFromDate(_ dateString:String)->String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd日"
        return date == nil ? "" : dateFormatter.string(from: date!) + "/\(String.weekDayStringFromDate(date!))"
    }
    
    //根据时间转换成只有月日星期的时间
    static func monthDayWeekDayStringFromDate(_ dateString:String) -> String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MM月dd日"
        return date == nil ? "" : dateFormatter.string(from: date!) + "/\(String.weekDayStringFromDate(date!))"
    }
    
    //根据时间转换成只有年月日星期的时间
    static func yearMonthDayWeekDayStringFromDate(_ dateString:String) -> String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return date == nil ? "" : dateFormatter.string(from: date!) + "/\(String.weekDayStringFromDate(date!))"
    }

    static func yearMonthDayWeekDayStringFromDate(_ date:Date) -> String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return dateFormatter.string(from: date) + "/\(String.weekDayStringFromDate(date))"
    }
    
    //根据时间转换成只有时分的时间
    static func hourMinuteStringFromDate(_ dateString:String) -> String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "HH:mm"
        return date == nil ? "" : dateFormatter.string(from: date!)
    }
    
    //根据时间转换成只有时分星期的时间
    static func hourMinuteWeekDayStringFromDate(_ dateString:String) -> String{
        let GTMzone = TimeZone.init(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = GTMzone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "HH:mm"
        return date == nil ? "" : dateFormatter.string(from: date!) + "/\(String.weekDayStringFromDate(date!))"
    }

}
