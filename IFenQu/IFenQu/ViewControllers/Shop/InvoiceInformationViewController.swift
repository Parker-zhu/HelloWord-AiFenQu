//
//  InvoiceInformationViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/11.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
//发票信息
import UIKit

class InvoiceInformationViewController: BaseViewController {
    @IBAction func peopleBtnAction(_ sender: UIButton) {
        contentViewTop.constant = 20
        textInputView?.isHidden = true
        for subView in textInputView!.subviews {
            subView.isHidden = true
        }
        sender.setImage(UIImage.init(named: "pitchOn"), for: .normal)
        companyBtn.setImage(UIImage.init(named: "circle"), for: .normal)
    }
    @IBAction func companyBtnAction(_ sender: UIButton) {
        contentViewTop.constant = 170
        textInputView?.isHidden = false
        for subView in textInputView!.subviews {
            subView.isHidden = false
        }
        sender.setImage(UIImage.init(named: "pitchOn"), for: .normal)
        peopleBtn.setImage(UIImage.init(named: "circle"), for: .normal)
        
    }
    @IBOutlet weak var companyBtn: UIButton!
    @IBOutlet weak var peopleBtn: UIButton!
    @IBOutlet weak var numberTexF: UITextField!
    @IBOutlet weak var nameTextF: UITextField!
    @IBOutlet weak var textInputView: UIView!
    @IBOutlet weak var contentViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var shopDetaileLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleBtnAction(UIButton())
        self.title = "发票信息"
        self.view.backgroundColor = xlightGray
        
        let rightItem = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        rightItem.setTitleColor(UIColor.darkGray, for: .normal)
        rightItem.setTitle("开票须知", for: .normal)
        rightItem.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        rightItem.addTarget(self, action: #selector(alertAciton), for: .touchUpInside)
        let size = rightItem.titleLabel?.text?.getTextSizeB(font: (rightItem.titleLabel?.font)!)
        rightItem.width = size!.width
        rightItem.height = size!.height
        
        rightItem.setImage(UIImage.init(named: "path"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightItem)
        
        shopDetaileLable.layer.borderColor = xyellow.cgColor
        shopDetaileLable.layer.borderWidth = 1
        shopDetaileLable.layer.cornerRadius = 2
        shopDetaileLable.layer.masksToBounds = true
        
        nameTextF.backgroundColor = xlightGray
        numberTexF.backgroundColor = xlightGray
        
        
    }

    lazy var alertView = { () -> UIView in
        let alert = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width/4*3, height: SCREEN_Height/5*3))
        alert.backgroundColor = UIColor.white
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: alert.width, height: 60))
        label.text = "发票须知"
        label.textAlignment = .center
        alert.addSubview(label)
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: label.frame.maxY + 10, width: alert.width - 40, height: alert.height - 110))
        alert.addSubview(scrollView)
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: alert.height - 50, width: alert.width, height: 50))
        btn.setTitle("我知道了", for: .normal)
        btn.setTitleColor(xyellow, for: .normal)
        btn.addTarget(self, action: #selector(miss), for: .touchUpInside)
        btn.drawLine(types: [(DrawLine.top,xlightGray)])
        alert.addSubview(btn)
        return alert
    }()
    @objc func miss(){
        PopView.disMiss()
    }
    ///开票须知
    @objc func alertAciton() {
        PopView.show(view: alertView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
