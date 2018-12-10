//
//  SendGoodsPhotoViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/13.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import SKPhotoBrowser
class SendGoodsPhotoViewController: BaseViewController {

    
    var deleteIndex = 0
    var photos:Array<SKPhoto> = [SKPhoto]()
    @IBAction func takePhotoClick(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker:UIImagePickerController = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var dataController:SendGoodsPhotoDataController!
    var saveModel:DeliverGoodsSaveModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "货物图像采集"
        initData()
        initUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissBlock?("")
    }

}
extension SendGoodsPhotoViewController{
    func initData(){
        dataController = SendGoodsPhotoDataController(delegate:self)
        if senderParam != nil{
            saveModel = senderParam as? DeliverGoodsSaveModel
        }
    }
    func initUI(){
        initCollectionView()
        loadRightBarButtonItem()

    }
    func initCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(ScreenWidth-14)/2,height:(ScreenWidth-14)/2)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 1
        //        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        //        layout.scrollDirection = .horizontal
        //注册一个cell 
        collectionView.register(UINib.init(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
    }
    /**
     * 加载导航栏右侧按钮
     */
    fileprivate func loadRightBarButtonItem(){
        let button =   UIButton(type: .system)
        button.frame = CGRect(x:0, y:0, width:10, height:30)
        deleteIndex = 0
        for item in saveModel.sendPhotoStatusModel{
            if item.isSelect{
                deleteIndex = deleteIndex + 1
            }
        }
        if deleteIndex == 0{
            button.setTitle("删除", for: .normal)
        }else{
            button.setTitle("删除(" + String(deleteIndex) + ")", for: .normal)
        }
        
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
       
        if deleteIndex > 0{
            var i = 0
            for item in saveModel.sendPhotoStatusModel {
                if item.isSelect {
                    saveModel.sendPhotoStatusModel.remove(at: i)
                    deleteIndex = deleteIndex - 1
                    break
                }
                i += 1
            }
        }
        collectionView.reloadData()
        loadRightBarButtonItem()
        
    }
}
extension SendGoodsPhotoViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    //每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saveModel.sendPhotoStatusModel.count
        
    }
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //        return 2
        return 1
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.update(model: self.saveModel.sendPhotoStatusModel[indexPath.row], block: { (isSelect) in
            if isSelect{
                self.deleteIndex = self.deleteIndex + 1
            }else{
                self.deleteIndex = self.deleteIndex - 1
            }
            self.saveModel.sendPhotoStatusModel[indexPath.row].isSelect = isSelect
            self.loadRightBarButtonItem()
        }) {
            //重新上传
            self.uploadPortrait(portrait: self.saveModel.sendPhotoStatusModel[indexPath.row].imageSendGoods, tempIndex: indexPath.row)
        }
        
    
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var photo:SKPhoto!
        photo = SKPhoto.photoWithImage(saveModel.sendPhotoStatusModel[indexPath.row].imageSendGoods)
        photos.removeAll()
        photos.append(photo)
        let browser = SKPhotoBrowser(photos: photos)
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayBackAndForwardButton = false
        BaseViewController.getCurrentVC().present(browser, animated: true, completion: {})
    }

}
extension SendGoodsPhotoViewController{
    
    //上传图片接口
    fileprivate func uploadPortrait(portrait:UIImage,tempIndex:Int?){
        
        let parameter:NSMutableDictionary = [
            "typeFile":"0",
            "loginName":MyConfig.shared().loginName
        ]
        let imageData:Data = portrait.jpegData(compressionQuality: 1) ?? Data()
        dataController.uploadPhoto(imgDataArray:  [imageData], parameter: parameter) { (isSucceed, info) in
            
            let model = SendPhotoStatusModel()
            model.imageSendGoods = portrait
            if isSucceed{
                model.urlSendGoods = self.dataController.uploadPhotoModel.data
                model.isSuccess = true
            }else{
                model.isSuccess = false
            }
            if tempIndex != nil{
                self.saveModel.sendPhotoStatusModel[tempIndex!].isSuccess = isSucceed
                if isSucceed{
                    self.saveModel.sendPhotoStatusModel[tempIndex!].urlSendGoods = self.dataController.uploadPhotoModel.data
                }
               
            }else{
                self.saveModel.sendPhotoStatusModel.append(model)
            }
            
            self.collectionView.reloadData()
        }
    }
}
extension SendGoodsPhotoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //调用系统相册及拍照功能实现方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage:UIImage = info[.originalImage] as! UIImage
        //TODO WY
        picker.dismiss(animated: true) {
            self.uploadPortrait(portrait: chosenImage, tempIndex: nil)
        }
    }
    
}
