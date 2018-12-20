//
//  SelectTableViewCell.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/20.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
//protocol SelectDictionaryProtoco: class {
//    func selectIndex(_ index:Int)
//}
class SelectTableViewCell: UITableViewCell {

//    @IBAction func selectButtonClick(_ sender: Any) {
//        pro.selectIndex(index)
//    }
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    var index = 0
//    weak var pro:SelectDictionaryProtoco!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(model:DictionaryModel,index:Int){
        self.index = index
        if model.isSelect{
            selectButton.backgroundColor = UIColor(hexString: "005191")
        }else{
            selectButton.backgroundColor = UIColor.white
        }
        contentLabel.text = model.name
    }
    class func loadCell(_ tableView:UITableView)-> SelectTableViewCell{
        let cellId:String = "SelectTableViewCellId"
        var cell:SelectTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SelectTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SelectTableViewCell.self)){
            cell = SelectTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
