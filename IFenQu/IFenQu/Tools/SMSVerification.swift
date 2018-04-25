//
//  SMSVerification.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/3/26.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///短信验证

import UIKit
import GT3Captcha
import AFNetworking

class SMSVerification: XButton,GT3CaptchaManagerDelegate,GT3CaptchaManagerViewDelegate {
    
    var manger: GT3CaptchaManager!
    var succesBlock: (() -> Void)!
    var phoneNumb: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        manger = GT3CaptchaManager.init(api1: api1, api2:api2, timeout: 15.0)
        manger.delegate = self
        manger.viewDelegate = self
        manger.useVisualView(with: UIBlurEffect.init(style: .dark))
        manger.registerCaptcha {
        }
        
    }
    
    ///开始验证
    func starVerify(phone:String,success:@escaping () -> Void) {
            self.succesBlock = success
            phoneNumb = phone
        
            weak var weakSelf = self
            Network.dataRequest(url: api1, param: nil, reqmethod: .GET) { (result) in
                if result?.code == 1 {
                    weakSelf?.manger.configureGTest(result?.responseDic["gt"] as! String, challenge: result?.responseDic["challenge"] as! String, success: result?.responseDic["success"] as! NSNumber, withAPI2: api2)
                    weakSelf?.manger.startGTCaptchaWith(animated: true)
                } else {
                    Hud.showError(text: "请检查网络")
                }
            }
    }
    
    func stopVerify() {
        manger.stopGTCaptcha()
    }
    
    //验证的代理
    func gtCaptcha(_ manager: GT3CaptchaManager!, errorHandler error: GT3Error!) {
        
    }
    
    func gtCaptcha(_ manager: GT3CaptchaManager!, didReceiveCaptchaCode code: String!, result: [AnyHashable : Any]!, message: String!) {
        let r = result as! [String : String]
        let dic:[String:String] = ["challenge":r["geetest_challenge"]!,"validate":r["geetest_validate"]!,"seccode":r["geetest_seccode"]!]
        let param = ["mobile":phoneNumb]
        Network.dataRequest(header: ("Ifenqu-Validate",convertDictionaryToString(dict: dic)), url: "https://account.ifenqu.com/v1/send-login-verify-code", param: param, reqmethod: .POST) { (result) in
            if result?.code == 1 {
                Hud.showError(text: "成功发送验证码")
                
                self.succesBlock()
            }
        }
    }
    
    ///字典转json字符串
    func convertDictionaryToString(dict:[String:String]) -> String {
        var result:String = ""
        do {
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
            
        } catch {
            result = ""
        }
        return result
    }
    
    
    func shouldUseDefaultSecondaryValidate(_ manager: GT3CaptchaManager!) -> Bool {
        return false
    }
    
    func gtCaptcha(_ manager: GT3CaptchaManager!, didReceiveSecondaryCaptchaData data: Data!, response: URLResponse!, error: GT3Error!, decisionHandler: ((GT3SecondaryCaptchaPolicy) -> Void)!) {
    }
    
    deinit {
        manger?.stopGTCaptcha()
    }
    
}
