//
//  SelectDateView.swift
//  选择日期actionsheet
//
//  Created by 王岩 on 2017/6/5.
//  Copyright © 2017年 王岩. All rights reserved.
//

import UIKit



class SelectChangQiDateView: UIView {
    weak var pro:SelectDateDelegate?
    var delegate:UIViewController?
    var alert:UIAlertController?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(delegate:UIViewController,currentStr:String?) {
        super.init(frame: CGRect.zero)
        
        self.delegate = delegate
        let datePicker = UIDatePicker()
        
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let currentTime = timeFormatter.string(from: date ) as String
        
        let userCalendar = Calendar.current
        let date2 = userCalendar.date(byAdding: .year, value: 2, to: date)
        
        //最小最大日期
//        datePicker.minimumDate = date
//        datePicker.maximumDate = date2
        
        datePicker.datePickerMode = .date
        let locale = Locale.init(identifier: "zh_CN")
        let cformatter = DateFormatter()
        if !String.isNilOrEmpty(currentStr) && currentStr != "长期"{
            cformatter.dateFormat = "yyyy-MM-dd"
            let currentDate = cformatter.date(from: currentStr!)
            datePicker.setDate(currentDate!, animated: true)
        }
        
        
        datePicker.locale = locale
        alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert?.view.addSubview(datePicker)
        let ok = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "YYYY-MM-dd"
            let dateString = dateFormat.string(from: datePicker.date)
//            print(dateString)
            self.pro?.selectDate(dateString: dateString)
            
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            print("cancel")
        }
        let changqi = UIAlertAction(title: "长期", style: .default) { (UIAlertAction) in
            self.pro?.selectDate(dateString: "长期")
        }
       
        alert?.addAction(ok)
        alert?.addAction(cancel)
        alert?.addAction(changqi)
        
        
    }
    func show(){
        self.delegate?.present(alert!, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
