//
//  PopupSelectDayView.swift
//  HandleSchool
//
//  Created by zhangzhiwei on 16/4/12.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import UIKit

public typealias PopupSelectDayViewDoneHanler = (_ date:String) -> Void

open class PopupSelectDayView: UIView {
    @IBOutlet var selectBtn: UIButton!
    @IBOutlet var bgEdgeView: UIView!
    @IBOutlet var datePick: UIDatePicker!
    @IBOutlet var datePickBgView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var doneBtn: UIButton!
    @IBOutlet var darkBgView: UIView!
    
    public var doneBlock:PopupSelectDayViewDoneHanler?
    
    public class func show(minDate:String = "", maxDate:String = "", didSelectDate:PopupSelectDayViewDoneHanler?){
        let picker = UIView.loadView(PopupSelectDayView.self)
//        picker.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        picker.setMinDate(minDate)
        picker.setMaxDate(maxDate)
        picker.doneBlock = didSelectDate
        picker.drawInView(UIApplication.shared.keyWindow!)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.loadViewOneStep()
    }
    
    public func loadViewOneStep(){
        datePick.locale = Locale(identifier: "zh_CN")
        selectBtn.setCornerWithRadius(10)
        bgEdgeView.setCornerWithRadius(10)
        datePick.setCornerWithRadius(10)
        cancelBtn.setCornerWithRadius(10)
        cancelBtn.tag = 1
        doneBtn.setCornerWithRadius(10)
        doneBtn.tag = 2
        datePickBgView.setCornerWithRadius(10)
        //添加点击方法跳进详情页
        let tapView:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(PopupSelectDayView.tapDarkBgView(_:)))
        self.darkBgView.addGestureRecognizer(tapView)
    }
    
    @objc public func tapDarkBgView(_ tap :UITapGestureRecognizer){
        self.removeFromSuperview()
    }
    
    //MARK:- 设置datePicker的可选择的最大,最小日期
    public func setMaxDateAndMinDateAct(_ min:String,max:String){
        setMinDate(min)
        setMaxDate(max)
    }
    
    public func setMinDate(_ date:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let minDate = dateFormatter.date(from: date)
        self.datePick.minimumDate = minDate
    }
    
    public func setMaxDate(_ date:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let maxDate = dateFormatter.date(from: date)
        self.datePick.maximumDate = maxDate
        
    }
    
    @IBAction func cancelAct(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func doneAct(_ sender: UIButton) {
        doneBlock?(self.timeFormat())
        self.removeFromSuperview()
    }
    
    public func timeFormat()->String{
        let selectDate = self.datePick.date
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFmt.string(from: selectDate)
        return dateStr
    }
    deinit {
        print("aaaaaaaa")
    }
    
}
