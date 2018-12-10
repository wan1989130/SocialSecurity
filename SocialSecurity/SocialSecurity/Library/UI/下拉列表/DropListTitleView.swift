//
//  DropListTitleView.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/16.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class DropListTitleView: UIView {
    var dropListCellType:DroplistCellType = .normal
    var didSelectBlock:DropListViewSelectBlock?
    var list:Array<BaseModel> = [BaseModel]()
    var currentIndex:Int = -1
    var touchBackgroundToDismiss = true
    
    var title:String = ""{
        didSet{
            titleLabel.text = title
            titleLabel.sizeToFit()
        }
    }
    
    var isOpen:Bool = false{
        didSet{
            arrowImageView.isHighlighted = isOpen
        }
    }
    
    func hideArrow(){
        arrowImageView.isHidden = true
    }
    
    var titleLabel:UILabel!
    var arrowImageView:UIImageView!
    var selectButton:UIButton!
    var buttonCanBeClicked = true
    
    let arrowUp = UIImage.loadImage("arrow_dropList_up")
    let arrowDown = UIImage.loadImage("arrow_dropList_down")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init(frame: CGRect, completionBlcok:DropListViewSelectBlock?) {
        super.init(frame: frame)
        didSelectBlock = completionBlcok
        commonInit()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    @objc func buttonClicked(){
        if buttonCanBeClicked{
            isOpen = true
            let listView = DropListView(frame: CGRect.zero)
            listView.list = self.list
            listView.dropListCellType = dropListCellType
            listView.selectedIndex = currentIndex
            listView.touchToHide = touchBackgroundToDismiss
            listView.show(titleView: self) { (titleView, info, index) in
//                self.title = info.name
                self.currentIndex = index
                self.didSelectBlock?(titleView,info,index)
            }
        }
    }
    
    func commonInit(){
        
        initTitleLabel()
        
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: self, attribute: .trailing, multiplier: 1, constant: -18))
       

        
        initArrowImageView()
        self.addConstraint(NSLayoutConstraint(item: arrowImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: arrowImageView, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 4))
        arrowImageView.addConstraint(NSLayoutConstraint(item: arrowImageView, attribute: .width, relatedBy: .equal, toItem: arrowImageView, attribute: .width, multiplier: 0, constant: 10))
        arrowImageView.addConstraint(NSLayoutConstraint(item: arrowImageView, attribute: .height, relatedBy: .equal, toItem: arrowImageView, attribute: .height, multiplier: 0, constant: 5.6))
        
        addSelectButton()
    }
    
    func initTitleLabel(){
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = ""
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func initArrowImageView(){
        arrowImageView = UIImageView(image: arrowDown, highlightedImage: arrowUp)
        arrowImageView.isHighlighted = isOpen
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(arrowImageView)
    }
    
    func addSelectButton(){
        selectButton = UIButton(type: .custom)
        selectButton.backgroundColor = UIColor.clear
        selectButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        selectButton.drawInView(self)
    }
    
}
