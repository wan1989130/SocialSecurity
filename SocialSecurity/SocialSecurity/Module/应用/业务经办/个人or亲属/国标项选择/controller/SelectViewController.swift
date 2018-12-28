//
//  SelectViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/20.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SelectViewController: BaseViewController {

    
    @IBAction func finishClick(_ sender: Any) {
        var flag = false
        for item in dataArray{
            if item .isSelect{
                flag = true
                let dic:NSMutableDictionary = [
                    "model":item,
                    "selectIndexId":selectIndexId
                ]
                dismissBlock?(dic)
            }
        }
        if !flag{
            LHAlertView.showTipAlertWithTitle("请选择")
            return
        }

        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var tableView: UITableView!
    var dataArray:Array<DictionaryModel> = [DictionaryModel]()
    var selectIndexId = ""
    var selectIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        
    }
    deinit{
        print("sssss")
    }

  
}
extension SelectViewController{
    fileprivate func initUI(){
        weak var weakSelf = self
        self.view.backgroundColor = viewBgColor
        tableView.delegate = weakSelf
        tableView.dataSource = weakSelf
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("SelectTableViewCell")
      
        
    }
    fileprivate func initData(){
        
        if senderParam != nil{
            let dic = senderParam as! NSMutableDictionary
            let tempDataArray = dic["array"] as! Array<DictionaryModel>
            for item in tempDataArray{
                dataArray.append(Mapper<DictionaryModel>().map(JSONObject: item.toJSON())!)
            }
            if dic["selectIndexId"] as! String != ""{
                for i in 0..<dataArray.count{
                    if dataArray[i].id == dic["selectIndexId"] as! String{
                        dataArray[i].isSelect = true
                        selectIndexId = dataArray[i].id
                        selectIndex = i
                        
                    }
                }
            }else{
                dataArray[0].isSelect = true
                selectIndexId = dataArray[0].id
                selectIndex = 0
            }
            
           
        }
        
    }
}
extension SelectViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectTableViewCell.loadCell(tableView)
        
        cell.update(model: dataArray[indexPath.row], index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != selectIndex{
            dataArray[selectIndex].isSelect = !dataArray[selectIndex].isSelect
            selectIndex = indexPath.row
            dataArray[selectIndex].isSelect = !dataArray[selectIndex].isSelect
            self.tableView.reloadData()
        }
        
        
    }
  
}

