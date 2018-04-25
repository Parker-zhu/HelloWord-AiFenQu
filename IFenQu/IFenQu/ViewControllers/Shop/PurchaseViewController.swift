//
//  PurchaseViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/22.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///购买确认页面
import UIKit

class PurchaseViewController: BaseViewController {

    var contenScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "购买确认"
        
        contenScrollView = UIScrollView.init(frame: self.view.bounds)
        self.view.backgroundColor = xlightGray
        contenScrollView.backgroundColor = xlightGray
        contenScrollView.contentSize = CGSize.init(width: 0, height: 0)
        self.view.addSubview(contenScrollView)
        
//        contenScrollView.mas_makeConstraints { (make) in
//            make?.right.equalTo()(self.view.mas_right)
//            make?.top.equalTo()(self.view.mas_top)
//            make?.bottom.equalTo()(self.view.safe)
//            make?.left.equalTo()(self.view.mas_left)
//
//        }
        
        let addressLable = UILabel.init(frame: CGRect.init(x: 20, y: 5, width: SCREEN_Width, height: 30))
        addressLable.text = "详细收货信息"
        addressLable.textColor = UIColor.darkGray
        addressLable.font = UIFont.systemFont(ofSize: 12)
        contenScrollView.addSubview(addressLable)
        
        let addressView = UIView.init()
        addressView.backgroundColor = UIColor.white
        addressView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init()
        tap.addTarget(self, action: #selector(addressAction))
        addressView.addGestureRecognizer(tap)
        contenScrollView.addSubview(addressView)
        v = addressView
        
        let addressInfoLable = UILabel.init()
        addressInfoLable.font = UIFont.systemFont(ofSize: 14)
        addressInfoLable.text = "新增收货地址"
        addressInfoLable.isUserInteractionEnabled = true
        addressInfoLable.numberOfLines = 0
        addressView.addSubview(addressInfoLable)
        addreLableInfo = addressInfoLable
        
        let pathImage = UIImageView.init()
        pathImage.contentMode = .center
        pathImage.isUserInteractionEnabled = true
        pathImage.image = UIImage.init(named: "path")
        addressView.addSubview(pathImage)
        
        addressView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view.mas_left)
            make?.right.equalTo()(self.view.mas_right)
            make?.top.equalTo()(addressLable.mas_bottom)
            make?.height.equalTo()((addressInfoLable.text?.getTextSizeB(font: addressInfoLable.font, size: CGSize.init(width: SCREEN_Width - 70, height: SCREEN_Height)).height)! + 30)
        }
        
        addressInfoLable.mas_makeConstraints { (make) in
            make?.left.equalTo()(addressView.mas_left)?.offset()(20)
            make?.bottom.equalTo()(addressView.mas_bottom)
            make?.top.equalTo()(addressView.mas_top)
            make?.width.equalTo()(SCREEN_Width - 70)
        }
        
        pathImage.mas_makeConstraints { (make) in
            make?.right.equalTo()(addressView.mas_right)?.offset()(-20)
            make?.bottom.equalTo()(addressView.mas_bottom)
            make?.top.equalTo()(addressView.mas_top)
            make?.width.equalTo()(30)
        }
        bottomView.backgroundColor = UIColor.white
        
        contentInfoView = PurchaseContentView.initFormNib() as! PurchaseContentView
        contenScrollView.addSubview(contentInfoView)
        
        contentInfoView.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.view.mas_right)
            make?.top.equalTo()(addressView.mas_bottom)?.offset()(20)
//            make?.height.equalTo()(500)
            make?.bottom.equalTo()(contenScrollView.mas_bottom)
            make?.left.equalTo()(self.view.mas_left)
        }
        
    }
    var contentInfoView: PurchaseContentView!
    
    lazy var bottomView = { () -> ConfirmView in
        let v = ConfirmView.initFormNib() as! ConfirmView
        v.frame = CGRect.init(x: 0, y: self.view.height - 80, width: SCREEN_Width, height: 80)
        self.view.addSubview(v)
//        v.delegate = self
        v.backgroundColor = UIColor.white
        return v
    }()
    var addreLableInfo: UILabel!
    var v: UIView!
    @objc func addressAction() {
//        addreLableInfo.text = "追问发会为和giureiugnreugnriutgtirugnuirtgnrtjngirtngjrtjrnjgbjrtgjtrn追问发会为问发会为和giureiugnreugnriutgtirugnuirtgnrtjngirtngjrtjrnjgbjrtgjtrn追问发会为问发会为和giureiugnreugnriutgtirugnuirtgnrtjngirtngjrtjrnjgbjrtgjtrn追问发会为问发会为和giureiugnreugnriutgtirugnuirtgnrtjngirtngjrtjrnjgbjrtgjtrn追问发会为问发会为和giureiugnreugnriutgtirugnuirtgnrtjngirtngjrtjrnjgbjrtgjtrn追问发会为问发会为和giureiugnreugnriutgtirugnuirtgnrtjngirtngjrtjrnjgbjrtgjtrn追问发会为问发会为和giureiugnreugnriutgtirugnuirtgnrtjngirtngjrtjrnjgbjrtgjtrn追问发会为问发会为和giureiugnreugnriutgtirugnuirtgnrtjngirtngjrtjrnjgbjrtgjtrn追问发会为问发会为和giureiugnreugnriutgtirugnuirtgnrtjngirtngjrtjrnjgbjrtgjtrn追问发会为"
//        v.mas_updateConstraints { (make) in
//            make?.height.equalTo()((addreLableInfo.text?.getTextSizeB(font: addreLableInfo.font, size: CGSize.init(width: SCREEN_Width - 70, height: SCREEN_Height)).height)! + 30)
//        }
//        self.view.layoutIfNeeded()
//        contenScrollView.contentSize = CGSize.init(width: SCREEN_Width, height: contentInfoView.frame.maxY + 80)
        let vc = ShippingAddressViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
