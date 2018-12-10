//
//  LRSwitchStudentView.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/18.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

protocol LRSwitchStudentViewDelegate {
    func LRSwitchStudentViewDidSwitch(student:BaseStudentInfoModel, index:Int)
}

typealias LRSwitchStudentViewDidSwitchBlock = (_ student:BaseStudentInfoModel, _ index:Int) -> Void

class LRSwitchStudentView: UIView {
    let defaultNameLabelCenterConstant:CGFloat = -10

    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var studentNoLabel: UILabel!
    
    @IBOutlet var nameLabelCenterConstraint: NSLayoutConstraint!
    var canKao = ""//参考
    var delegate:LRSwitchStudentViewDelegate?
    var completionBlock:LRSwitchStudentViewDidSwitchBlock?
    var students:Array<BaseStudentInfoModel> = [BaseStudentInfoModel](){
        didSet{
            reloadViewInfo()
        }
    }
    var currentIndex:Int = -1
    
    @IBAction func leftButtonClicked(_ sender: UIButton) {
        currentIndex = currentIndex - 1 < 0 ? 0 : currentIndex - 1
        reloadViewInfo()
        delegate?.LRSwitchStudentViewDidSwitch(student: students[currentIndex], index: currentIndex)
        completionBlock?(students[currentIndex], currentIndex)
    }
    
    @IBAction func rightButtonClicked(_ sender: UIButton) {
        currentIndex = currentIndex + 1 > students.count - 1 ? students.count - 1 : currentIndex + 1
        reloadViewInfo()
        delegate?.LRSwitchStudentViewDidSwitch(student: students[currentIndex], index: currentIndex)
        completionBlock?(students[currentIndex], currentIndex)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reloadViewInfo()
    }
    
    func reloadViewInfo(){
        layoutIfNeeded()
        if students.count <= 0 || currentIndex < 0 || currentIndex >= students.count{
            leftButton.isEnabled = false
            rightButton.isEnabled = false
            nameLabel.text = ""
            studentNoLabel.text = ""
        }
        else{
            let student = students[currentIndex]
            if String.isNilOrEmpty(student.studentNo){
                nameLabelCenterConstraint.constant = 0
                studentNoLabel.text = ""
            }
            else{
                nameLabelCenterConstraint.constant = defaultNameLabelCenterConstant
                studentNoLabel.text = student.studentNo
            }
            if canKao != ""{
                studentNoLabel.text = canKao
            }
            nameLabel.text = student.name + "(\(currentIndex + 1)/\(students.count))"
            
            leftButton.isEnabled = currentIndex > 0
            rightButton.isEnabled = currentIndex < students.count - 1
        
        }
    }
}
