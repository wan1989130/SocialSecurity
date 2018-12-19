//
//  ZcznCollectionViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ZcznCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    func update(model:ZcznModel){
        nameLabel.text = model.text
        iconImageView.image = UIImage(named: "default_head_photo")
    }
    func updateType(model:ZcznModel){
        nameLabel.text = model.text
        iconImageView.image = UIImage(named: "default_head_photo")
    }


}
