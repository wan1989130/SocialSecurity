//
//  PhotoCollectionViewCell.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/13.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
typealias PhotoSelectOrCancelBlock = (_ isSelect:Bool) -> Void
typealias PhotoAgainBlock = () -> Void
class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBAction func againButtonClick(_ sender: Any) {
        againBlock?()
    }
    @IBOutlet weak var againButton: UIButton!
    
    
    @IBAction func chooseClick(_ sender: Any) {
        let button = sender as! UIButton
        if button.tag == 0{
            button.tag = 1
            button.setBackgroundImage(UIImage(named: "choose_true"), for: .normal)
            block?(true)
        }else if button.tag == 1{
            button.tag = 0
            button.setBackgroundImage(UIImage(named: "choose_false"), for: .normal)
            block?(false)
        }
    }
    var againBlock:PhotoAgainBlock?
    var block:PhotoSelectOrCancelBlock?
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    var model:SendPhotoStatusModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(model:SendPhotoStatusModel,block:@escaping PhotoSelectOrCancelBlock,againBlock:@escaping PhotoAgainBlock){
        self.againBlock = againBlock
        self.block = block
        self.model = model
        successLabel.isHidden = false
        photoImageView.image = model.imageSendGoods
        if model.isSelect{
            chooseButton.setBackgroundImage(UIImage(named: "choose_true"), for: .normal)
        }else{
            chooseButton.setBackgroundImage(UIImage(named: "choose_false"), for: .normal)
        }
        if model.isSuccess{
            againButton.isHidden = true
            successLabel.text = "上传成功"
        }else{
            againButton.isHidden = false
            successLabel.text = "上传失败"
        }
    }

}
