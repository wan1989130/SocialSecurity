//
//  WebViewController.swift
//  MiddleSchool2_teacher
//
//  Created by 王岩 on 2017/5/15.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit
import WebKit
class PersonHelpWebViewController: BaseViewController,UIWebViewDelegate {
    var webView = WKWebView()
    var progressView = UIProgressView()
    var urlContent = ""
    var titleContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        initData()
        URLCache.shared.removeAllCachedResponses()
        initWeb()
        
    }
    
    

    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.reloadInputViews()
        progressView.removeAllSubviews()
        progressView.removeFromSuperview()
    }
}
extension PersonHelpWebViewController:WKNavigationDelegate,WKUIDelegate{
    
    
    func initWeb(){
        title = titleContent
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.preferences.javaScriptEnabled = true
        wkWebConfig.preferences.minimumFontSize = 8
        let jSString = "var meta = document.createElement('meta')meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let wkUserScript = WKUserScript.init(source: jSString , injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        wkWebConfig.userContentController.addUserScript(wkUserScript)
        //        wkWebConfig.userContentController.add(self , name: "AppModel")
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - CGFloat(navHeight)), configuration: wkWebConfig)
        
        //                webView = WKWebView(frame: self.view.bounds)
        
        webView.navigationDelegate = self
        webView.uiDelegate = self;
        
        loadHost(string: urlContent)
        
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
        
        let rightBarButtonItem = UIBarButtonItem(title: "联系我们", style: .plain, target: self, action: #selector(rightBarButtonClicked(sender:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
    }
    @objc func rightBarButtonClicked(sender: UIBarButtonItem){
        pushViewController("ConnactUsViewController")
    }
    fileprivate func loadHost(string:String) {
        
        let filePath = Bundle.main.path(forResource: string, ofType: "html")
        do {
            
            let htmlString = try String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
            
            //            webView.loadHTMLString(htmlString, baseURL: URL.init(fileURLWithPath: Bundle.main.bundlePath))
            //href="css/min/home.min.css"
            //            src="images/qq.gif"
            //            全部替换为这种样式，不用写路径了
            
            //            href="min.css"
            //            src="qq.gif"
            webView.loadHTMLString(htmlString, baseURL: URL.init(fileURLWithPath: Bundle.main.bundlePath))
            
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        
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
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail =\(error)")
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation =\(error)")
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

