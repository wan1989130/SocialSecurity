////
////  PhotoShowViewController.swift
////  SocialSecurity
////
////  Created by 王岩 on 2019/1/14.
////  Copyright © 2019年 王岩. All rights reserved.
////
//
//import UIKit
//import SKPhotoBrowser
//class PhotoShowViewController: BaseViewController {
//
//    var photos:Array<SKPhoto> = [SKPhoto]()
//    @IBOutlet var tableView: UITableView!
//    var model:ZcznModel!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initData()
//        initUI()
//    }
//
//
//
//}
//extension PhotoShowViewController{
//    fileprivate func initUI(){
//        self.view.backgroundColor = viewBgColor
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.register("PhotoShowTableViewCell")
//        tableView.register("PhotoShowTitleTableViewCell")
//        
//        
//    }
//    fileprivate func initData(){
////        dataController = PhotoShowViewDataController(delegate: self)
////        if senderParam != nil && senderParam is Int{
////            dataController.initData(type: senderParam as! Int)
////        }
//        if senderParam != nil{
//            model = senderParam as! ZcznModel
//            for index in 0..<model.imageArray.count {
//                
//                var photo:SKPhoto!
//                photo = SKPhoto.photoWithImage(UIImage.init(named: model.imageArray[index])!)
//                
//                photo.shouldCachePhotoURLImage = true
//                photos.append(photo)
//            }
//        }
//    }
//}
//extension PhotoShowViewController:UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1 + model.imageArray.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0{
//            let cell = PhotoShowTitleTableViewCell.loadCell(tableView)
//            cell.titleName.text = model.title
//            return cell
//        }else{
//            let cell = PhotoShowTableViewCell.loadCell(tableView)
//            cell.showImageView.image = UIImage.init(named: model.imageArray[indexPath.row - 1])
//            return cell
//        }
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       
//        
//        let browser = SKPhotoBrowser(photos: photos)
//        browser.initializePageIndex(indexPath.row - 1)
//        browser.delegate = self as SKPhotoBrowserDelegate
//        SKPhotoBrowserOptions.actionButtonTitles = ["保存"]
//        SKPhotoBrowserOptions.displayBackAndForwardButton = false
//        BaseViewController.getCurrentVC().present(browser, animated: true, completion: {})
//    }
//}
//extension PhotoShowViewController:SKPhotoBrowserDelegate{
//  
//    
//}
