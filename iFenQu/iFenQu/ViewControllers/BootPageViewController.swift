//
//  BootPageViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///启动页
import UIKit
import WebKit
import AFNetworking
class BootPageViewController: BaseViewController {

    ///返回事件调用block
    var loadMainBlock: (() -> Void)?
    lazy var webView = { () -> WKWebView in
        let web = WKWebView.init(frame: self.view.bounds)
        web.uiDelegate = self
        web.navigationDelegate = self
        
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.view.addSubview(webView)
        ignoreBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.view.mas_right)?.offset()(-20)
            make?.top.equalTo()(self.view.mas_top)?.offset()(20)
            make?.width.equalTo()(50)
            make?.height.equalTo()(30)
        }
    }

    lazy var ignoreBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("跳过", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(btn)
        btn.block = {
            self.loadMainBlock!()
        }
        return btn
    }()
    func loadData() {
        Network.dataRequest(url: Url.getBootPage(), param: nil, reqmethod: .GET) { (result) in
            if result?.code == 1 {
                guard let data = result?.responseDic["data"] as? [[String:Any]] else {
                    return
                }
                let content = data[0]["content"] as! String
                
                self.webView.loadHTMLString(content, baseURL: nil)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BootPageViewController: WKNavigationDelegate,WKUIDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
