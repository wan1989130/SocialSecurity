//
//  InformationMessageDetailViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class InformationMessageDetailViewController: BaseViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var hitsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var dataController:InformationMessageDetailDataController!
    var id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "资讯详情"
        initData()
        initUI()
        getDetail()
        
    }



}
extension InformationMessageDetailViewController{
    fileprivate func initData(){
        dataController = InformationMessageDetailDataController(delegate: self)
        if senderParam != nil && senderParam is String{
            id = senderParam as! String
        }
    }
    
    fileprivate func initUI(){
        URLCache.shared.removeAllCachedResponses()
        //去掉底下黑线
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.delegate = self
        //去掉滚动条
        for subView in webView.subviews{
            let v = subView
            if v is UIScrollView{
            (v as! UIScrollView).showsHorizontalScrollIndicator = false
            (v as! UIScrollView).showsVerticalScrollIndicator = false
            }
            
        }
    }
}
extension InformationMessageDetailViewController{
    fileprivate func getDetail() {
        
        let parameter:NSMutableDictionary = [
            "id":id
        ]
        
        dataController.informationDetail(parameter: parameter) { (isSucceed, result) in
            if isSucceed {
               
                self.updateUI()
            }
        }
    }
    func updateUI(){
        titleLabel.text = dataController.model.data.title
        timeLabel.text = "发布" + dataController.model.data.createTime
        hitsLabel.text = dataController.model.data.hits
       
        webView.loadHTMLString((dataController.model.data.content as NSString).replacingOccurrences(of: "src=\"", with: "src=\"" + DetailImageAccess), baseURL: nil)
     
      
        
    }
   
 
}
extension InformationMessageDetailViewController:UIWebViewDelegate{
    //WebView图片自适应屏幕
    func webViewDidFinishLoad(_ webView: UIWebView) {
        var js = "function imgAutoFit() { var imgs = document.getElementsByTagName('img'); for (var i = 0; i < imgs.length; ++i) {var img = imgs[i];   img.style.maxWidth = %f;   } }";
        js = NSString(format: js as NSString, webView.bounds.size.width - 16) as String
        webView.stringByEvaluatingJavaScript(from: js as String)
        webView.stringByEvaluatingJavaScript(from: "imgAutoFit();")
        
        
    }
}
