//
//  InformationMessageViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/9.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class InformationMessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let menuView = MenuView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        menuView.contentHeightTab = -49
        menuView.titleArray = ["通知公告","法律法规"]
        menuView.delegate = self
        self.view.addSubview(menuView)
        // Do any additional setup after loading the view.
    }
}
extension InformationMessageViewController:MenuViewProtocol{
    func menuViewIndex(index: Int) {
        
    }
    
    
    func menuView(forIndex index: Int) -> UIView {
        print("index = \(index)")
        if index == 0 {//通知通告
            let firstVc = InformationMessageListViewController()
//            firstVc.evaluateRowBlock = evaluateRowBlock
            firstVc.categoryId = "b784dd36c4fc459a972c5d008bcb30ac"
            self .addChild(firstVc)
            return firstVc.view
        }else if index == 1{//政策法规
            let secondVc = InformationMessageListViewController()
            secondVc.categoryId = "6"
//            secondVc.evaluateRowBlock = evaluateRowBlock
            self .addChild(secondVc)
            return secondVc.view
        }
        return UIView()
        
    }
}
