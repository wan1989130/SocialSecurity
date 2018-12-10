//
//  DropListView.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/16.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

typealias DropListViewSelectBlock = (_ list:DropListTitleView, _ info:BaseModel, _ index:Int) -> Void

enum DroplistCellType:Int{
    case normal = 0
    case mainTodoTask = 1
}

class DropListView: UIView  {
    var dropListCellType:DroplistCellType = .normal
    var selectedIndex:Int = -1
    var touchToHide = true
    var list:Array<BaseModel> = [BaseModel]()
    
    var overlayView:DropListCoverView!
    var tableView:UITableView!
    var didSelectBlock:DropListViewSelectBlock?
    
    var titleView:DropListTitleView?
//    var tempTitleView:DropListTitleView?
    var blackCoverView:UIView?
    
    var tableViewFrame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 0)
    var tableViewOriginY:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: UIApplication.shared.keyWindow!.bounds)
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func show(){
        if titleView == nil{
            return
        }
        
        let view = UIApplication.shared.keyWindow!
        overlayView = DropListCoverView(frame: view.bounds)
        overlayView!.dropView = self
        overlayView!.addSubview(self)
        
        
        let titleFrame = titleView!.convert(titleView!.bounds, to: view)
//        tempTitleView = DropListTitleView(frame: titleFrame)
//        tempTitleView!.title = titleView!.title
//        tempTitleView!.hideArrow()
//        tempTitleView!.buttonCanBeClicked = false
//        self.addSubview(tempTitleView!)
        
        tableViewOriginY = titleFrame.origin.y + titleFrame.size.height
        let tableViewHeight = CGFloat(44 * list.count) >= ScreenHeight - tableViewOriginY - 40 ? ScreenHeight - tableViewOriginY - 40 : CGFloat(44 * list.count)
        tableViewFrame = CGRect(x: 0, y: tableViewOriginY, width: ScreenWidth, height: 0)
        
        blackCoverView = UIView(frame: CGRect(x: 0, y: tableViewOriginY, width: ScreenWidth, height: ScreenHeight - tableViewOriginY))
        blackCoverView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.addSubview(blackCoverView!)
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
        blackCoverView?.addGestureRecognizer(tap)
        
        tableView = UITableView(frame: tableViewFrame, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        
        switch dropListCellType {
        case .mainTodoTask:
            registTableViewCell( "MainTodoTaskDropListTableViewCell")
            break
        default:
            registTableViewCell("DropListTableViewCell")
            break
        }
        
        self.addSubview(tableView)
        
        view.addSubview(overlayView!)
        
        UIView.animate(withDuration: 0.3) {
            self.tableView.frame = CGRect(x: 0, y: self.tableViewOriginY, width: ScreenWidth, height: tableViewHeight)
        }
    }
    
    fileprivate func registTableViewCell(_ cellNibName:String){
        let cellNib: UINib = UINib(nibName: cellNibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellNibName + "Id")
    }
    
    func show(titleView:DropListTitleView, completionBlock:DropListViewSelectBlock?){
        self.titleView = titleView
        self.didSelectBlock = completionBlock
        show()
    }
    
    @objc func dismiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = CGRect(x: 0, y: self.tableViewOriginY, width: ScreenWidth, height: 0)
        }) { (isOK) in
            if isOK{
                self.titleView?.isOpen = false
                self.removeFromSuperview()
                if self.overlayView != nil{
                    self.overlayView!.removeFromSuperview()
                }
            }
        }
        
    }
}

extension DropListView: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dropListCellType {
       
        default:
            let cell = DropListTableViewCell.loadCell(tableView)
            cell.title = list[indexPath.row].name
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        didSelectBlock?(titleView == nil ? DropListTitleView() : titleView!,list[indexPath.row],indexPath.row)
        dismiss()
    }
}

















