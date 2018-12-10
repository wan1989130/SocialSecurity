//
//  PoPSelectListView.swift
//  MiddleSchool2_teacher
//
//  Created by 王岩 on 2017/5/15.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit
typealias PoPSelectListViewCellClickedBlock = (_ index:Int) -> Void
class PoPSelectListView: UIView {
    
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
    let maxCount:Int = 4
    var title:String = ""
    var dataArr:Array<BaseModel> = []
    var rowBlock:PoPSelectListViewCellClickedBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    func update(title:String,dataArr:Array<BaseModel>){
        
        
        self.title = title
        self.dataArr = dataArr
        if dataArr.count<=3 {
            tableViewHeightConstraint.constant = 44 * (CGFloat(dataArr.count)+1)
            //少于三条不滑动
            tableView.bounces = false
            
        }
        tableView.reloadData()
    }
}

//MARK:- Private
extension PoPSelectListView{
    func initData(){
        
    }
    
    func initUI(){
        self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        self.removeFromSuperview()
    }
}

extension PoPSelectListView : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.title
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
        view.backgroundColor = UIColor(hexString: "FFFFFF")
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.size.width, height: 44))
        label.text = self.title
        view .addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let str = self.dataArr[indexPath.row].name
        let height = str.getSize(withFont: UIFont.systemFont(ofSize: 14), forWidth: ScreenWidth - 32 - 80).height + 16 + 1
        return height >= 44 ? height : 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PopSelectListTableViewCell.loadCell(tableView)
        cell.contentText = self.dataArr[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowBlock?(indexPath.row)
        self.removeFromSuperview()
    }
}
