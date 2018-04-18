//
//  ChangePhoneViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///更换手机号
import UIKit

class ChangePhoneViewController: BaseViewController {
    //MARK:xib的视图
    @IBOutlet weak var oldMobileTextF: XTextField!
    
    @IBOutlet weak var newMobileTextF: XTextField!
    
    @IBOutlet weak var newMobileBgView: UIView!
    @IBOutlet weak var sureBtn: UIButton!
    
    @IBOutlet weak var authCodeTextF: XTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        oldMobileTextF.keyboardType = .numberPad
        newMobileTextF.keyboardType = .numberPad
        authCodeTextF.keyboardType = .numberPad
        oldMobileTextF.delegate = self
        newMobileTextF.delegate = self
        authCodeTextF.delegate = self
        sureBtn.layer.cornerRadius = 5
        sureBtn.layer.masksToBounds = true
        self.navigationItem.title = "手机号码更换"
        
    }
    
    //MARK:xib的事件
    ///短信验证
    @IBAction func messageClick(_ sender: Any) {
        if !oldMobileTextF.text!.isPhoneNum() {
            Hud.showError(text: "请输入有效的手机号")
            return
        }
        authCodeTextF.becomeFirstResponder()
    }
    
    ///确定更换
    @IBAction func sureClick(_ sender: Any) {
        self.view.endEditing(true)
        
        if oldMobileTextF.text!.isPhoneNum() && newMobileTextF.text!.isPhoneNum() && authCodeTextF.text!.isNum() {
            Hud.show()
            
        } else if !oldMobileTextF.text!.isPhoneNum() {
            Hud.showError(text: "您输入的原手机号是无效的\n请输入有效的手机号")
        } else if !newMobileTextF.text!.isPhoneNum() {
            Hud.showError(text: "您输入的新手机号是无效的\n请输入有效的手机号")
        } else if !authCodeTextF.text!.isNum() {
            Hud.showError(text: "您输入的验证码是无效的\n请输入有效的验证码")
        }
        
    }
    

}


extension ChangePhoneViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count > 0 {
            if textField == authCodeTextF {
                return string.isNum()
            } else {
                if textField.text!.count > 10 {
                    return false
                }
                return string.isNum()
            }
        }
        return true
    }
}
