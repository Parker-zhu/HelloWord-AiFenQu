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

class BootPageViewController: BaseViewController {

    ///返回事件调用block
    var loadMainBlock: (() -> Void)?
    ///加载广告
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
            if #available(iOS 11.0, *) {
                make?.top.equalTo()(self.view.mas_safeAreaLayoutGuideTop)?.offset()(20)
            } else {
                make?.top.equalTo()(self.view.mas_top)?.offset()(20)
            }

            make?.width.equalTo()(50)
            make?.height.equalTo()(30)
        }
        
    }

    ///"跳过"
    lazy var ignoreBtn: UIButton = {
        let btn = UIButton.init()
        
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    
    ///时间
    var time: Int = 5 {
        didSet{
            if time > 0 {
                ignoreBtn.setTitle("\(time)s", for: .normal)
            } else {
                self.back()
            }
        }
    }
    
    ///定时器
    lazy var timer: Timer? = {
        let t = Timer.init(timeInterval: 1, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        RunLoop.current.add(t, forMode: .commonModes)
        return t
    }()
    
    ///定时器的响应事件
    @objc func timeAction() {
        time -= 1
    }
    
    ///回到主控制器
    @objc func back() {
        if loadMainBlock != nil {
            loadMainBlock!()
        }
        timer?.invalidate()
        timer = nil
    }
    
    ///请求广告数据
    func loadData() {
        
        Network.dataRequest(url: Url.getBootPage(), param: nil, reqmethod: .GET) { (result) in
            if result?.code == 1 {
                guard let data = result?.responseDic["data"] as? [[String:Any]] else {
                    return
                }
                let content = data[0]["content"] as! String

                self.webView.loadHTMLString(content, baseURL: nil)
                self.timer?.fireDate = NSDate.distantPast
                self.timer?.fire()
            }
            else {
                self.back()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BootPageViewController: WKNavigationDelegate,WKUIDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if (navigationAction.request.url?.scheme?.contains("http"))! {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
