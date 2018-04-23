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
        initBackView()
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
        timer?.fireDate = NSDate.distantPast
        timer?.fire()
    }

    func initBackView() {
        let headerImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: SCREEN_Height/7*5))
        headerImage.image = UIImage.init(named: "Path 122")
        self.view.addSubview(headerImage)
        
        let bottomImage = UIImageView.init(frame: CGRect.init(x: 0, y: SCREEN_Height/7*5, width: SCREEN_Width, height: SCREEN_Height/7*2))
        bottomImage.image = UIImage.init(named: "Group 488")
        self.view.addSubview(bottomImage)
    }
    lazy var ignoreBtn: UIButton = {
        let btn = UIButton.init()
        
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    
    var time: Int = 5 {
        didSet{
            if time > 0 {
                ignoreBtn.setTitle("\(time)s", for: .normal)
            } else {
//                ignoreBtn.setTitle("跳过", for: .normal)
                self.back()
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    lazy var timer: Timer? = {
        let t = Timer.init(timeInterval: 1, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        RunLoop.current.add(t, forMode: .commonModes)
//        t.fire()
        return t
    }()
    @objc func timeAction() {
        time -= 1
    }
    @objc func back() {
        if loadMainBlock != nil {
            loadMainBlock!()
        }
    }
    
    func loadData() {
        
        Network.dataRequest(url: Url.getBootPage(), param: nil, reqmethod: .GET) { (result) in
            if result?.code == 1 {
                guard let data = result?.responseDic["data"] as? [[String:Any]] else {
                    return
                }
                let content = data[0]["content"] as! String

                self.webView.loadHTMLString(content, baseURL: nil)
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
