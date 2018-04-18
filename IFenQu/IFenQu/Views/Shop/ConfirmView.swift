//
//  ConfirmView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/13.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///商品详情底部确认的视图View
import UIKit

class ConfirmView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let btn = UIButton.init(frame: CGRect.init(x: frame.size.width - 150, y: 0, width: 150, height: frame.size.height))
        btn.setTitle("立即购买", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.brown
        btn.block = {
            
        }
        
        let lable = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: frame.size.width - 170, height: frame.size.height))
        lable.text = "金额：90800.00起\n每期 ¥899.33"
        lable.numberOfLines = 0
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textColor = UIColor.black
        self.addSubview(btn)
        self.addSubview(lable)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
