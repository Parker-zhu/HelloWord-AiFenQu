//
//  LoginViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///登陆

import UIKit
import SDWebImage

class LoginViewController: BaseViewController {
    
    //MARK: xib上的视图控件
    @IBOutlet weak var phoneTextF: UITextField!
    @IBOutlet weak var authCodeTextF: UITextField!
    
    @IBOutlet weak var secretTextBtn: XButton!
    
    @IBOutlet weak var iconsuperView: UIView!
   
    @IBOutlet weak var authCodeBtn: SMSVerification!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextF.delegate = self
        phoneTextF.keyboardType = .numberPad
        authCodeTextF.delegate = self
        authCodeTextF.keyboardType = .numberPad
        secretTextBtn.isShowBottomLine = true
        phoneTextF.clearButtonMode = .whileEditing
        authCodeTextF.clearButtonMode = .whileEditing
        let iconImageView = IconImageView.init(frame: iconsuperView.bounds)
//        iconImageView.image = UIImage.init(named: "iconImage")
//        iconImageView.contentMode = .center
        iconsuperView.addSubview(iconImageView)
    }
    //MARK:xib上的事件
    //返回按钮的点击事件
    @IBAction func back(_ sender: Any) {
        authCodeBtn.time = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    //获取验证码
    @IBAction func getCodeClick(_ sender: Any) {
        let btn = sender as! SMSVerification
        //先判断电话格式是否正确
        if phoneTextF.text!.isPhoneNum() {
            weak var weakSelf = self
            btn.starVerify(phone: phoneTextF.text!, success: {
                //倒计时
                weakSelf?.authCodeTextF.becomeFirstResponder()
                btn.time = 60
            })
           
        } else {
            Hud.showError(text: "请输入有效的手机号")
        }
    }
    
    
    //隐私条款
    @IBAction func secretClick(_ sender: Any) {
        Network.dataRequest(url: Url.getEnvironment() + "product/v1/products", param: nil, reqmethod: .GET) { (result) in
            
        }
    }
    
    //登陆
    @IBAction func loginBtnClick(_ sender: Any) {
        //先判断电话，验证码，格式
        if phoneTextF.text!.isPhoneNum() && authCodeTextF.text!.isNum() && authCodeTextF.text!.count > 0 {
            
            self.view.endEditing(true)
            //进行登陆请求
            let param = ["account":phoneTextF.text!,"verifyCode":authCodeTextF.text!]
            Network.dataRequest(url: Url.getEnvironment() + "v1/login-verify", param: param, reqmethod: .POST, callBack: { (result) in
                guard let data: [String:Any] = result?.responseDic["data"] as?  [String:Any] else {
                    return
                }
                let model = TokenModel.initWithDict(dict: data)
                CacheManager.storeCache(key: "token", obj: data)
            })
        } else {
            if !phoneTextF.text!.isPhoneNum() {
                Hud.showError(text: "请输入有效的手机号")
            } else if !authCodeTextF.text!.isNum() {
                Hud.showError(text: "请输入有效的验证码")
            }
        }
    }
}

//MARK:协议
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //判断字符是不是数字
        if string.count > 0 {
            //如果字符够11位停止输入
            if textField == self.phoneTextF && textField.text!.count > 10 {
                return false
            }
            return string.isNum()
            
        }
        
        return true
    }
}
