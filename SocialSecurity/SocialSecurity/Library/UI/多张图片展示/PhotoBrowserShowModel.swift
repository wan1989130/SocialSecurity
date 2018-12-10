//
//  PhotoBrowserShowModel.swift
//  MiddleSchool2_student
//
//  Created by LiGongbo on 2017/6/19.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit
import ObjectMapper
import Photos
enum PhotoType {
    case url
    case image
}
class PhotoBrowserShowModel: BaseModel {
    var image:UIImage?
    var imageUrl:String = ""
    var thumbnailUrl:String = ""
    var photoType:PhotoType = .url
    var imageName = ""
    var orginFileName = ""
    var orginFileType = ""
    var orginImageThumPath = ""
    var orginFilePath = ""
    var asset:PHAsset?
    
    override init(){
        super.init()
    }
    
   
   
    
    init(imageUrl:String ,thumbnailUrl:String?) {
        super.init()
        self.photoType = .url
        self.imageUrl = imageUrl
        
        if thumbnailUrl == nil{
            self.thumbnailUrl = self.imageUrl
            return
        }
        
        let tempThumbanailUrl = URL(string: thumbnailUrl!)
        if tempThumbanailUrl == nil {
            self.thumbnailUrl = self.imageUrl
        }
        else{
            self.thumbnailUrl = thumbnailUrl!
        }
    }
    
    init(imageUrl:String ,thumbnailUrl:String? ,imageName:String) {
        super.init()
        self.photoType = .url
        self.imageUrl = imageUrl
        
        if thumbnailUrl == nil{
            self.thumbnailUrl = self.imageUrl
            return
        }
        
        let tempThumbanailUrl = URL(string: thumbnailUrl!)
        if tempThumbanailUrl == nil {
            self.thumbnailUrl = self.imageUrl
        }
        else{
            self.thumbnailUrl = thumbnailUrl!
        }
        
        
        
        self.imageName = imageName
    }
    
    init(image:UIImage){
        super.init()
        self.photoType = .image
        self.image = image
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        photoType = .url
        imageUrl <-  map["fileAdr"]
        thumbnailUrl <- map["thumPath"]
        
        imageUrl = FileAccessHost + imageUrl
        thumbnailUrl = FileAccessHost + thumbnailUrl
        
        orginFileName <- map["fileName"]
        orginFileType <- map["fileType"]
        orginImageThumPath <- map["imageThumPath"]
        orginFilePath <- map["filePath"]

    }
    
    func copy() -> PhotoBrowserShowModel {
        let photoBrowser:PhotoBrowserShowModel = PhotoBrowserShowModel()
        photoBrowser.image = self.image
        photoBrowser.imageUrl = self.imageUrl
        photoBrowser.thumbnailUrl = self.thumbnailUrl
        photoBrowser.photoType = self.photoType
        
        photoBrowser.orginFileName = self.orginFileName
        photoBrowser.orginFileType = self.orginFileType
        photoBrowser.orginImageThumPath = self.orginImageThumPath
        photoBrowser.orginFilePath = self.orginFilePath
        return photoBrowser
    }
}
