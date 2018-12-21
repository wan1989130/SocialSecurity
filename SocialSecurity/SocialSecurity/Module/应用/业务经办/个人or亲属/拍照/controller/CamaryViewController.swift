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
    var dataController:CaijiQiTaDataController!
    var isWrite = true
    @IBAction func nextClick(_ sender: Any) {
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


}
extension CamaryViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        
        
    }
    fileprivate func initData(){
        dataController = CaijiQiTaDataController(delegate: self)
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
                weakSelf!.present(imagePicker, animated: true, completion: nil)
            }
        }
        //从手机相册中选择上传图片
        let okAction:UIAlertAction = UIAlertAction(title: "相册", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = weakSelf
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                weakSelf!.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        let cancelAction:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
        }
        alert.addAction(takingPicAction)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
    }
    
    //上传图片接口
    fileprivate func uploadPortrait(portraitData:Data){
        //        let parameter:NSMutableDictionary = [
        //            "typeFile":"0",
        //            "work":MyConfig.shared().projectNameBase,
        //            "transaction":"1",
        //            "thumbnail":"0",
        //            "org":currentUser.orgId
        //        ]
        //        let imageData:Data = UIImageJPEGRepresentation(portrait, 0.9)! as Data
        //        dataController.uploadHeadPhoto(imgDataArray:  [imageData], parameter: parameter) { (isSucceed, info) in
        //            if isSucceed{
        self.uploadHeadUrl(portrait: UIImage.init(data: portraitData)!)
        //
        //            }
        //        }
    }
    //上传头像url
    fileprivate func uploadHeadUrl(portrait:UIImage){
        //        let parameter:NSMutableDictionary = [
        //            "headUrl":dataController.model.data.count > 0 ? dataController.model.data[0].accessPath : ""
        //        ]
        //        dataController.uploadHeadUrl(parameter: parameter) { (isSucceed, info) in
        //            if isSucceed {
        self.photoButton.setImage(portrait, for: .normal)
        //            }else {
        //
        //            }
        //        }
        
    }
}
extension CamaryViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //调用系统相册及拍照功能实现方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage:UIImage = info[.originalImage] as! UIImage
        let imageData:Data  = chosenImage.imageWithImageSimple(newSize:CGSize(width: 358, height: 441), maxLength: 50 * 1024)
        //调用接口
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            self.photoButton.setImage(UIImage.init(data: imageData)!, for: .normal)
            if weakSelf!.checkPixColor(){
                if weakSelf!.getPixColor(){
                    weakSelf!.uploadPortrait(portraitData: imageData)
                }
            }
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
                if a != 255 || r < 200 || g < 200 || b < 200 ||
                    ((r - b) > 10 || (b - r) > 10) ||
                    ((r - g) > 10 || (g - r) > 10) ||
                    ((g - b) > 10 || (b - g) > 10) {
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
extension CamaryViewController{
    
}
