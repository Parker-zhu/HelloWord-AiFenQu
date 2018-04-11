//
//  AlertView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/10.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class AlertView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    class func show(text:String) -> AlertView{
        let alert = AlertView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width/7*5, height: 140))
        alert.layer.cornerRadius = 5
        alert.layer.masksToBounds = true
        
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: alert.width, height: 100))
        lable.text = text
        lable.textColor = UIColor.darkGray
        alert.addSubview(lable)
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: lable.frame.maxY, width: alert.width, height: 40))
        btn.setTitle("我知道了", for: .normal)
        btn.drawLine(types: [.top])
        btn.block = {
           PopView.disMiss()
        }
        btn.setTitleColor(UIColor.blue, for: .normal)
        alert.addSubview(btn)
        return alert
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
