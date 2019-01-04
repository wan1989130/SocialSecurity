//
//  SbkProgressTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/19.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
protocol SbkProgressProtocol:class {
    func detailWebviewClick(_ index:Int)
}
class SbkProgressTableViewCell: UITableViewCell {
    var index = -1
    @IBOutlet weak var xmLabel: UILabel!
    
    
    @IBOutlet weak var sfzhLabel: UILabel!
    var pro:SbkProgressProtocol!
    @IBAction func detailWebviewClick(_ sender: Any) {
        pro.detailWebviewClick(index)
    }
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(model:SbkProgressItemModel,index:Int){
        self.index = index
        xmLabel.text = model.name
        sfzhLabel.text = model.zhengjianNum
        var temStr = ""
        if model.status == 0{
            statusLabel.text = model.statusMsg
            temStr = model.statusMsg
        }else{
            statusLabel.text = model.statusMsg + "--" + model.remark
            temStr = model.statusMsg + "--" + model.remark
        }
        if model.status == 0 || model.status == 1{
            statusLabel.textColor = UIColor(hexString: "99cc00")
        }else{
            statusLabel.textColor = UIColor(hexString: "ff4444")
        }
        let statusLabelSize = temStr.getSize(withFont: UIFont.systemFont(ofSize: 14), forWidth: ScreenWidth - 16 - 8 - 60 - 8 - 16 - 8 - 4 - 48)
        viewHeightConstraint.constant = statusLabelSize.height + 60 + 1
    }

    class func loadCell(_ tableView:UITableView)-> SbkProgressTableViewCell{
        let cellId:String = "SbkProgressTableViewCellId"
        var cell:SbkProgressTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SbkProgressTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SbkProgressTableViewCell.self)){
            cell = SbkProgressTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
