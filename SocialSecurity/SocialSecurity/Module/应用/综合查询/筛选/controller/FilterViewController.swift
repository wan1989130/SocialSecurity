//
//  FilterViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var pleaseSelectStartButton: UIButton!
    @IBOutlet weak var pleaseSelectEndButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!//发货人姓名
    @IBOutlet weak var logisticsNumTextField: UITextField!//物流单号
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var endCancelButton: UIButton!
    @IBOutlet weak var endClickButton: UIButton!
    @IBOutlet weak var startClickButton: UIButton!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var startCancelButton: UIButton!
    @IBAction func startCancelClick(_ sender: Any) {
//        startClickButton.isHidden = false
        pleaseSelectStartButton.isHidden = false
        startTimeLabel.isHidden = true
        startCancelButton.isHidden = true
        filterModel.stime = ""
    }
   
    @IBAction func endCancelClick(_ sender: Any) {
//        endClickButton.isHidden = false
        pleaseSelectEndButton.isHidden = false
        endTimeLabel.isHidden = true
        endCancelButton.isHidden = true
        filterModel.etime = ""
    }
    @IBAction func startTimeClick(_ sender: Any) {
        var datepicker2 = WSDatePickerView.init(dateStyle: DateStyleShowYearMonthDay) { (selectDate) in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormat.string(from: selectDate!)
            self.startTimeLabel.isHidden = false
            self.pleaseSelectStartButton.isHidden = true
            self.startCancelButton.isHidden = false
            self.startTimeLabel.text = dateString
            
            if !String.isNilOrEmpty(dateString){
                
                
                
                self.filterModel.stime = dateString.replacingOccurrences(of: "-", with: "")
            }
        }
        datepicker2?.doneButtonColor = UIColor.lightGray.withAlphaComponent(0.2)
        datepicker2?.dateLabelColor = UIColor.darkGray
        datepicker2?.datePickerColor = UIColor.darkGray
        
        datepicker2?.show()
        
//        let dateView = SelectDateView(delegate: self,currentStr:filterModel.stime)
//        timeType = .begin
//        dateView.pro = self
//        dateView.show()
    }
    @IBAction func endTimeClick(_ sender: Any) {
        var datepicker2 = WSDatePickerView.init(dateStyle: DateStyleShowYearMonthDay) { (selectDate) in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormat.string(from: selectDate!)
            self.endTimeLabel.isHidden = false
            self.pleaseSelectEndButton.isHidden = true
            self.endCancelButton.isHidden = false
            self.endTimeLabel.text = dateString
            
            if !String.isNilOrEmpty(dateString){
                self.filterModel.etime = dateString.replacingOccurrences(of: "-", with: "")
            }
        }
        datepicker2?.doneButtonColor = UIColor.lightGray.withAlphaComponent(0.2)
        datepicker2?.dateLabelColor = UIColor.darkGray
        datepicker2?.datePickerColor = UIColor.darkGray
        
        datepicker2?.show()
//        let dateView = SelectDateView(delegate: self,currentStr:filterModel.etime)
//        timeType = .end
//        dateView.pro = self
//        dateView.show()
    }
    var timeType:SelectTimeType = .begin
    var dataController:FilterDataController!
    let filterModel = FilterModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "筛选"
        initData()
        initUI()
        // Do any additional setup after loading the view.
    }

}
extension FilterViewController{
    func initData(){
        dataController = FilterDataController(delegate: self)
    }
    func initUI(){
        loadRightBarButtonItem()
        nameTextField.delegate = self
        nameTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        nameTextField.leftViewMode = .always
        
        logisticsNumTextField.delegate = self
        logisticsNumTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        logisticsNumTextField.leftViewMode = .always
    }
    /**
     * 加载导航栏右侧按钮
     */
    fileprivate func loadRightBarButtonItem(){
        let button =   UIButton(type: .system)
        button.frame = CGRect(x:0, y:0, width:10, height:30)
        
        button.setTitle("确定", for: .normal)
        //        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.sizeToFit()
        button.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let rightBarBtn = UIBarButtonItem(customView: button)
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -5;
        self.navigationItem.rightBarButtonItems = [spacer,rightBarBtn]
    }
    
    @objc func rightItemClick(){
        filterModel.sendName = nameTextField.text ?? ""
        filterModel.smsNum = logisticsNumTextField.text ?? ""
        dismissBlock?(filterModel)
       
        self.back()
    }
}
extension FilterViewController{
    
}
//extension FilterViewController:SelectDateDelegate{
//    func selectDate(dateString: String) {
//        if self.timeType == .begin{
////            startClickButton.isHidden = true
//            startTimeLabel.isHidden = false
//            pleaseSelectStartButton.isHidden = true
//            startCancelButton.isHidden = false
//            startTimeLabel.text = dateString
//
//            if !String.isNilOrEmpty(dateString){
//
//
//
//                filterModel.stime = dateString.replacingOccurrences(of: "-", with: "")
//            }
//
//
//        }
//        else if timeType == .end{
////            endClickButton.isHidden = true
//            endTimeLabel.isHidden = false
//            pleaseSelectEndButton.isHidden = true
//            endCancelButton.isHidden = false
//            endTimeLabel.text = dateString
//
//            if !String.isNilOrEmpty(dateString){
//                filterModel.etime = dateString.replacingOccurrences(of: "-", with: "")
//            }
//        }
//    }
//}


