//
//  PhotoBrowserView.swift
//  MiddleSchool2_student
//
//  Created by LiGongbo on 2017/6/16.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit
import SKPhotoBrowser
class PhotoBrowserView: UIView ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SKPhotoBrowserDelegate {
    var rowCount = 4
    var hasAddImageView = false
    
    var srcImageViews:Array<UIImageView> = [UIImageView]()
    var photos:Array<SKPhoto> = [SKPhoto]()
    
    var addImageViewClickedBlock:((_ images:Array<PhotoBrowserShowModel>) -> Void)?
    var deleteImageViewClickedBlock:((_ images:Array<PhotoBrowserShowModel>) -> Void)?
    
    var showImages:Array<PhotoBrowserShowModel>! = [PhotoBrowserShowModel]()
    
    var width:CGFloat = 0
    var height:CGFloat = 0
    var margin:CGFloat = 8
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(imageArr:Array<PhotoBrowserShowModel> ,hasAddImageView:Bool) {
        showImages.removeAll()
        showImages = imageArr
        self.hasAddImageView = hasAddImageView
        updateImageView()
    }
    
    func updateAddImage(addImageViewClickedBlock:((_ images:Array<PhotoBrowserShowModel>) -> Void)?){
        self.addImageViewClickedBlock = addImageViewClickedBlock
    }
    func updateDeleteImage(deleteImageViewClickedBlock:((_ images:Array<PhotoBrowserShowModel>) -> Void)?) {
        self.deleteImageViewClickedBlock = deleteImageViewClickedBlock
    }
    
    func updateImageView(){
        self.removeAllSubviews2()
        
        var originX:CGFloat = 0
        var originY:CGFloat = 0
        width = (ScreenWidth - CGFloat(rowCount * 2) * margin - 10) / CGFloat(rowCount)
        height = width
        
        if showImages.count == 0 &&  hasAddImageView{
            let imageView = UIImageView.init(frame: CGRect(x: margin, y: margin, width: width, height: height))
            imageView.isUserInteractionEnabled = true
            imageView.image = UIImage(named: "AlbumAddBtn")
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addImageViewClicked(tap:))))
            self.addSubview(imageView)
        }
        
        if showImages.count > 0 {
            srcImageViews.removeAll()
            for index in 0..<showImages.count {
                let photoBrowserModel = showImages[index]
                
                let row:CGFloat = CGFloat(index / rowCount)
                let column:CGFloat = CGFloat(index % rowCount)
                
                if column == 0 {
                    originX = margin
                }
                else{
                    originX = column * width + margin * (column + 1)
                }
                
                originY = row * height + margin * (row + 1)
                let view = UIView.init(frame: CGRect(x: originX, y: originY, width: width, height: height))
                let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
                let imageUrl = URL(string: showImages[index].imageUrl)
                if  photoBrowserModel.photoType == .url{
                    imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage.init(named: "app_teacher_evaluation"), options: [.retryFailed,.refreshCached])
                }
                else{
                    imageView.image = showImages[index].image
                }
                imageView.tag = index
                imageView.setCornerWithRadius(12)
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewClicked(tap:))))
                self.addSubview(view)
                view.addSubview(imageView)
                
                if hasAddImageView {
                    let deleteButton = UIButton()
                    deleteButton.frame = CGRect(x: width - 12, y: -4, width: 16, height: 16)
                    deleteButton.setBackgroundImage(UIImage.loadImage("main_MyApps_Delete"), for: .normal)
                    deleteButton.tag = 1000 + index
                    deleteButton.addTarget(self, action: #selector(self.deleteButtonClicked(_:)), for: .touchUpInside)
                    deleteButton.isHidden = false
                    deleteButton.layer.masksToBounds = false
                    view.addSubview(deleteButton)
                }
                srcImageViews.append(imageView)
            }
            
            if hasAddImageView {
                let row:CGFloat = CGFloat(showImages.count / rowCount)
                let column:CGFloat = CGFloat(showImages.count % rowCount)
                
                if column == 0 {
                    originX = margin
                }
                else{
                    originX = column * width + margin * (column + 1)
                }
                
                originY = row * height + margin * (row + 1)
                
                let imageView = UIImageView.init(frame: CGRect(x: originX, y: originY, width: width, height: height))
                imageView.isUserInteractionEnabled = true
                imageView.image = UIImage(named: "AlbumAddBtn")
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addImageViewClicked(tap:))))
                self.addSubview(imageView)
            }
        }
    }
    
    /**
     * 点击需要展示的图片
     */
    @objc func imageViewClicked(tap:UITapGestureRecognizer){
        photos.removeAll()
        for index in 0..<showImages.count {
            let model = showImages[index]
            var photo:SKPhoto!
            if model.photoType == .url {
                photo = SKPhoto.photoWithImageURL(model.imageUrl)
            }
            else{
                photo = SKPhoto.photoWithImage(model.image!)
            }
            photo.shouldCachePhotoURLImage = true
            photos.append(photo)
        }
        
        let browser = SKPhotoBrowser(photos: photos)
        browser.initializePageIndex(tap.view!.tag)
        browser.delegate = self as SKPhotoBrowserDelegate
        SKPhotoBrowserOptions.actionButtonTitles = ["保存"]
        SKPhotoBrowserOptions.displayBackAndForwardButton = false
        BaseViewController.getCurrentVC().present(browser, animated: true, completion: {})
    }
    
    
    //SKPhotoBrowserDelegate
    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
        let photo = photos[photoIndex]
        if buttonIndex == 0 {
            UIImageWriteToSavedPhotosAlbum(photo.underlyingImage, self, #selector(self.savedPhotosAlbum(image:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func savedPhotosAlbum(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil {
            LHAlertView.showTipAlertWithTitle("保存失败")
        }
        else{
            LHAlertView.showTipAlertWithTitle("成功保存到相册")
        }
    }
    
    /**
     * 点击删除图片按钮
     */
    @objc func deleteButtonClicked(_ sender:UIButton){
        let index = sender.tag - 1000
        showImages.remove(at: index)
        deleteImageViewClickedBlock?(showImages)
        updateImageView()
    }
    
    /**
     * 点击添加图片按钮
     */
    @objc func addImageViewClicked(tap:UITapGestureRecognizer) {
        print("hehe")
        let alert:UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.view.tintColor = UIColor.black
        //通过拍照上传图片
        let takingPicAction:UIAlertAction = UIAlertAction(title: "拍照", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                BaseViewController.getCurrentVC().present(imagePicker, animated: true, completion: nil)
            }
        }
        //从手机相册中选择上传图片
        let okAction:UIAlertAction = UIAlertAction(title: "从手机相册选择", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                BaseViewController.getCurrentVC().present(imagePicker, animated: true, completion: nil)
            }
        }
        let cancelAction:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
        }
        alert.addAction(takingPicAction)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        BaseViewController.getCurrentVC().present(alert, animated: true, completion: nil)
        
    }
    
    //调用系统相册及拍照功能实现方法
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage:UIImage = info[.editedImage] as! UIImage
        //当image从相机中获取的时候存入相册中
        if picker.sourceType == UIImagePickerController.SourceType.camera {
            //如果是从相机过来的保存到相册中
            UIImageWriteToSavedPhotosAlbum(chosenImage,nil,nil,nil);
        }
        chosenImage = self.imageWithImageSimple(image: chosenImage, newSize: CGSize(width: width * 2, height: height * 2))
        //调用接口
        showImages.append(PhotoBrowserShowModel(image: chosenImage))
        addImageViewClickedBlock?(showImages)
        //TODO WY
        picker.dismiss(animated: true) {
            
        }
        //        picker.dismiss(animated: true, completion: {(isComplete) in
        //        })
    }
    //TODO
    func removeAllSubviews2(){
        for view in self.subviews{
            view.removeFromSuperview()
        }
    }
    //    override func removeAllSubviews(){
    //        for view in self.subviews{
    //            view.removeFromSuperview()
    //        }
    //    }
    
    //压缩图片
    func imageWithImageSimple(image:UIImage,newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    
}
