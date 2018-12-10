//
//  ConfirmLoginSelectStrOrSchoolTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ConfirmLoginSelectStrOrSchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var selectImgBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateParent(model:BindAccountStudentModel){
        contentLabel.text = model.name + "(" + model.gradeClassName + ")"
        if model.isSelected == "0"{
            selectImgBtn.setBackgroundImage(UIImage.init(named: "main_MutiCheck_Off"), for: .normal)
        }else if model.isSelected == "1"{
              selectImgBtn.setBackgroundImage(UIImage.init(named: "main_MutiCheck_On"), for: .normal)
        }
       
    }
    func updateTeacher(model:SchoolModel){
        contentLabel.text = model.schoolName
        if model.isSelected == "0"{
            selectImgBtn.setBackgroundImage(UIImage.init(named: "main_MutiCheck_Off"), for: .normal)
        }else if model.isSelected == "1"{
            selectImgBtn.setBackgroundImage(UIImage.init(named: "main_MutiCheck_On"), for: .normal)
        }

        
        
    }
    class func loadCell(_ tableView:UITableView)-> ConfirmLoginSelectStrOrSchoolTableViewCell{
        let cellId:String = "ConfirmLoginSelectStrOrSchoolTableViewCellId"
        var cell:ConfirmLoginSelectStrOrSchoolTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ConfirmLoginSelectStrOrSchoolTableViewCell
        
        if (cell == nil || !cell!.isKind(of: ConfirmLoginSelectStrOrSchoolTableViewCell.self)){
            cell = ConfirmLoginSelectStrOrSchoolTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }

    
}
