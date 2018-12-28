//
//  CaijiBasicViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class CaijiBasicViewController: BaseViewController {

    var cellHeight:CGFloat = 417
//    var idCardFrontModel:IdCardFrontModel = IdCardFrontModel()
//    var idCardBackModel:IdCardFrontModel = IdCardFrontModel()
   
    var frontVc:UIViewController!
    var dateType = ""//0出生日期1证件有效期
    
    var csrq = ""
    @IBOutlet var tableView: UITableView!
    var dataController:CaijiBasicDataController!
    var isWrite = true
    override func viewDidLoad() {
        super.viewDidLoad()
    
 
        initData()
        initUI()
        isCanScanQuery()
        
    }
    deinit {
        print("基础信息页面销毁")
    }

  

}
extension CaijiBasicViewController{
    fileprivate func initUI(){
        initIdCardOcr()
        self.view.backgroundColor = viewBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("CaijiBasicIdCardTableViewCell")
        tableView.register("CaijiBasicContentTableViewCell")
        tableView.register("CaijiBasicSaveTableViewCell")
        
    }
    fileprivate func initData(){
        dataController = CaijiBasicDataController(delegate: self)
        if senderParam != nil{
            let dic = senderParam as! NSMutableDictionary
            if dic["title"] != nil{
                title = dic["title"] as! String
            }
            if dic["type"] != nil{
                dataController.type = dic["type"] as! String
            }
            if dic["saveModel"] != nil{
                dataController.saveModel = dic["saveModel"] as! CaijiSaveModel
            }
            
        }
        if dataController.type == "2"{
            isWrite = false
        }
        
        
    }
    func initIdCardOcr(){
        let licenseFile = Bundle.main.path(forResource: "aip", ofType: "license")
        let licenseFileData = NSData(contentsOfFile: licenseFile!) as! Data
//        let licenseFileData:NSData = try! NSData.init(contentsOfFile: licenseFile!)
        
        if licenseFileData.count > 0{
             AipOcrService.shard()?.auth(withLicenseFileData: licenseFileData)
        }else{
           print("失败")
            
        }
    }
    
   
    
}
extension CaijiBasicViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataController.cellCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = CaijiBasicIdCardTableViewCell.loadCell(tableView)
            cell.pro = self
//            dataController.isCan = false
            cell.update(flag: dataController.isCan, isWrite: isWrite)
            return cell
        }else if indexPath.row == 2{
            let cell = CaijiBasicSaveTableViewCell.loadCell(tableView)
            cell.pro = self
            return cell
        }else{
            let cell = CaijiBasicContentTableViewCell.loadCell(tableView)
            cell.pro = self
           
            cell.update(tableView: tableView, model: dataController.saveModel, isWrite: isWrite,indexPath:indexPath)
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return cellHeight
        }else{
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension CaijiBasicViewController:CaijiBasicIdCardPhotoClickProtoco{
   
    func idCardClick(_ type: IdCardType) {
        weak var weakSelf = self
        if type == .zheng{
            let vc = AipCaptureCardVC.viewController(with: .idCardFont) { (image) in
                AipOcrService.shard()?.detectIdCardFront(from: image, withOptions: nil, successHandler: { (info) in
                    weakSelf?.success(info:info,type:0)
                }, failHandler: { (error) in
                    weakSelf?.dismiss(animated: true, completion: nil)
                    print("error = \(error.debugDescription)")
                })
            }
            self.present(vc!, animated: true, completion: nil)
            
        }else if type == .fan{
            
            let vc = AipCaptureCardVC.viewController(with: .idCardBack) { (image) in
                AipOcrService.shard()?.detectIdCardBack(from: image, withOptions: nil, successHandler: { (info) in
                    weakSelf?.success(info:info,type:1)
                }, failHandler: { (error) in
                    weakSelf?.dismiss(animated: true, completion: nil)
                    print("error = \(error.debugDescription)")
                })
            }
            self.present(vc!, animated: true, completion: nil)
        }
    }
    func success(info:Any,type:Int){
        
        weak var weakSelf = self
        if type == 0{
            OperationQueue.main.addOperation {
                weakSelf?.scanCountQuery()
                let str = self.getJSONStringFromDictionary(dictionary: info as! NSDictionary)
                let temModel = Mapper<IdCardFrontModel>().map(JSONString: str)
                if temModel != nil{
                    weakSelf?.dataController.saveModel.name = temModel!.words_result.nameModel.words
                    weakSelf?.dataController.saveModel.xb = temModel!.words_result.sexModel.words
                    weakSelf?.dataController.saveModel.zjhm = temModel!.words_result.sfzhModel.words
                    weakSelf?.dataController.saveModel.csrq = temModel!.words_result.csrqModel.words
                    weakSelf?.dataController.saveModel.mz = temModel!.words_result.mzModel.words
                    weakSelf?.dataController.saveModel.txdz = temModel!.words_result.zzModel.words
                }
                
                
                self.dismiss(animated: true, completion: {
                    weakSelf?.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
                })
                
                
                
            }
        }else{
            OperationQueue.main.addOperation {
                weakSelf?.scanCountQuery()
                let str = self.getJSONStringFromDictionary(dictionary: info as! NSDictionary)
                let temModel = Mapper<IdCardFrontModel>().map(JSONString: str)
                if temModel != nil{
                    if temModel!.words_result.sxrqModel.words != "" && temModel!.words_result.sxrqModel.words != "长期"{
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyyMMdd"
                        let temDate = dateFormatter.date(from: temModel!.words_result.sxrqModel.words)
                        
                        let dateFormatter2 = DateFormatter()
                        dateFormatter2.dateFormat = "yyyy-MM-dd"
                        let zjyxq = dateFormatter2.string(from: temDate!)
                        
                        
                        weakSelf?.dataController.saveModel.zjyxq = zjyxq
                    }else if temModel!.words_result.sxrqModel.words == "长期"{
                        weakSelf?.dataController.saveModel.zjyxq = "长期"
                    }
                    
                   
                }
                self.dismiss(animated: true, completion: {
                    weakSelf?.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
                })
            }
            
        }
        
    }
   
    func faile(){
        weak var weakSelf = self
        OperationQueue.main.addOperation {
            weakSelf?.scanCountQuery()
            weakSelf?.dismiss(animated: true, completion: nil)
        }
        
    }
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    
}
extension CaijiBasicViewController:CaijiBasicNextProtocol,CaijiBasicContentSelectProtocol{
    func txdzChange(_ height: CGFloat) {
        cellHeight = height
    }
    
    func zjlxClick() {//证件类型
        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataController.dictionaryModel.data.zjlxMap,
            "selectIndexId":dataController.saveModel.zjlx
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            if weakSelf == nil{return}
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            weakSelf!.dataController.saveModel.zjlx = model.id
            weakSelf!.dataController.saveModel.zjlxName = model.name
            UIView.performWithoutAnimation {
                weakSelf?.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
            }
        }
    }
    
    func csrqClick() {//出生日期
        
        closeKeyboard()
        dateType = "0"
//        weak var weakSelf = self
        let dateView = SelectDateView(delegate: self,currentStr:dataController.saveModel.csrq)
        dateView.pro = self
        dateView.show()
    }
    
    func zjyxqClick() {//证件有效期
        closeKeyboard()
        dateType = "1"
        weak var weakSelf = self
        let dateView = SelectChangQiDateView(delegate: weakSelf!,currentStr:dataController.saveModel.zjyxq)
        dateView.pro = weakSelf!
        dateView.show()
        
    }
    
    func mzClick() {//民族
        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataController.dictionaryModel.data.mzMap,
            "selectIndexId":dataController.saveModel.mz
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            if weakSelf == nil{return}
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            weakSelf!.dataController.saveModel.mz = model.id
            weakSelf!.dataController.saveModel.mzName = model.name
            UIView.performWithoutAnimation {
                weakSelf?.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
            }
        }
    }
    
    func nextClick() {//下一步
        
        if checkFun(){
            let dic:NSMutableDictionary = [
                "title":self.title,
                "type":dataController.type,
                "saveModel":dataController.saveModel,
                "dictionaryModel":dataController.dictionaryModel
            ]
            if dataController.saveModel.zjlxName == "户口本" && dataController.saveModel.zjyxq == "长期"{
                pushViewController("CaijiJianHuRenViewController",sender:dic)
            }else{
                pushViewController("CaijiQiTaViewController",sender:dic)
            }
            
        }
        
        
    }
    func xbClick() {
        weak var weakSelf = self
        let dic:NSMutableDictionary = [
            "array":dataController.dictionaryModel.data.xbMap,
            "selectIndexId":dataController.saveModel.xb
        ]
        pushViewController("SelectViewController", sender: dic) { (info) in
            if weakSelf == nil{return}
            let dic = info as! NSMutableDictionary
            let model = dic["model"] as! DictionaryModel
            weakSelf!.dataController.saveModel.xb = model.id
            weakSelf!.dataController.saveModel.xbName = model.name
            UIView.performWithoutAnimation {
                weakSelf?.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
            }
        }
    }
}
extension CaijiBasicViewController:SelectDateDelegate{
    func selectDate(dateString: String) {
        if dateType == "0"{
            dataController.saveModel.csrq = dateString
            reloadTableViewContentCell()
        }else if dateType == "1"{
            dataController.saveModel.zjyxq = dateString
            reloadTableViewContentCell()
        }
        
    }
    func reloadTableViewContentCell(){
        UIView.performWithoutAnimation {
            self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
        }
    }
}
extension CaijiBasicViewController{
    func checkFun() -> Bool{
        closeKeyboard()
        let model = dataController.saveModel
        if model.name == ""{
            LHAlertView.showTipAlertWithTitle("姓名不能为空")
            return false
        }
        if model.xb == ""{
            LHAlertView.showTipAlertWithTitle("性别不能为空")
            return false
        }
        if model.zjlx == ""{
            LHAlertView.showTipAlertWithTitle("证件类型不能为空")
            return false
        }
        if  !model.zjhm.isLegalIdCard(){
            
            return false
        }
        if model.csrq == ""{
            LHAlertView.showTipAlertWithTitle("出生日期不能为空")
            return false
        }
        if model.zjyxq == ""{
            LHAlertView.showTipAlertWithTitle("证件有效期不能为空")
            return false
        }
        if model.mz == ""{
            LHAlertView.showTipAlertWithTitle("民族不能为空")
            return false
        }
        if model.txdz == ""{
            LHAlertView.showTipAlertWithTitle("通信地址不能为空")
            return false
        }
        return true
    }
    //扫描身份证是否可用
    fileprivate func isCanScanQuery(){
        
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone
        ]
        weak var weakSelf = self
        dataController.scanQuery(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                if weakSelf == nil{return}
                weakSelf!.getDictionary()
            }else {
                //TODO
                
            }
        }
    }
    //扫描身份证使用
    fileprivate func scanCountQuery(){
        
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone
        ]
        
        dataController.scanCountQuery(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                
            }else {
                //TODO
                
            }
        }
    }
    //国标项
    fileprivate func getDictionary(){
        
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone
        ]
        weak var weakSelf = self
        dataController.getDictionary(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                if weakSelf == nil{return}
                weakSelf!.tableView.reloadData()
            }else {
                //TODO
                
            }
        }
    }
}
