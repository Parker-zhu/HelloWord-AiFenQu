//
//  ShippingAddressViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/18.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///收货地址

import UIKit

@objc protocol ShippingAddressVcDelegate {
    
    /// 完成信息修改调用的代理
    ///
    /// - Parameter infoModel: 修改后的模型信息
    func completedInformationModification(infoModel:Any)
}

class ShippingAddressViewController: BaseViewController {
    ///姓名
    @IBOutlet weak var nameTextF: XTextField!
    ///手机号
    @IBOutlet weak var phoneTextF: XTextField!
    ///地址
    @IBOutlet weak var addressBtn: XButton!
    ///详细地址
    @IBOutlet weak var detailedAddressTextView: XTextView!
    ///保存事件
    @IBAction func saveAction(_ sender: UIButton) {
        ///判断信息填写格式是否正确
        
        var isFinish = nameTextF.text!.count > 0
        isFinish = isFinish && phoneTextF.text!.isPhoneNum()
        isFinish = isFinish && detailedAddressTextView.text.count > 0
        //判断地址信息是否选择
        if !isFinish {
            Hud.showError(text: "信息不完整或手机格式有误，请核实")
            return
        }
    
        Network.dataRequest(url: "", param: nil, reqmethod: .POST) { (result) in
            self.navigationController?.popViewController(animated: true)
            self.delegate?.completedInformationModification(infoModel:"")
        }
    
    }
    
    var delegate: ShippingAddressVcDelegate?
    
    ///通过设置这个属性来标示是新增还是修改收货地址
    var infoModel: Any? {
        didSet{
            self.navigationItem.title = "修改收货地址"
            //初始化信息数据
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBaseInfo()
    }

    ///配置一些基本设置
    func initBaseInfo() {
        self.navigationItem.title = "新增收货地址"
        
        let lable = UILabel.init()
        lable.text = "详细地址"
        lable.textColor = UIColor.lightGray
        detailedAddressTextView.placeholderLable = lable
        
        addressBtn.layer.cornerRadius = 5
        addressBtn.layer.masksToBounds = true
        
        addressBtn.setTitle("地区选择", for: .normal)
        addressBtn.setImage(UIImage.init(named: "Group 634"), for: .normal)
        addressBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        addressBtn.setTitleColor(UIColor.lightGray, for: .normal)
//        addressBtn.isShowBottomLine = true
//        addressBtn.bottomLineColor = xlightGray
        addressBtn.drawLine(types: [(.bottom,xlightGray)])
        nameTextF.linePosition = [.bottom]
        nameTextF.delegate = self
        phoneTextF.delegate = self
        detailedAddressTextView.delegate = self
        phoneTextF.linePosition = [.bottom]
        
        addressBtn.block = {
            //修改地址信息后，设置Btn的text
            
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ShippingAddressViewController: UITextViewDelegate,UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextF {
            phoneTextF.becomeFirstResponder()
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        ///如果是手机号，判断条件：输入的是数字，text是11位
        if textField == phoneTextF {
            if string.isNum() && textField.text!.count <= 10 {
                return true
            }
            return false
        }
        return true
    }
}
