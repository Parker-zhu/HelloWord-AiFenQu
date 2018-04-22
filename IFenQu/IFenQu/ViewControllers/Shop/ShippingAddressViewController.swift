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
        loadJson()
    }

    var areaModels = [AreaModel]()
    
    func loadJson() {
        let path = Bundle.main.path(forResource: "openArea", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            /*
             * try 和 try! 的区别
             * try 发生异常会跳到catch代码中
             * try! 发生异常程序会直接crash
             */
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonArr = jsonData as! [[String:Any]]
            for model in jsonArr {
                self.areaModels.append(AreaModel.deserialize(from: model)!)
            }
            
        } catch let error as Error! {
            print("读取本地数据出现错误!",error)
        }
    }
    ///配置一些基本设置
    func initBaseInfo() {
        self.navigationItem.title = "新增收货地址"
        self.view.backgroundColor = xlightGray
        
        let lable = UILabel.init()
        lable.text = "详细地址"
        lable.textColor = UIColor.lightGray
        detailedAddressTextView.placeholderLable = lable
        
        let addressBtn = IButton.init(frame: addressView.bounds)
        addressView.addSubview(addressBtn)
        addressBtn.layer.cornerRadius = 5
        addressBtn.layer.masksToBounds = true
        
        addressBtn.titleLable.text = "地区选择"
        addressBtn.imageView.image = UIImage.init(named: "Group 634")
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

    var areaPickerView: UIPickerView!
    
    @objc func areaViewMiss() {
//        self.areaPickerView.superview?.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            self.areaPickerView.y = self.view.height
        }, completion: { (isEnd) in
            self.areaPickerView.superview!.removeFromSuperview()
        })
    }
    ///弹出地区选择
    @objc func showAreaView() {
        let bgView = UIView.init(frame: self.view.bounds)
        bgView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
//        let tap = UITapGestureRecognizer.init()
//        tap.addTarget(self, action: #selector(areaViewMiss))
//        bgView.addGestureRecognizer(tap)
        self.view.addSubview(bgView)
        let areaView = UIPickerView.init(frame: CGRect.init(x: 0, y: self.view.height, width: SCREEN_Width, height: 200))
        areaPickerView = areaView
        areaView.backgroundColor = UIColor.red
        
        let sureBtn = UIButton.init(frame: CGRect.init(x: 0, y: self.view.height + 50, width: SCREEN_Width, height: 50))
        bgView.addSubview(sureBtn)
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.addTarget(self, action: #selector(areaViewMiss), for: .touchUpInside)
        sureBtn.backgroundColor = xyellow
        UIView.animate(withDuration: 0.5) {
            areaView.y = self.view.height - 250
            sureBtn.y = self.view.height - 50
        }
        bgView.addSubview(areaView)
        
        
    }
    func netRequest() {
        let param = ["provinceName":"上海市","cityName":"上海市","areaName":"浦东新区","address":"神龙教","addressee":"神龙教","mobile":"17602138417"]
        Network.dataRequest(header: nil, url: Url.getAddress(), param: param, reqmethod: .POST, responseSerializerType: .responseHttp) { (result) in
            self.navigationController?.popViewController(animated: true)
            self.delegate?.completedInformationModification(infoModel:"")
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
