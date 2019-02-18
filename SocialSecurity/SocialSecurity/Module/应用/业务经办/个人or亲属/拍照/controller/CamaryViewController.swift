//
//  CamaryViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/21.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CamaryViewController: BaseViewController {

    var alert:UIAlertController!
    var dataController:CamaryDataController!
    var isWrite = true
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endLoad()
    }
    @IBAction func nextClick(_ sender: Any) {
        if checkFun(){
//            if title == "亲属代办"{
                let dic:NSMutableDictionary = [
                    "title":self.title,
                    "type":dataController.type,
                    "saveModel":dataController.saveModel,
                    "dictionaryModel":dataController.dictionaryModel
                ]
//                pushViewController("DaiBanPersonViewController",sender:dic)
                if dataController.saveModel.zjlxName == "户口本" && dataController.saveModel.zjyxq == "长期" || dataController.saveModel.zjlxName.contains("身份证") && getCurrentAge() < 16{
                    pushViewController("CaijiJianHuRenViewController",sender:dic)
                }else{
                    pushViewController("CaijiQiTaViewController",sender:dic)
                }
//            }else{
//                addOrUpdate()
//            }
            
        }
        
        
    }
    @IBAction func photoClick(_ sender: Any) {
        present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var photoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        initAlert()
    }

    deinit {
        print("拍照页面销毁")
    }

}
extension CamaryViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        
        
    }
    fileprivate func initData(){
        dataController = CamaryDataController(delegate: self)
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
            if dic["dictionaryModel"] != nil{
                dataController.dictionaryModel = dic["dictionaryModel"] as! DictionaryDataModel
            }
            if dataController.saveModel.zp != ""{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let str = "&" + formatter.string(from: Date())
                photoButton.sd_setBackgroundImage(with: URL.init(string: FileAccessHost + dataController.saveModel.zp + str), for: .normal, completed: nil)
                
            }
            
        }
        
        
        if dataController.type == "2"{
            isWrite = false
        }
        
    }
    fileprivate func initAlert(){
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.view.tintColor = UIColor.black
        weak var weakSelf = self
        //通过拍照上传图片
        let takingPicAction:UIAlertAction = UIAlertAction(title: "拍照", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = weakSelf
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                weakSelf?.present(imagePicker, animated: true, completion: nil)
            }
        }
        //从手机相册中选择上传图片
        //UIImagePickerControllerSourceTypePhotoLibrary 相册 来自图库
//        UIImagePickerControllerSourceTypeSavedPhotosAlbum 相簿 来自相册
//        UIImagePickerControllerSourceTypeCamera 相机
        
     
        let okAction:UIAlertAction = UIAlertAction(title: "相册", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = weakSelf
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                weakSelf?.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        let cancelAction:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
        }
        alert.addAction(takingPicAction)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
    }
    
    //上传图片接口
    fileprivate func uploadPortrait(image:UIImage){
        let imageData:Data  = image.imageWithImageSimple(newSize:CGSize(width: 358, height: 441), maxLength: 50 * 1024)
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone,
            "remark":"0",
            "typeFile":"0",
            "name":dataController.saveModel.zjhm
        ]
        weak var weakSelf = self
        beginLoad()
        dataController.uploadPhoto(imgDataArray:  [imageData], parameter: parameter) { (isSucceed, info) in
            if isSucceed{
                if weakSelf == nil{return}
                weakSelf!.dataController.saveModel.zp = weakSelf!.dataController.uploadPhotoModel.data.imageUrl
                print("成功")
            }else{
                weakSelf?.photoButton.setBackgroundImage(UIImage.init(named: "ic_id_photo"), for: .normal)
                print("失败")
            }
            weakSelf?.endLoad()
            
        }
    }
    
    
    //录入和修改
    fileprivate func addOrUpdate(){
        if dataController.saveModel.zjyxq != ""{
            dataController.saveModel.zjyxq = (dataController.saveModel.zjyxq as NSString).replacingOccurrences(of: "-", with: "")
        }
        let parameter:NSMutableDictionary = [
            "phone":MyConfig.shared().phone,
            "cbInsured":dataController.saveModel.toJSONString(),
           
        ]
        
       
        weak var weakSelf = self
        dataController.addOrUpdate(parameter: parameter) { (isSucceed, info) in
            if weakSelf == nil{return}
            if isSucceed {
                weakSelf!.returnMain()
            }else {
                
            }
        }
        
    }
    func returnMain(){
        for vc in (self.navigationController?.viewControllers)!{
            if vc is YwjbViewController{
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    
    
    
}
extension CamaryViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //调用系统相册及拍照功能实现方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage:UIImage = info[.originalImage] as! UIImage
        
        //调用接口
        weak var weakSelf = self
        picker.dismiss(animated: false) {
            let clipper = SwiftyPhotoClipper()
            clipper.delegate = self
            clipper.img = chosenImage
            weakSelf?.present(clipper, animated: true, completion: {
                
            })
            
           
        }
    }
    //判断像素点色值
    func getPixColor() -> Bool{
        let pixPoint = [
        CGPoint(x: 0, y: 0),CGPoint(x: 1, y: 0),CGPoint(x: 2, y: 0),CGPoint(x: 0, y: 1),CGPoint(x: 1, y: 1),CGPoint(x: 0, y: 2),
        CGPoint(x: photoButton.frame.width - 3, y: 0),CGPoint(x: photoButton.frame.width - 2, y: 0),CGPoint(x: photoButton.frame.width - 1, y: 0),
        CGPoint(x: photoButton.frame.width - 2, y: 1),CGPoint(x: photoButton.frame.width - 1, y: 1),CGPoint(x: photoButton.frame.width - 1, y: 2)
        ]
        for item in pixPoint{
            
                let (a,r,g,b) = photoButton.pickColor(at: item)!
                // 判断不能有透明，色值在200以上，rgb三个值上下浮动在10以内
//            if a != 255 || r < 200 || g < 200 || b < 200 ||
//                ((r - b) > 10 || (b - r) > 10) ||
//                ((r - g) > 10 || (g - r) > 10) ||
//                ((g - b) > 10 || (b - g) > 10) {
//                LHAlertView.showTipAlertWithTitle("图片背景不是白色")
//                photoButton.setBackgroundImage(UIImage.init(named: "ic_id_photo"), for: .normal)
//
//                return false
//            }
            if r < 230 || g < 230 || b < 230  {
                LHAlertView.showTipAlertWithTitle("图片背景不是白色")
                photoButton.setBackgroundImage(UIImage.init(named: "ic_id_photo"), for: .normal)
                
                return false
            }
        }
        return true
    }
    //判断颜色是不是黑白
    func checkPixColor() -> Bool{
        let height = Int(photoButton.frame.height)
        let width = Int(photoButton.frame.width)
        for i in 0..<width{
            for j in 0..<height{
                let (a,r,g,b) = photoButton.pickColor(at: CGPoint(x: i, y: j))!
                if r != b && r != g && b != g{
                    return true
                }
            }
        }
        photoButton.setBackgroundImage(UIImage.init(named: "ic_id_photo"), for: .normal)
        LHAlertView.showTipAlertWithTitle("照片不能是黑白照片")
        return false
    }
    
}
extension CamaryViewController:SwiftyPhotoClipperDelegate{
    func didFinishClippingPhoto(image: UIImage) {
        self.photoButton.setBackgroundImage(image, for: .normal)
        if self.checkPixColor(){
            if self.getPixColor(){
                self.uploadPortrait(image: image)
                //                    weakSelf.present(clipper, animated: true, completion: nil)
                
            }
        }
        
    }
}
extension CamaryViewController{
    func checkFun() -> Bool{
        
        let model = dataController.saveModel
        if model.zp == ""{
            LHAlertView.showTipAlertWithTitle("请上传照片")
            return false
        }
        
        return true
    }
    
    
    //根据生日计算当前周岁
    func getCurrentAge() -> Int{
        //        let date = NSDate()
        //        let timeFormatter = DateFormatter()
        //        timeFormatter.dateFormat = "yyyyMMdd"
        //        let curr = timeFormatter.string(from: date as Date) as String
        ////        let curr:Int = Int(selectTime)!
        //        let born = (dataController.saveModel.csrq as NSString).replacingOccurrences(of: "-", with: "")
        //        let age = Int((curr as NSString).substring(with: NSRange.init(location: 0, length: 4)))! - Int((born as NSString).substring(with: NSRange.init(location: 0, length: 4)))!
        //        if  age <= 0{
        //            return 0
        //        }
        
        //格式化日期
        
        let d_formatter = DateFormatter()
        d_formatter.dateFormat = "yyyy-MM-dd"
        let birthDay_date = d_formatter.date(from: dataController.saveModel.csrqStr)
        // 出生日期转换 年月日
        
        let birthdayDate = NSCalendar.current.dateComponents([.year,.month,.day], from: birthDay_date!)
        let brithDateYear  = birthdayDate.year
        let brithDateDay   = birthdayDate.day
        let brithDateMonth = birthdayDate.month
        // 获取系统当前 年月日
        let currentDate = NSCalendar.current.dateComponents([.year,.month,.day], from: Date())
        let currentDateYear  = currentDate.year
        let currentDateDay   = currentDate.day
        let currentDateMonth = currentDate.month
        // 计算年龄
        var iAge = currentDateYear! - brithDateYear! - 1;
        if ((currentDateMonth! > brithDateMonth!) || (currentDateMonth! == brithDateMonth! && currentDateDay! >= brithDateDay!)) {
            iAge += 1
        }
        return iAge
        
        
        
        
    }
}
