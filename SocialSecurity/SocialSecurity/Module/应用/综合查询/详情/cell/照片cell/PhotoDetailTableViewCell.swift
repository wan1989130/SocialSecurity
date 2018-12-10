//
//  PhotoDetailTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class PhotoDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var image1Button: UIButton!
    @IBOutlet weak var image2Button: UIButton!
    @IBOutlet weak var image3Button: UIButton!
    @IBOutlet weak var image4Button: UIButton!
    var photos:Array<SKPhoto> = [SKPhoto]()
    var goodsPhotos:Array<SKPhoto> = [SKPhoto]()
    @IBOutlet weak var takeLabel: UILabel!
    @IBOutlet weak var sendLabel: UILabel!
    var model:DeliverGoodsSaveModel!
    @IBOutlet weak var sendPersonSuccessLabel: UILabel!
    var sendPhotoArr = [String]()
    @IBAction func sendGoodsClick(_ sender: Any) {
       
        var photo:SKPhoto!
        photos.removeAll()
        for item in sendPhotoArr{
            var imageUrl = ""
            if item.hasPrefix("/"){
                imageUrl = ( item as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
            }
            photo = SKPhoto.photoWithImageURL(HostAddress + imageUrl)
            
            photos.append(photo)
        }
        
        
        let browser = SKPhotoBrowser(photos: photos)
        browser.initializePageIndex((sender as! UIButton).tag)
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayBackAndForwardButton = false
        BaseViewController.getCurrentVC().present(browser, animated: true, completion: {})
    }
    
    
    @IBOutlet weak var sendPersonPhotoButton: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
   
    
    
    
    @IBAction func sendPersonPhotoClick(_ sender: Any) {
        var photo:SKPhoto!
        photos.removeAll()
        var imageUrl = ""
        if model.sendCardFullface.hasPrefix("/"){
            imageUrl = ( model.sendCardFullface as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
        }
        photo = SKPhoto.photoWithImageURL(HostAddress + imageUrl)
        
        photos.append(photo)
        let browser = SKPhotoBrowser(photos: photos)
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayBackAndForwardButton = false
        BaseViewController.getCurrentVC().present(browser, animated: true, completion: {})
    }
    
    func updateDetail(model:DeliverGoodsSaveModel){
        var imageUrl = ""
        self.model = model
        if model.sendCardFullface.hasPrefix("/"){
            imageUrl = ( model.sendCardFullface as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
        }
        sendPersonPhotoButton.sd_setBackgroundImage(with: URL.init(string: HostAddress + imageUrl), for: .normal, placeholderImage: nil, options: [], completed: nil)
        sendPhotoArr = model.photo.components(separatedBy: "|")
        if model.photo.hasPrefix("|"){
            sendPhotoArr.remove(at: 0)
        }
        for i in 0..<sendPhotoArr.count{
            if i == 0{
                var imageUrl = ""
                if sendPhotoArr[i].hasPrefix("/"){
                    imageUrl = ( sendPhotoArr[i] as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
                    image1Button.sd_setBackgroundImage(with: URL.init(string: HostAddress + imageUrl), for: .normal, placeholderImage:nil, options: [], completed: nil)
                }
            }else if i == 1{
                var imageUrl = ""
                if sendPhotoArr[i].hasPrefix("/"){
                    imageUrl = ( sendPhotoArr[i] as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
                    image2Button.sd_setBackgroundImage(with: URL.init(string: HostAddress + imageUrl), for: .normal, placeholderImage:nil, options: [], completed: nil)
                }
            }else if i == 2{
                var imageUrl = ""
                if sendPhotoArr[i].hasPrefix("/"){
                    imageUrl = ( sendPhotoArr[i] as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
                    image3Button.sd_setBackgroundImage(with: URL.init(string: HostAddress + imageUrl), for: .normal, placeholderImage:nil, options: [], completed: nil)
                }
            }else if i == 3{
                var imageUrl = ""
                if sendPhotoArr[i].hasPrefix("/"){
                    imageUrl = ( sendPhotoArr[i] as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
                    
                }else{
                    imageUrl = sendPhotoArr[i]
                }
                image4Button.sd_setBackgroundImage(with: URL.init(string: HostAddress + imageUrl), for: .normal, placeholderImage:nil, options: [], completed: nil)
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> PhotoDetailTableViewCell{
        let cellId:String = "PhotoDetailTableViewCellId"
        var cell:PhotoDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? PhotoDetailTableViewCell
        
        if (cell == nil || !cell!.isKind(of: PhotoDetailTableViewCell.self)){
            cell = PhotoDetailTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
