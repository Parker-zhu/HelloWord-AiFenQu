//
//  MobileViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/11.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///更改手机号码/完善手机号码
import UIKit
///初始化类型，change更改手机号码/add完善手机号码
enum InitType {
    case add,change
}
class MobileViewController: BaseViewController {

    var isChangeMobile: Bool! {
        didSet{
            self.title = isChangeMobile ? "完善手机号码" : "更改手机号码"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        let mobileBgView = UIView.init(frame: CGRect.init(x: 0, y: 100, width: SCREEN_Width, height: isChangeMobile ? 120 : 60))
        mobileBgView.backgroundColor = UIColor.white
        self.view.addSubview(mobileBgView)
        
        let codeBtn = XButton.init()
        mobileBgView.addSubview(codeBtn)
        codeBtn.setTitle("获取验证", for: .normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        codeBtn.setTitleColor(UIColor.init(red: 69/255, green: 165/255, blue: 206/255, alpha: 1), for: .normal)
        
        codeBtn.addTarget(self, action: #selector(codeAction), for: .touchUpInside)
        codeBtn.mas_makeConstraints { (make) in
            make?.bottom.equalTo()(mobileBgView.mas_bottom)
            make?.width.equalTo()(100)
            make?.right.equalTo()(mobileBgView.mas_right)?.offset()(-20)
            make?.height.equalTo()(60)
        }
        
        let newPhoneTextF = UITextField.init()
        mobileBgView.addSubview(newPhoneTextF)
        newPhoneTextF.placeholder = "请输入新手机号"
        newPhoneTextF.delegate = self
        newMobileF = newPhoneTextF
        newPhoneTextF.mas_makeConstraints { (make) in
            make?.bottom.equalTo()(mobileBgView.mas_bottom)
            make?.left.equalTo()(mobileBgView.mas_left)?.offset()(20)
            make?.right.equalTo()(codeBtn.mas_left)?.offset()(10)
            make?.height.equalTo()(60)
        }
        
        
        if isChangeMobile {
            let oldPhoneTextF = UITextField.init()
            mobileBgView.addSubview(oldPhoneTextF)
            oldPhoneTextF.placeholder = "请输入原手机号"
            oldPhoneTextF.delegate = self
            oldMobileF = oldPhoneTextF
            oldPhoneTextF.mas_makeConstraints { (make) in
                make?.bottom.equalTo()(newPhoneTextF.mas_top)
                make?.left.equalTo()(mobileBgView.mas_left)?.offset()(20)
                make?.right.equalTo()(mobileBgView.mas_right)?.offset()(20)
                make?.height.equalTo()(60)
            }
            newPhoneTextF.drawLine(types: [.top])
        }
        
        
        let codeBgView = UIView.init(frame: CGRect.init(x: 0, y: mobileBgView.frame.maxY + 20, width: SCREEN_Width, height: 60))
        codeBgView.backgroundColor = UIColor.white
        self.view.addSubview(codeBgView)
        
        let codeTextF = UITextField.init()
        codeBgView.addSubview(codeTextF)
        codeTextF.delegate = self
        codeTextF.placeholder = "请输入验证码"
        codeF = codeTextF
        codeTextF.mas_makeConstraints { (make) in
            make?.top.equalTo()(codeBgView)
            make?.bottom.equalTo()(codeBgView)
            make?.left.equalTo()(codeBgView)?.offset()(20)
            make?.right.equalTo()(codeBgView)?.offset()(20)
        }
        
        let btn = UIButton.init(frame: CGRect.init(x: 20, y: codeBgView.frame.maxY + 20, width: SCREEN_Width - 40, height: 60))
        btn.setTitle(isChangeMobile ? "确认更换" : "确定", for: .normal)
        btn.setTitleColor(UIColor.init(red: 1.0, green: 165/255, blue: 0, alpha: 1), for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        btn.backgroundColor = UIColor.orange
        self.view.addSubview(btn)
        
        
    }

    var newMobileF: UITextField!
    var oldMobileF: UITextField?
    var codeF: UITextField!
    
    
    ///确定事件
    @objc func sureBtnAction() {
        if isChangeMobile {
            if oldMobileF!.text!.count == 0 {
                return
            }
        }
        if newMobileF.text!.count > 0 && codeF.text!.count > 0 {
            
        }
    }
    
    ///发送验证码
    @objc func codeAction() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension MobileViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isNum() {
            if textField != codeF && textField.text!.count > 10 {
                return false
            }
            return true
        }
        return false
    }
}
