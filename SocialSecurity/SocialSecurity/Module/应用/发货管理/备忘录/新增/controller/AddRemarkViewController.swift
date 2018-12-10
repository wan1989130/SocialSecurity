//
//  AddRemarkViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/13.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class AddRemarkViewController: BaseViewController {

    
    @IBOutlet weak var timeSwitch: UISwitch!
    @IBOutlet weak var contentTextView: UIPlaceholderTextView!
    
    @IBOutlet weak var wordsCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var time = ""
    var idModel:RemarkModel!
    
    
    @IBAction func switchChange(_ sender: UISwitch) {
        if sender.isOn{
            let dateView = SelectDateView(delegate: self,currentStr:time)
//            dateView.pro = self
            dateView.show()
//            var datepicker2 = WSDatePickerView.init(dateStyle: DateStyleShowYearMonthDay) { (selectDate) in
//                let dateFormat = DateFormatter()
//                dateFormat.dateFormat = "yyyy-MM-dd"
//                let dateString = dateFormat.string(from: selectDate!)
//                if self.idModel != nil{
//                    self.idModel.time = dateString
//                }
//                self.time = dateString
//                self.timeLabel.text = self.time
//            }
//            datepicker2?.doneButtonColor = UIColor.lightGray.withAlphaComponent(0.2)
//            datepicker2?.dateLabelColor = UIColor.darkGray
//            datepicker2?.datePickerColor = UIColor.darkGray
//            
//            datepicker2?.show()
        }else if !sender.isOn{
            if idModel != nil{
                idModel.time = ""
            }
            timeLabel.text = ""
            time = ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑备忘录"
        initData()
        initUI()
    }


    

}
extension AddRemarkViewController{
    fileprivate func initData(){
        if senderParam != nil{
            let dic = senderParam as! NSMutableDictionary
            if dic["idModel"] != nil{
                idModel = dic["idModel"] as! RemarkModel
            }
            
        }
    }
    
    fileprivate func initUI(){
        if idModel != nil{
            contentTextView.text = idModel.content
            if idModel.time == ""{
                timeSwitch.isOn = false
            }else{
                timeSwitch.isOn = true
                timeLabel.text = idModel.time
                time = idModel.time
            }
        }
        contentTextView.delegate = self
        contentTextView.placeholder = "请输入内容"
        loadRightBarButtonItem()
    }
    /**
     * 加载导航栏右侧按钮
     */
    fileprivate func loadRightBarButtonItem(){
        let button =   UIButton(type: .system)
        button.frame = CGRect(x:0, y:0, width:30, height:30)
        button.setTitle("保存", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let rightBarBtn = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    @objc func rightItemClick(){
        if String.isNilOrEmpty(contentTextView.text){
            LHAlertView.showTipAlertWithTitle("请输入内容")
            return
        }

        
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "MM月dd日\n HH:mm"
        let showTime = timeFormatter.string(from: date as Date) as String

        if idModel == nil{
  
            
            let sql = "insert into MyTable VALUES(null,'\(time)','\(MyConfig.shared().loginName)','\(contentTextView.text!)','\(showTime)')"
            FMDBHelper.shared().insertDBWithSQL(sql: sql)
        }else{
           
            let sql = "update MyTable set content = '\(contentTextView.text!)',time = '\(idModel.time)',showTime = '\(showTime)' where id = '\(idModel.autoId)'"
            FMDBHelper.shared().updateDBWithSQL(sql: sql)
        }
        dismissBlock?("")
        self.navigationController?.popViewController(animated: true)
        
    }
}
//extension AddRemarkViewController:SelectDateDelegate{
//    func selectDate(dateString: String) {
//        if idModel != nil{
//            idModel.time = dateString
//        }
//        time = dateString
//        timeLabel.text = time
//    }
//}
extension AddRemarkViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if (textView.markedTextRange == nil && textView.text.count >= 500) {
            if contentTextView.text != nil{
                contentTextView.text = (textView.text! as NSString).substring(to: 500)
            }
        }
        if contentTextView.text == nil{
            wordsCountLabel.text = "0"
        }else{
            wordsCountLabel.text = String(contentTextView.text.count)
        }
        var temBounds = textView.bounds
        let constraint = CGSize(width: temBounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let size = textView.sizeThatFits(constraint)
        temBounds.size = size
        textView.bounds = temBounds
        
    }
}

