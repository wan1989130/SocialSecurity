//
//  HSPopupSelectDayView.swift
//  HandleSchool
//
//  Created by zhangzhiwei on 16/4/12.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import UIKit
public protocol HSGrowingTogetherHomeSelectDayDelegate : NSObjectProtocol{
    func growingTogetherHomeSelectDayDelegate(_ button:UIButton,selectDate:String) -> Void
    func growingTogetherRemoveSelectDayDelegate() -> Void
}
class HSPopupSelectDayView: UIView {
    
    @IBOutlet var selectBtn: UIButton!
    
    @IBOutlet var bgEdgeView: UIView!
    
    @IBOutlet var datePick: UIDatePicker!
    
    @IBOutlet var datePickBgView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    
    @IBOutlet var doneBtn: UIButton!
    
    @IBOutlet var darkBgView: UIView!
    var delegate:HSGrowingTogetherHomeSelectDayDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadViewOneStep()
    }
    
    func loadViewOneStep(){
        selectBtn.setCornerWithRadius(10)
        bgEdgeView.setCornerWithRadius(10)
        datePick.setCornerWithRadius(10)
        cancelBtn.setCornerWithRadius(10)
        cancelBtn.tag = 1
        doneBtn.setCornerWithRadius(10)
        doneBtn.tag = 2
        datePickBgView.setCornerWithRadius(10)
        //添加点击方法跳进详情页
        let tapView:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(HSPopupSelectDayView.tapDarkBgView(_:)))
        self.darkBgView.addGestureRecognizer(tapView)
    }
    
    @objc func tapDarkBgView(_ tap :UITapGestureRecognizer){
        
        //移除选择时间控件
        self.delegate?.growingTogetherRemoveSelectDayDelegate()
        
    }
    
    
    //MARK:- 设置datePicker的可选择的最大,最小日期
    func setMaxDateAndMinDateAct(_ min:String,max:String){
        // 设置日期范围（超过日期范围，会回滚到最近的有效日期）
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let maxDate = dateFormatter.date(from: max)
        let minDate = dateFormatter.date(from: min)
        self.datePick.maximumDate = maxDate
        self.datePick.minimumDate = minDate
        
    }
    
    
    @IBAction func cancelAct(_ sender: UIButton) {
        self.delegate?.growingTogetherHomeSelectDayDelegate(sender,selectDate:"")
    }
    
    
    @IBAction func doneAct(_ sender: UIButton) {
        
        let dateStr = self.timeFormat()
        self.delegate?.growingTogetherHomeSelectDayDelegate(sender,selectDate:dateStr)
    }
    
    func timeFormat()->String{
        let selectDate = self.datePick.date
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFmt.string(from: selectDate)
        return dateStr
    }
    
    
}
