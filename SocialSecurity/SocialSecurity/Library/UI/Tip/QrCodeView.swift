//
//  QrCodeView.swift
//  Logistics
//
//  Created by 王岩 on 2018/6/7.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
typealias QrCodeCancelBlock = () -> Void
class QrCodeView: UIView {

    
    @IBAction func click(_ sender: Any) {
        if block != nil{
            block()
        }
        
    }
    
    @IBOutlet weak var qrButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var block:QrCodeCancelBlock!
    override func awakeFromNib() {
        super.awakeFromNib()
        qrButton.isUserInteractionEnabled = true
        
        let longpressGesutre = UILongPressGestureRecognizer(target: self, action: #selector(handleLongpressGesture(sender:)))
        //长按时间为1秒
        longpressGesutre.minimumPressDuration = 1
        //允许15秒运动
        longpressGesutre.allowableMovement = 15
        //所需触摸1次
        longpressGesutre.numberOfTouchesRequired = 1
        
        qrButton.addGestureRecognizer(longpressGesutre)
        
    }
    

    //长按手势
    @objc func handleLongpressGesture(sender : UILongPressGestureRecognizer){
        if sender.state == .began{
             UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, #selector(self.didFinishSaving(image:error:contextInfo:)), nil)
        }
        
     
    }
    @objc func didFinishSaving(image:UIImage,error:Error,contextInfo:AnyObject){
        LHAlertView.showTipAlertWithTitle("保存二维码成功")
        print("22")
    }
    
    
}
