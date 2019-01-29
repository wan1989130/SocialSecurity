//
//  MineViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/18.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    var dataController:MineDataController!
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        initUI()
    }



}
extension MineViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("MinePhotoHeaderTableViewCell")
        tableView.register("MineTableViewCell")
        
    }
    fileprivate func initData(){
        dataController = MineDataController(delegate: self)
    }
}
extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = viewBgColor
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 2
        }else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = MinePhotoHeaderTableViewCell.loadCell(tableView)
            cell.update()
            return cell
        }else {
            let cell = MineTableViewCell.loadCell(tableView)
            cell.imageView?.isHidden = false
            if indexPath.section == 1{
                if indexPath.row == 0{
                    cell.titleLabel.text = "完善个人信息"
                }else if indexPath.row == 1{
                    cell.titleLabel.text = "修改密码"
                }
            }else{
                if indexPath.row == 0{
                    cell.titleLabel.text = "意见反馈"
                }else if indexPath.row == 1{
                    cell.titleLabel.text = "联系我们"
                }else if indexPath.row == 2{
                    cell.titleLabel.text = "关于我们"
                }else if indexPath.row == 3{
                    cell.titleLabel.text = "当前版本：\(appBuildVersion)"
                    cell.imageView?.isHidden = true
                }else if indexPath.row == 4{
                    cell.titleLabel.text = "退出登录"
                    cell.imageView?.isHidden = true
                }
            }
            return cell
            
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let cell = MinePhotoHeaderTableViewCell.loadCell(tableView)
            
        }else {
            let cell = MineTableViewCell.loadCell(tableView)
            if indexPath.section == 1{
                if indexPath.row == 0{
                    pushViewController("MineMessageViewController")
                }else if indexPath.row == 1{
                    pushViewController("UpdatePasswordViewController")
                }
            }else{
                if indexPath.row == 0{
                    pushViewController("FeedBackViewController")
                }else if indexPath.row == 1{
                    callPhone()
                }else if indexPath.row == 2{
                    pushViewController("AboutUsViewController")
                }else if indexPath.row == 3{
                    
                }else if indexPath.row == 4{
                    LHAlertView.showAlertWithTitle("确认退出登陆吗？", msg: "", confirmButtonTitle: "确认", cancelButtonTitle: "取消", completionBlock: {
                        self.loadLogout()
                    }) {
                        
                    }
                }
            }
            
        }
    }
}
extension MineViewController{
    //退出登陆接口
    fileprivate func loadLogout(){
        MyConfig.shared().phone == ""
        MyConfig.shared().token == ""
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navController = BaseNavigationViewController(rootViewController: loginVC)
        UIApplication.shared.keyWindow?.rootViewController = navController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
 UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
    func callPhone(){
        pushViewController("ConnactUsViewController")
       
    }
}
