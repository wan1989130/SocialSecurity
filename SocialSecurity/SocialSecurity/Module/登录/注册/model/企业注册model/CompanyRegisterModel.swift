//
//  CompanyRegisterModel.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
enum SelectPhoto:String {
    case shop = "shop"
    case businessLicence = "businessLicence"
    case logo = "logo"
    case cachet = "cachet"
    case tax = "tax"
    case organization = "organization"
}
class CompanyRegisterModel: BaseModel {
    var companyName = ""
    var registerAddress = ""
    var responsiblePersonName = ""//负责人
    var responsiblePersonPhone = ""
    var payNumber = ""//纳税号
    var companyPhone = ""
    var shopUrl = ""
    var assetShop:PHAsset?
    var imageShop:UIImage?
    
    //营业执照
    var businessLicence = ""
    var assetBusinessLicence:PHAsset?
    var imageBusinessLicence:UIImage?
    
    var logoUrl = ""
    var assetLogo:PHAsset?
    var imageLogo:UIImage?
    var cachetUrl = ""//公章
    var assetCachet:PHAsset?
    var imageCachet:UIImage?
    var taxUrl = ""//税务登记证
    var assetTax:PHAsset?
    var imageTax:UIImage?
    var organizationUrl = ""//组织机构
    var assetOrganization:PHAsset?
    var imageOrganization:UIImage?
    var photoKey:Array<SelectPhoto> = [SelectPhoto]()//上传了哪个照片就添加到这个数组里

}
