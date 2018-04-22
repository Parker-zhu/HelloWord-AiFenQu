//
//  BootPageManager
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///启动页
import UIKit
import WebKit
import AFNetworking
class BootPageManager: NSObject {

    
    var webView: WKWebView!
    
    var window: UIWindow!
    
    override init() {
        super.init()
        
        webView = WKWebView.init(frame: UIScreen.main.bounds)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window.windowLevel = UIWindowLevelStatusBar + 1
//        window.isHidden = false
        window.alpha = 1
        window.backgroundColor = UIColor.red
        window.rootViewController = UIViewController()
        loadData()
        window.addSubview(webView)
        
        ignoreBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(window.mas_right)?.offset()(-20)
            if #available(iOS 11.0, *) {
                make?.top.equalTo()(window.mas_safeAreaLayoutGuideTop)?.offset()(20)
            } else {
                make?.top.equalTo()(window.mas_top)?.offset()(20)
            }
            
            make?.width.equalTo()(50)
            make?.height.equalTo()(30)
        }
    }
    class func show() {
        let bootPageManager = BootPageManager.init()
        bootPageManager.loadData()
        
    }
    
    func initBackView() {
        let headerImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: SCREEN_Height/7*5))
        headerImage.image = UIImage.init(named: "Path 122")
        window.addSubview(headerImage)
        
        let bottomImage = UIImageView.init(frame: CGRect.init(x: 0, y: SCREEN_Height/7*5, width: SCREEN_Width, height: SCREEN_Height/7*2))
        bottomImage.image = UIImage.init(named: "Group 488")
        window.addSubview(bottomImage)
    }
    
    lazy var ignoreBtn: UIButton = {
        let btn = UIButton.init()
        
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        window.addSubview(btn)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    
    var time: Int = 7 {
        didSet{
            if time > 0 {
                ignoreBtn.setTitle("\(time)s", for: .normal)
            } else {
                ignoreBtn.setTitle("跳过", for: .normal)
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
        window.isHidden = true
    }
    func loadData() {
        
        Network.dataRequest(url: Url.getBootPage(), param: nil, reqmethod: .GET) { (result) in
            if result?.code == 1 {
                guard let data = result?.responseDic["data"] as? [[String:Any]] else {
                    return
                }
                self.window.isHidden = false
                let content = data[0]["content"] as! String

                self.webView.loadHTMLString(content, baseURL: nil)
                
                self.timer?.fireDate = NSDate.distantPast
                self.timer?.fire()
            }
        }
    }
    
}

extension BootPageManager: WKNavigationDelegate,WKUIDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if (navigationAction.request.url?.scheme?.contains("http"))! {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
}
