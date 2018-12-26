//
//  MineMessageViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/18.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class MineMessageViewController: BaseViewController {

    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet var headPhotoImageView: UIImageView!
    var alert:UIAlertController!
    @IBOutlet weak var nickBgView: UIView!
    @IBOutlet weak var headPhotoBgView: UIView!
    var dataController:MineMessageDataController!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "完善个人信息"
        initData()
        initUI()
    }

    deinit {
        print("bbbbb")
    }
  

}
extension MineMessageViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = UIColor(hexString: "ECF5FE")
        headPhotoBgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(headPhotoClick)))
        nickBgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(nickClick)))
        initAlert()
        
    }
    fileprivate func initData(){
        dataController = MineMessageDataController(delegate: self)
    }
    @objc func headPhotoClick(){
        present(alert, animated: true, completion: nil)
    }
    @objc func nickClick(){
        weak var weakSelf = self
        pushViewController("updateNickNameViewController", sender: nil) { (info) in
            weakSelf?.nickLabel.text = info as! String
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
        let okAction:UIAlertAction = UIAlertAction(title: "相册", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = weakSelf
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                weakSelf?.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        let cancelAction:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
        }
        alert.addAction(takingPicAction)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
    }
    //压缩图片
    fileprivate func imageWithImageSimple(image:UIImage,newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return newImage
    }
    //上传图片接口
    fileprivate func uploadPortrait(portrait:UIImage){
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
                self.uploadHeadUrl(portrait: portrait)
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
                self.headPhotoImageView.image = portrait
//            }else {
//
//            }
//        }
        
    }
    
}
extension MineMessageViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //调用系统相册及拍照功能实现方法
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage:UIImage = info[.originalImage] as! UIImage
        chosenImage = self.imageWithImageSimple(image: chosenImage, newSize: CGSize(width: 400, height: 400))
        //调用接口
        
        picker.dismiss(animated: true) {
            
            self.uploadPortrait(portrait: chosenImage)
        }
    }
    
}
extension MineMessageViewController{}

