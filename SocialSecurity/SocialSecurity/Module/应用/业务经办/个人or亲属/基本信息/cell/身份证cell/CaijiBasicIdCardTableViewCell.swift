//
//  CaijiBasicIdCardTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
enum IdCardType {
    case zheng
    case fan
}
protocol CaijiBasicIdCardPhotoClickProtoco:class {
    func idCardClick(_ type:IdCardType)
}

class CaijiBasicIdCardTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var idCardView: UIView!
    @IBOutlet weak var idCardViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var fanButton: UIButton!
    @IBOutlet weak var zhengButton: UIButton!
    weak var pro:CaijiBasicIdCardPhotoClickProtoco!
    @IBAction func fanButtonClick(_ sender: Any) {
        pro.idCardClick(.fan)
    }
    @IBAction func zhengButtonClick(_ sender: Any) {
        pro.idCardClick(.zheng)
    }
 
//    private lazy var myLayer:CAShapeLayer = {
//        
//        let path = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: ScreenWidth - 32, height: 44), byRoundingCorners: [.topRight , .topLeft] , cornerRadii: CGSize(width: 5, height: 0));
//        let layer = CAShapeLayer.init();
//        layer.path = path.cgPath;
//        layer.lineWidth = 1;
//        layer.lineCap = CAShapeLayerLineCap.square;
//        layer.strokeColor = UIColor.black.withAlphaComponent(0.2).cgColor;
//        //  注意直接填充layer的颜色，不需要设置控件view的backgroundColor
//        layer.fillColor = UIColor.clear.cgColor;
//        return layer;
//        
//        }()
 
    override func awakeFromNib() {
        super.awakeFromNib()
       
        zhengButton.backgroundColor = UIColor(hexString: "005191")
        
        zhengButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) //文字大小
        zhengButton.set(image: UIImage(named: "ic_camera"), title: "拍摄", titlePosition: .bottom, additionalSpacing: 3, state: .normal)
        fanButton.backgroundColor = UIColor(hexString: "005191")
        
        fanButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) //文字大小
        fanButton.set(image: UIImage(named: "ic_camera"), title: "拍摄", titlePosition: .bottom, additionalSpacing: 3, state: .normal)
        
        
//        basicBgView.layer.borderWidth = 1
//        basicBgView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
//        basicBgView.corner(byRoundingCorners: [.topLeft,.topRight], radii: 5,size: CGRect(x: 0, y: 0, width: ScreenWidth - 32, height: 44))
        
    }
    
    


    func update(flag:Bool,isWrite:Bool){
       
        if !flag{
            topConstraint.constant = 0
            idCardView.removeAllSubviews()
            idCardViewHeightConstraint.constant = 0
        }else{
            fanButton.isEnabled = isWrite
            zhengButton.isEnabled = isWrite
        }
        
        
    }
    class func loadCell(_ tableView:UITableView)-> CaijiBasicIdCardTableViewCell{
        let cellId:String = "CaijiBasicIdCardTableViewCellId"
        var cell:CaijiBasicIdCardTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CaijiBasicIdCardTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CaijiBasicIdCardTableViewCell.self)){
            cell = CaijiBasicIdCardTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
