//
//  PhotoTableViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/12.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
@objc protocol SendGoodsPhotoDelegate {
    
    
    func sendPersonPhotoClick(isSelect:Bool)//ture选择图片 false放大
    func sendPersonPhotoDeleteClick()
    func sendGoodsClick()
    func sendPersonPhotoClickAgain()
}

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    
    @IBAction func againButtonClick(_ sender: Any) {
        delegate?.sendPersonPhotoClickAgain()
    }
    @IBOutlet weak var againButton: UIButton!
    
    @IBOutlet weak var image1Button: UIButton!
    @IBOutlet weak var image2Button: UIButton!
    @IBOutlet weak var image3Button: UIButton!
    @IBOutlet weak var image4Button: UIButton!
    
    @IBOutlet weak var takeLabel: UILabel!
    @IBOutlet weak var sendLabel: UILabel!
    
    @IBOutlet weak var sendPersonSuccessLabel: UILabel!
    @IBAction func sendGoodsClick(_ sender: Any) {
        delegate?.sendGoodsClick()
    }
    var model:DeliverGoodsSaveModel!
    func update(model:DeliverGoodsSaveModel){
        self.model = model
        if model.sendCardFullface == "" && model.imageSendPersonPhoto == nil{
            deleteBtn.isHidden = true
            sendPersonSuccessLabel.isHidden = true
        }else{
            deleteBtn.isHidden = false
            sendPersonSuccessLabel.isHidden = false
        }
        
        
        var imageUrl = ""
        if model.sendCardFullface.hasPrefix("/"){
            imageUrl = ( model.sendCardFullface as NSString).replacingCharacters(in: NSMakeRange(0, 1), with: "")
        }else{
            imageUrl = model.sendCardFullface
        }
        if model.imageSendPersonPhoto != nil {
                    sendPersonPhotoButton.setBackgroundImage(model.imageSendPersonPhoto, for: .normal)
        }else{
                    sendPersonPhotoButton.sd_setBackgroundImage(with: URL.init(string: HostAddress + imageUrl), for: .normal, placeholderImage: nil, options: [], completed: nil)
        }

        
        image1Button.setBackgroundImage(UIImage(), for: .normal)
        image2Button.setBackgroundImage(UIImage(), for: .normal)
        image3Button.setBackgroundImage(UIImage(), for: .normal)
        image4Button.setBackgroundImage(UIImage(), for: .normal)
        if model.sendPhotoStatusModel.count > 0{
            var index = 0
            for i in 0..<model.sendPhotoStatusModel.count{
                
                if model.sendPhotoStatusModel[i].isSuccess{
                    if index == 0{
                        image1Button.setBackgroundImage(model.sendPhotoStatusModel[i].imageSendGoods, for: .normal)
                    }else if index == 1{
                        image2Button.setBackgroundImage(model.sendPhotoStatusModel[i].imageSendGoods, for: .normal)
                    }else if index == 2{
                        image3Button.setBackgroundImage(model.sendPhotoStatusModel[i].imageSendGoods, for: .normal)
                    }else if index == 3{
                        image4Button.setBackgroundImage(model.sendPhotoStatusModel[i].imageSendGoods, for: .normal)
                    }
                    index = index + 1
                }
                
                
                
            }
            takeLabel.isHidden = true
            sendLabel.isHidden = true
            
        }else{
            takeLabel.isHidden = false
            sendLabel.isHidden = false
        }
    }
    
    @IBOutlet weak var sendPersonPhotoButton: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBAction func deleteBtnClick(_ sender: UIButton) {
        sender.isHidden = true
        againButton.isHidden = true
        oneLabel.isHidden = false
        twoLabel.isHidden = false
        sendPersonSuccessLabel.isHidden = true
        sendPersonPhotoButton.setBackgroundImage(UIImage(), for: .normal)
       delegate?.sendPersonPhotoDeleteClick()
    }
    
    
    var delegate:SendGoodsPhotoDelegate?
    @IBAction func sendPersonPhotoClick(_ sender: Any) {
      
        delegate?.sendPersonPhotoClick(isSelect: deleteBtn.isHidden)
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> PhotoTableViewCell{
        let cellId:String = "PhotoTableViewCellId"
        var cell:PhotoTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? PhotoTableViewCell
        
        if (cell == nil || !cell!.isKind(of: PhotoTableViewCell.self)){
            cell = PhotoTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
