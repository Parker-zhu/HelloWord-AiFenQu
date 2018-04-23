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

class ShippingAddressViewController: BaseViewController,AreaChooesViewDelegate {
    ///姓名
    @IBOutlet weak var nameTextF: XTextField!
    ///手机号
    @IBOutlet weak var phoneTextF: XTextField!
    ///地址
    @IBOutlet weak var addressView: UIView!
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
    
        netRequest()
    
    }
    
    var delegate: ShippingAddressVcDelegate?
    var addressBtn:IButton!
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
        self.view.backgroundColor = xlightGray
        
        let lable = UILabel.init()
        lable.text = "详细地址"
        lable.textColor = UIColor.lightGray
        detailedAddressTextView.placeholderLable = lable
        
        addressBtn = IButton.init(frame: addressView.bounds)
        addressView.addSubview(addressBtn)
        addressBtn.layer.cornerRadius = 5
        addressBtn.layer.masksToBounds = true
        
        addressBtn.titleLable.text = "地区选择"
        addressBtn.imageView.image = UIImage.init(named: "Group 634")
        addressBtn.imageView.width = 30
        addressBtn.imageView.x = addressView.width - 30
        addressBtn.titleLable.font = UIFont.systemFont(ofSize: 13)
        addressBtn.positionType = .wl_ir
        addressBtn.titleLable.textColor = UIColor.lightGray
        addressBtn.drawLine(types: [(.bottom,xlightGray)])
        let tap = UITapGestureRecognizer.init()
        tap.addTarget(self, action: #selector(showAreaView))
        addressBtn.addGestureRecognizer(tap)
        
        nameTextF.linePosition = [.bottom]
        nameTextF.delegate = self
        phoneTextF.delegate = self
        detailedAddressTextView.delegate = self
        detailedAddressTextView.drawLine(types: [(.bottom,xlightGray)])
        phoneTextF.linePosition = [.bottom]
        
        
    }

    lazy var areaPickerView: AreaChooesView = {
        let area = AreaChooesView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 340))
        area.delegate = self
        return area
    }()
    
    ///弹出地区选择
    @objc func showAreaView() {
        PopView.show(view: areaPickerView, isAnmation: true)

    }
    var areaDicInfo: [String:String]?
    func netRequest() {
        if areaDicInfo == nil || !phoneTextF.text!.isPhoneNum() || nameTextF.text! == "" || detailedAddressTextView.text == "" {
            Hud.showError(text: "请完善信息")
            return
        }
        
        let param = ["provinceName":areaDicInfo!["provinceName"]!,"cityName":areaDicInfo!["cityName"]!,"areaName":areaDicInfo!["areaName"]!,"address":detailedAddressTextView.text,"mobile":phoneTextF.text!] as [String : Any]
        
        Network.dataRequest(header: nil, url: Url.getAddress(), param: param, reqmethod: .POST, responseSerializerType: .responseHttp) { (result) in
            self.navigationController?.popViewController(animated: true)
            self.delegate?.completedInformationModification(infoModel:"")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func didSelectedArea(area: [String: String]) {
        areaDicInfo = area
        let text = area["provinceName"]! + " " + area["cityName"]! + " " + area["areaName"]!
        addressBtn.titleLable.text = text
        addressBtn.titleLable.width = text.getTextSizeB(font: addressBtn.titleLable.font).width
        addressBtn.titleLable.textColor = UIColor.black
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
