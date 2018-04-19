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
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var authCodeBtn: SMSVerification!
    
    @IBOutlet weak var weChatBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = xlightGray
        
        secretTextBtn.drawLine(types: [(DrawLine.bottom,UIColor.lightGray)])
        initTextF(textF: phoneTextF)
        initTextF(textF: authCodeTextF)
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
        
        loginBtn.shadeColor(starColor: UIColor.init(red: 255/255.0, green: 195/255.0, blue: 0, alpha: 1), endColor: UIColor.init(red: 1.0, green: 154/255.0, blue: 0, alpha: 1))
        
        ///检查微信是否安装，没有安装隐藏微信登陆View
//        weChatBgView.isHidden = true
        
    }
    ///配置UITextField基本信息
    func initTextF(textF:UITextField) {
        textF.delegate = self
        textF.keyboardType = .numberPad
        textF.clearButtonMode = .whileEditing
    }
    //MARK:xib上的事件
    //返回按钮的点击事件
    @IBAction func back(_ sender: Any) {
        
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
        
    }
    
    //登陆
    @IBAction func loginBtnClick(_ sender: Any) {
        //先判断电话，验证码，格式
        if phoneTextF.text!.isPhoneNum() && authCodeTextF.text!.isNum() && authCodeTextF.text!.count > 0 {
            
            self.view.endEditing(true)
            //进行登陆请求
            let param = ["account":phoneTextF.text!,"verifyCode":authCodeTextF.text!]
            Network.dataRequest(url: Url.getLogin(), param: param, reqmethod: .POST, callBack: { (result) in
                guard let data: [String:Any] = result?.responseDic["data"] as?  [String:Any] else {
                    return
                }
                
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let color = UIColor.init(red: 255/255, green: 170/255, blue: 0, alpha: 1)
        
            textField.superview?.drawLine(types: [(.top,color),(.right,color),(.left,color),(.bottom,color)])
        
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        for l in textField.superview!.layer.sublayers! {
            if l is CAShapeLayer {
                l.removeFromSuperlayer()
            }
        }
        return true
    }
}
