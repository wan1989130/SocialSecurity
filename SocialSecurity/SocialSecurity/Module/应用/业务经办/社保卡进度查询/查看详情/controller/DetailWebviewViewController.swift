//
//  DetailWebviewViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import WebKit
class DetailWebviewViewController: BaseViewController {
    var webView = WKWebView()
    var progressView = UIProgressView()
    var urlContent = ""
    var titleContent = ""
    var saveModel:CaijiSaveModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        URLCache.shared.removeAllCachedResponses()
        initWeb()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.reloadInputViews()
        for item in progressView.subviews{
            item.removeFromSuperview()
        }
        //        progressView.removeAllSubviews()
        progressView.removeFromSuperview()
        
    }

   
}
extension DetailWebviewViewController:WKNavigationDelegate,WKUIDelegate{
    func initWeb(){
        title = titleContent
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.preferences.javaScriptEnabled = true
        
        let jSString = "var meta = document.createElement('meta')meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let wkUserScript = WKUserScript.init(source: jSString , injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        wkWebConfig.userContentController.addUserScript(wkUserScript)
        //        wkWebConfig.userContentController.add(self , name: "AppModel")
        webView = WKWebView(frame: self.view.bounds, configuration: wkWebConfig)
        
        //                webView = WKWebView(frame: self.view.bounds)
        
        //        webView.navigationDelegate = self
        //        webView.uiDelegate = self;
        //        if urlContent != ""{
        //            let url = URL(string: urlContent)
        //            let request = URLRequest(url: url!)
        //            webView.load(request)
        //        }else{
        //            let url = URL(string: "http://www.baidu.com")
        //            let request = URLRequest(url: url!)
        //            webView.load(request)
        //        }
        
        
        //加载本地url
        //                let url = Bundle.main.url(forResource: "test", withExtension: "html")
        //                webView.load(URLRequest(url:url!))
        //        loadHost(string: "test")
        loadHost(string: "index")
        
        self.view.addSubview(webView)
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        progressView = UIProgressView(frame: CGRect(x: 0, y: 44-2, width: UIScreen.main.bounds.size.width, height: 2))
        progressView.trackTintColor = UIColor.white
        progressView.progressTintColor = UIColor.orange
        self.navigationController?.navigationBar.addSubview(progressView)
        
        let button =   UIButton(type: .system)
        button.frame = CGRect(x:0, y:0, width:10, height:30)
        button.setImage(UIImage(named:"arrow_back"), for: .normal)
        button.setTitle("返回", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.sizeToFit()
        button.addTarget(self, action: #selector(backItemPressed), for: .touchUpInside)
        let leftBarBtn = UIBarButtonItem(customView: button)
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -5;
        self.navigationItem.leftBarButtonItems = [spacer,leftBarBtn]
        
        //        let item = UIBarButtonItem(title: "返回集优化", style: .plain, target: self, action: #selector(backItemPressed))
        //        self.navigationItem.leftBarButtonItem = item
        
        
    }
    
    fileprivate func loadHost(string:String) {
        let path = Bundle.main.path(forResource: string, ofType: "html")
        // 获得html内容
        do {
            let path2 = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent("test22.html")
            
            var fileManager = FileManager.default
            if fileManager.fileExists(atPath: path2){
                try! fileManager.removeItem(atPath: path2)
                try fileManager.copyItem(atPath: path!, toPath: path2)
            }else{
                try fileManager.copyItem(atPath: path!, toPath: path2)
            }
            let contentData = fileManager.contents(atPath: path2)
            let contentStr = String(data: contentData!, encoding: String.Encoding.utf8)
            if contentStr != nil{
                let contentStrReplace = (contentStr as! NSString).replacingOccurrences(of: "##32", with: "https://js.tuguaishou.com/start-design/20180326/28.jpg")
                
                try contentStrReplace.write(to: URL.init(fileURLWithPath: path2), atomically: true, encoding: String.Encoding.utf8)
            }
            
            webView.loadFileURL(URL.init(fileURLWithPath: path2), allowingReadAccessTo: URL.init(fileURLWithPath: path2))
            
            //            var html = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            //            html = (html as NSString).replacingOccurrences(of: "服务器传值测试", with: "aa")
            //            // 加载js
            //            webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        } catch { }
    }
    
    
    @objc func backItemPressed() {
        if webView.canGoBack {
            webView.goBack()
        }else{
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            }
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            print(webView.estimatedProgress)
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        progressView.setProgress(0, animated: false)
        print("wk完成")
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("error =\(error)")
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        let scheme = url?.scheme
        guard let schemeStr = scheme else { return  }
        if schemeStr == "tel" {
            //iOS10 改为此函数
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [ : ], completionHandler: nil)
                //                UIApplication.shared.open(url!, options: [String : Any](), completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
        decisionHandler(.allow)
    }
}
extension DetailWebviewViewController{
    
}
extension DetailWebviewViewController{
    
}
