//
//  UIImageView+LH.swift
//  MiddleSchool2_student
//
//  Created by 李琪 on 2017/6/16.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(url:String, placeholderName:String){
        let image:UIImage = UIImage(named: placeholderName) == nil ? UIImage.createImageWithColor(UIColor.clear) : UIImage(named: placeholderName)!
        setImage(url: url, placeholder: image)
    }
    
    func setImage(url:String, placeholder:UIImage){
        let imageUrl = URL(string: url)
        if imageUrl == nil{
            self.image = placeholder
        }
        else{
            setImageURL(url: imageUrl, placeholder: placeholder)
        }
    }
    
    func setImageURL(url:URL?, placeholderName:String){
        let image:UIImage = UIImage(named: placeholderName) == nil ? UIImage.createImageWithColor(UIColor.clear) : UIImage(named: placeholderName)!
        setImageURL(url: url, placeholder: image)
    }
    
    func setImageURL(url:URL?, placeholder:UIImage){
        if url == nil{
            self.image = placeholder
        }
        else{
            self.sd_setImage(with: url!, placeholderImage: placeholder, options: [.retryFailed,.refreshCached])
        }
    }

    

}
