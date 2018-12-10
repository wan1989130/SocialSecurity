//
//  DeliverGoodsViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import ObjectMapper
class DeliverGoodsViewController: BaseViewController {

//    var index = 0
    
    var defaultAddress = ["吉林省","长春市","南关区"]
    var ocrModel:OcrDataModel!
    var photos:Array<SKPhoto> = [SKPhoto]()
    var imagePicker:TZImagePickerController!
    @IBOutlet weak var tableView: UITableView!
    var dataController:DeliverGoodsDataController!
    let numLable = UILabel.init(frame: CGRect(x: 16, y: 0, width: 14, height: 14))
    var saveModel = DeliverGoodsSaveModel()
    var time = ""
    var hud:MBProgressHUD!
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        time = timeFormatter.string(from: date as Date) as String
        initData()
        initUI()
        informationQueryByPage()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let sql = "select * from MyTable where loginName = '\(MyConfig.shared().loginName)' and time = '\(time)' "
        let resultArr = FMDBHelper.shared().selectDBWithSQL(sql: sql)
        if resultArr.count > 0 {
            numLable.isHidden = false
            numLable.text = String(resultArr.count)
        }else{
            numLable.isHidden = true
        }
    }
}



extension DeliverGoodsViewController{
    fileprivate func initData(){
        
        dataController = DeliverGoodsDataController(delegate: self)

        saveModel.sendDate = time
    }
    
    fileprivate func initUI(){
        self.edgesForExtendedLayout = .top
        initTableView()
        loadRightBarButtonItem()
    }
    /**
     * 加载导航栏右侧按钮
     */
    fileprivate func loadRightBarButtonItem(){
        let button =   UIButton(type: .system)
        button.frame = CGRect(x:0, y:0, width:30, height:30)
        button.setImage(UIImage(named:"remark"), for: .normal)
        button.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        
        let customView = UIView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
     
        numLable.backgroundColor = UIColor.red
        numLable.text = "22"
        numLable.font = UIFont.systemFont(ofSize: 10)
        numLable.textColor = UIColor.white
        numLable.clipsToBounds = true
        numLable.layer.cornerRadius = 7
        numLable.textAlignment = .center
        customView.addSubview(button)
        customView.addSubview(numLable)
        let rightBarBtn = UIBarButtonItem(customView: customView)
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    
    @objc func rightItemClick(){
       
        pushViewController("RemarkListViewController")
        
    }
}
extension DeliverGoodsViewController{
    fileprivate func initTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.clear
        tableView.register("SendPersonMessageTableViewCell")//发货人信息
        tableView.register("SendGoodsMessageTableViewCell")//发货信息cell
        tableView.register("GetPersonMessageTableViewCell")//发货人信息cell
        tableView.register("PhotoTableViewCell")//照片
        tableView.register("SendGoodsSaveButtonTableViewCell")//保存
        
        
    }
}
extension DeliverGoodsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = SendPersonMessageTableViewCell.loadCell(tableView)
            cell.delegate = self
            cell.update(tableView:self.tableView,model:saveModel)
            return cell
        }else if indexPath.row == 1{
            let cell = SendGoodsMessageTableViewCell.loadCell(tableView)
            cell.delegate = self
            cell.update(tableView:self.tableView,model:saveModel)
            return cell
        }else if indexPath.row == 2{
            let cell = GetPersonMessageTableViewCell.loadCell(tableView)
            cell.delegate = self
            
            cell.update(tableView:self.tableView,model:saveModel)
            return cell
        }else if indexPath.row == 3{
            let cell = PhotoTableViewCell.loadCell(tableView)
            cell.update(model: saveModel)
            cell.delegate = self
            return cell
        }else if indexPath.row == 4{
            let cell = SendGoodsSaveButtonTableViewCell.loadCell(tableView)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}
// MARK: - 接口
extension DeliverGoodsViewController {
    

    //保存接口
    func saveRequest(){

        var photoStr = "|"
        for item in saveModel.sendPhotoStatusModel{
            photoStr = photoStr + item.urlSendGoods + "|"
        }
        photoStr = (photoStr as NSString).substring(to: photoStr.count - 1)
        saveModel.photo = photoStr
        let jsonStr = saveModel.toJSONString()
        let parameter:NSMutableDictionary = [
            "info":jsonStr
            
        ]
        dataController.addShippingInfo(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.saveModel = DeliverGoodsSaveModel()
                self.tableView.reloadData()
                print("保存成功")
            }else {
                
            }
        }
    }
    //根据发货人身份证号查找发货人、收货人信息
    func getUserByCard(card:String){
        let parameter:NSMutableDictionary = [
            "card":card,
            "cid":MyConfig.shared().companyId
            
        ]
        dataController.getUserByCard(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.updateSavemodel()
                self.tableView.reloadData()
            }else {
                
            }
        }
    }
    
    //跑马灯，资讯信息第一条记录
    fileprivate func informationQueryByPage() {
      
        let parameter:NSMutableDictionary = [
            "pageNo":1,
            "categoryId":"b784dd36c4fc459a972c5d008bcb30ac"
        ]
        dataController.informationList(parameter: parameter) { (isSucceed, result) in
            if isSucceed{
                if self.dataController.model.data.count > 0{
                    self.addPaomaView()
                }
            }
        }
    }
    
    func addPaomaView(){
        let paomaView = TTPaomaView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 30))
        
        paomaView.setText(text:"【最新通知公告】" + dataController.model.data[0].title + "  点击查看详情>>")
        paomaView.backgroundColor = UIColor(hexString: "42BAE7")
        paomaView.textColor = .white
        paomaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addPopViewClicked(tap:))))
        
        tableView.tableHeaderView = paomaView
    }
    @objc func addPopViewClicked(tap:UITapGestureRecognizer){
        pushViewController("InformationMessageDetailViewController",sender:dataController.model.data[0].id)
    }
    
    func getAreaList(type:String){//1发货地址2收获地址
        closeKeyboard()
        if (dataController.areaModel.data.children?.count ?? 0) < 1{
            let parameter:NSMutableDictionary = [:]
            dataController.areaList(parameter: parameter) { (isSucceed, result) in
                if isSucceed{
                    if self.dataController.model.data.count > 0{
                        self.showSelectAddress(type: type)
                    }
                }
            }
        }else{
            self.showSelectAddress(type: type)
        }
       
    }
    func showSelectAddress(type:String){
        
        var json = dataController.areaModel.data.toJSON()
        if type == "1"{
            BRAddressPickerView.showAddressPicker(withShowType: .area, dataSource: json["children"] as? [Any], defaultSelected: defaultAddress, isAutoSelect: false, themeColor: UIColor.darkGray, resultBlock: { (provinceModel, cityModel, areaModel) in
//                [saveModel.provinceSend,saveModel.citySend,saveModel.districtSend]
                
                
                let cell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! SendGoodsMessageTableViewCell
                
                self.saveModel.provinceSend = provinceModel!.region_name
                self.saveModel.citySend = cityModel!.region_name
                
                var address = ""
                if areaModel?.region_name == ""{
                    address = provinceModel!.region_name + cityModel!.region_name
                    self.saveModel.districtSend = ""
                    self.saveModel.sendAid = cityModel!.region_id
                }else{
                    self.saveModel.districtSend = areaModel!.region_name
                    address = provinceModel!.region_name + cityModel!.region_name + areaModel!.region_name
                    self.saveModel.sendAid = areaModel!.region_id
                }
                self.saveModel.tempSendAddress = address
                cell.selectAddressButton.setTitle(address, for: .normal)
                
                
            }) {
                print("取消")
            }
        }else if type == "2"{
            BRAddressPickerView.showAddressPicker(withShowType: .area, dataSource: json["children"] as? [Any], defaultSelected: defaultAddress, isAutoSelect: false, themeColor: UIColor.darkGray, resultBlock: { (provinceModel, cityModel, areaModel) in
                
                let cell = self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! GetPersonMessageTableViewCell
                
                self.saveModel.provinceGet = provinceModel!.region_name
                self.saveModel.cityGet = cityModel!.region_name
                
                var address = ""
                if areaModel?.region_name == ""{
                    address = provinceModel!.region_name + cityModel!.region_name
                    self.saveModel.districtGet = ""
                    self.saveModel.getAid = cityModel!.region_id
                }else{
                    self.saveModel.districtGet = areaModel!.region_name
                    address = provinceModel!.region_name + cityModel!.region_name + areaModel!.region_name
                    self.saveModel.getAid = areaModel!.region_id
                }
                self.saveModel.tempGetAddress = address
                cell.selectAddressButton.setTitle(address, for: .normal)
                
                
            }) {
                print("取消")
            }
        }
       
    }
    
    //上传图片接口
    fileprivate func uploadPortrait(portrait:UIImage){
        let parameter:NSMutableDictionary = [
            "typeFile":"0",
            "loginName":MyConfig.shared().loginName
        ]
        let imageData:Data = portrait.jpegData(compressionQuality: 1) ?? Data()
        dataController.uploadPhoto(imgDataArray:  [imageData], parameter: parameter) { (isSucceed, info) in
             let cell = self.tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as!PhotoTableViewCell
            if isSucceed{
               
                cell.sendPersonPhotoButton.setBackgroundImage(portrait, for: .normal)
                cell.deleteBtn.isHidden = false
                cell.sendPersonSuccessLabel.isHidden = false
                cell.sendPersonSuccessLabel.text = "上传成功"
                cell.againButton.isHidden = true
                self.saveModel.sendCardFullface = self.dataController.uploadPhotoModel.data
            }else{
                cell.deleteBtn.isHidden = false
                cell.sendPersonPhotoButton.setBackgroundImage(portrait, for: .normal)
                cell.againButton.isHidden = false
                cell.oneLabel.isHidden = true
                cell.twoLabel.isHidden = true
                cell.sendPersonSuccessLabel.isHidden = false
                cell.sendPersonSuccessLabel.text = "上传失败"
                print("上传失败")
                
            }
        }
    }
    
    //上传身份证
    fileprivate func uploadCard(portrait:UIImage){
//        if index == 0{
//            LHHTTPClient.sharedClientWithIdentifier(FileServerClientIdentifier).basePath = ""
//            index = index + 1
//        }else{
//            LHHTTPClient.sharedClientWithIdentifier(FileServerClientIdentifier).basePath = FileServerAddress
//        }
        let parameter:NSMutableDictionary = [
            "typeFile":"0",
            "loginName":MyConfig.shared().loginName
        ]

        let imageData:Data = imageWithImageSimple(image: portrait, newSize: portrait.size)
        dataController.uploadCard(imgDataArray:  [imageData], parameter: parameter) { (isSucceed, info) in
            self.saveModel.imageSendPhoto = portrait
            if isSucceed{
                self.updateOcrUI(portrait: portrait)
                
            }else{
                let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! SendPersonMessageTableViewCell
                cell.cardImageButton.setBackgroundImage(portrait, for: .normal)
               cell.againButton.isHidden = false
                cell.cardImageSuccessLabel.text = "上传失败"
            }
            
        }
    }
    func updateSavemodel(){
        if dataController.tempSavemodel != nil{
            let tempModel = dataController.tempSavemodel!.data
            saveModel.sendSex = tempModel.sendSex
            saveModel.sendMz = tempModel.sendMz
            saveModel.sendCsrq = tempModel.sendCsrq
            saveModel.sendName = tempModel.sendName
            saveModel.sendName = tempModel.sendName
            saveModel.sendCard = tempModel.sendCard
            saveModel.sendPhone = tempModel.sendPhone
            
            
            saveModel.sendAddress = tempModel.sendAddress
            saveModel.sendAid = tempModel.sendAid
            saveModel.sendCardAddress = tempModel.sendCardAddress
            saveModel.tempGetAddress = tempModel.getANameParentP + tempModel.getANameParent + tempModel.getAName
            saveModel.tempSendAddress = tempModel.sendANameParentP + tempModel.sendANameParent + tempModel.sendAName

            
            
            
            saveModel.getName = tempModel.getName
            saveModel.getPhone = tempModel.getPhone
            saveModel.getAddress = tempModel.getAddress
            saveModel.getAid = tempModel.getAid
            
        }
    }
}
//发货信息
extension DeliverGoodsViewController: SelectSendAddressDelegate{

    
    func selectAddress() {
        closeKeyboard()
        getAreaList(type: "1")
    }
    func selectTime() {
        closeKeyboard()
        var datepicker2 = WSDatePickerView.init(dateStyle: DateStyleShowYearMonthDay) { (selectDate) in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormat.string(from: selectDate!)
            self.saveModel.sendDate = dateString
            let cell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! SendGoodsMessageTableViewCell
            cell.selectTimeButton.setTitle(dateString, for: .normal)
        }
        datepicker2?.doneButtonColor = UIColor.lightGray.withAlphaComponent(0.2)
        datepicker2?.dateLabelColor = UIColor.darkGray
        datepicker2?.datePickerColor = UIColor.darkGray
        
        datepicker2?.show()
//        let dateView = SelectDateView(delegate: self,currentStr:saveModel.sendDate)
//        dateView.pro = self
//        dateView.show()
    }
}
//发货信息 - 时间
//extension DeliverGoodsViewController:SelectDateDelegate{

//    func selectDate(dateString: String) {
//        closeKeyboard()
//        saveModel.sendDate = dateString
//         let cell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! SendGoodsMessageTableViewCell
//        cell.selectTimeButton.setTitle(dateString, for: .normal)
//    }
//}
//收货信息
extension DeliverGoodsViewController:SelectGetPersonDelegate{
    func selectGetPersonAddress() {
        getAreaList(type: "2")
    }
}
//图片
extension DeliverGoodsViewController:SendGoodsPhotoDelegate {
    func sendPersonPhotoClickAgain() {
        self.uploadPortrait(portrait: self.saveModel.imageSendPersonPhoto!)
    }
    func sendPersonPhotoClick(isSelect: Bool) {
        if isSelect{
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePicker, animated: true, completion: nil)
            }
        }else{
            var photo:SKPhoto!
            photo = SKPhoto.photoWithImage(saveModel.imageSendPersonPhoto ?? UIImage())
            photos.removeAll()
            photos.append(photo)
            let browser = SKPhotoBrowser(photos: photos)
//            browser.initializePageIndex(tap.view!.tag)
//            browser.delegate = self as SKPhotoBrowserDelegate
            SKPhotoBrowserOptions.displayAction = false
            //        SKPhotoBrowserOptions.actionButtonTitles = ["保存"]
            SKPhotoBrowserOptions.displayBackAndForwardButton = false
            BaseViewController.getCurrentVC().present(browser, animated: true, completion: {})
        }
    }
    //删除发货人近照
    func sendPersonPhotoDeleteClick() {
        saveModel.imageSendPersonPhoto = nil
        saveModel.assetSendPersonPhoto = nil
        saveModel.sendCardFullface = ""
    }
    func sendGoodsClick() {
        pushViewController("SendGoodsPhotoViewController", sender: saveModel) { (info) in
            self.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .none)
        }
    }
}
extension DeliverGoodsViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //调用系统相册及拍照功能实现方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if picker.view.tag == 100{
            let chosenImage:UIImage = info[.originalImage] as! UIImage
            
            //调用ocr
            picker.dismiss(animated: true) {
                self.ocrFunction(portrait: chosenImage)
            }
        }else{
            let chosenImage:UIImage = info[.originalImage] as! UIImage
            
            //TODO WY
            picker.dismiss(animated: true) {
                self.saveModel.imageSendPersonPhoto = chosenImage
                self.uploadPortrait(portrait: chosenImage)
            }
        }
       
    }
}


//点击保存
extension DeliverGoodsViewController:SendGoodsSaveDelegate {
    func saveClick() {
        closeKeyboard()
        
        if checkFun(){
            saveRequest()
        }
        
    }
    //提交前check
    func checkFun()->Bool{
        if saveModel.sendName == "" || saveModel.sendSex == "" || saveModel.sendMz == "" || saveModel.sendCard == "" || saveModel.sendCardAddress == "" || saveModel.sendCsrq == ""{
            LHAlertView.showTipAlertWithTitle("证件信息识别不全，请重新识别")
            return false
        }else if saveModel.smsNum == ""{
            LHAlertView.showTipAlertWithTitle("物流单号不能为空")
            return false
        }else if saveModel.name == ""{
            LHAlertView.showTipAlertWithTitle("货物名称不能为空")
            return false
        }else if saveModel.sendPhone == ""{
            LHAlertView.showTipAlertWithTitle("联系电话不能为空")
            return false
        }else if saveModel.sendAid == ""{
            LHAlertView.showTipAlertWithTitle("联系地点不能为空")
            return false
        }else if saveModel.sendAddress == ""{
            LHAlertView.showTipAlertWithTitle("详细地址不能为空")
            return false
        }else if saveModel.sendDate == ""{
            LHAlertView.showTipAlertWithTitle("发货时间不能为空")
            return false
        }else if saveModel.getName == ""{
            LHAlertView.showTipAlertWithTitle("收货人不能为空")
            return false
        }else if saveModel.getPhone == ""{
            LHAlertView.showTipAlertWithTitle("联系电话不能为空")
            return false
        }else if saveModel.getAid == ""{
            LHAlertView.showTipAlertWithTitle("收货地点不能为空")
            return false
        }else if saveModel.getAddress == ""{
            LHAlertView.showTipAlertWithTitle("详细地址不能为空")
            return false
        }else if saveModel.sendCardFullface == ""{
            LHAlertView.showTipAlertWithTitle("发货人近照不能为空")
            return false
        }else if saveModel.sendPhotoStatusModel.count < 1{
            LHAlertView.showTipAlertWithTitle("发货物品近照不能为空")
            return false
        }
        
        return true
    }
    
}
//身份证识别
extension DeliverGoodsViewController:SendPersonMessageCardClickDelegate{
    //重新上传头像
    func sendPersonMessageCardClickAgain() {
        if saveModel.imageSendPhoto != nil{
            self.uploadCard(portrait: saveModel.imageSendPhoto!)
        }
        
    }
    func cardImageSelect() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.view.tag = 100
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //上传图片接口
    fileprivate func ocrFunction(portrait:UIImage){
        self.showHud()
        let imageData:Data = portrait.jpegData(compressionQuality: 0.5) ?? Data()
        let type = "2"
        let option = ""
        let password = "null"
        var imageBase64String = imageData.base64EncodedString()
//        imageBase64String = "aaaa"
        let paramdata = imageBase64String + "==##" + type + "==##" + option + "==##" + password
        
        let parameter:NSMutableDictionary = [
            "username":"test",
            "paramdata":paramdata,
            "signdata":"NULL",
            "imgtype":"jpg"
        ]
        let manager = AFHTTPSessionManager()
//        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
            manager.requestSerializer.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
//        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript") as? Set<String>
                manager.responseSerializer.acceptableContentTypes = nil
        manager.requestSerializer.timeoutInterval = 40
        
        manager.post(OcrAddress,
                     parameters: parameter,
                     progress: nil,
                     success: { (task, responseObject) in
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                        
                        let result = self.getJSONStringFromDictionary(dictionary: responseObject as! NSDictionary)
                         self.ocrModel = Mapper<OcrDataModel>().map(JSONString: result)
                        print("返回的数据 = \(result)")
                        if self.ocrModel.data.message.status == 2{
                            
                            self.imageToBase64()
                            self.getUserByCard(card: self.ocrModel.data.cardsinfo.card.item[6].content)
                        }else{
                            LHAlertView.showTipAlertWithTitle(self.ocrModel.data.message.value)
                        }
                        
                        
                        
                        if self.hud != nil{
                            self.hideHud()
                        }
                        
                     
                        
                        
        },
                     failure: { (task, error) in
                        if self.hud != nil{
                            self.hideHud()
                        }
                        
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                      
        })
   
    }
    func showHud(){
        hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.label.text = "数据加载中"
    }
    func hideHud(){
        hud.hide(animated: true)
        hud = nil
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
    func imageToBase64(){
        saveModel.sendName = ocrModel.data.cardsinfo.card.item[1].content
        saveModel.sendSex = ocrModel.data.cardsinfo.card.item[2].content
        saveModel.sendMz = ocrModel.data.cardsinfo.card.item[3].content
        saveModel.sendCsrq = ocrModel.data.cardsinfo.card.item[4].content
        saveModel.sendCardAddress = ocrModel.data.cardsinfo.card.item[5].content
        saveModel.sendCard = ocrModel.data.cardsinfo.card.item[6].content
        
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! SendPersonMessageTableViewCell
        cell.isShowWriteButton(flag: false)
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
        
        
            let imageData2 = Data(base64Encoded: ocrModel.data.cardsinfo.card.item[7].content)
            // 将Data转化成图片
            let image2 = UIImage(data: imageData2!)
            
            var imageData = Data(base64Encoded: self.ocrModel.data.cardsinfo.card.item[7].content, options: .ignoreUnknownCharacters)
            if imageData == nil {
                imageData = Data(base64Encoded: self.ocrModel.data.cardsinfo.card.item[7].content + "==", options: .ignoreUnknownCharacters) //如果数据不正确，添加"=="重试
            }
            
            var image:UIImage?
            if imageData != nil {
                image = UIImage(data: imageData!) //转换内容
            }
            self.uploadCard(portrait: image!)
    }
    func updateOcrUI(portrait:UIImage){
      
        self.saveModel.sendPhoto = self.dataController.uploadCardModel.data
        
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! SendPersonMessageTableViewCell
        cell.againButton.isHidden = true
        cell.cardImageSuccessLabel.text = "上传成功"
        cell.cardImageSuccessLabel.isHidden = false
        cell.cardImageButton.setBackgroundImage(portrait, for: .normal)
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
        
        
    }
    
    //压缩图片
    fileprivate func imageWithImageSimple(image:UIImage,newSize:CGSize)->Data{
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        var compress:CGFloat = 1
        var data = newImage.jpegData(compressionQuality: compress)
        var maxLength = 200 * 1024
        
        while data!.count > maxLength && compress > 0.01 {
            compress -= 0.02
            data = newImage.jpegData(compressionQuality: compress)
        }
//        let tempImage = UIImage(data: data!)
//        UIGraphicsEndImageContext();
        return data!
        
    }
}
