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
        self.backgroundColor = UIColor.white
    }
    
    class func show(text:String,btn1Text:String,btn1TextColor:UIColor,btn2Text:String?,btn2TextColor:UIColor?,btn2Block:@escaping ()->Void?) -> AlertView{
        let alert = AlertView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width/7*5, height: 140))
        alert.layer.cornerRadius = 5
        alert.layer.masksToBounds = true
        
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: alert.width, height: 100))
        lable.text = text
        lable.textAlignment = .center
        lable.textColor = UIColor.darkGray
        alert.addSubview(lable)
        
        var width = alert.width
        if btn2Text != nil {
            width = alert.width/2
            
            let btn2 = UIButton.init(frame: CGRect.init(x: width, y: lable.frame.maxY, width: width, height: 40))
            btn2.setTitle(btn2Text, for: .normal)
            btn2.drawLine(types: [.top])
            btn2.block = {
                btn2Block()
            }
            btn2.setTitleColor(btn2TextColor, for: .normal)
            alert.addSubview(btn2)
            
        }
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: lable.frame.maxY, width: width, height: 40))
        btn.setTitle(btn1Text, for: .normal)
        btn.drawLine(types: [.top])
        btn.block = {
           PopView.disMiss()
        }
        btn.setTitleColor(btn1TextColor, for: .normal)
        alert.addSubview(btn)
        PopView.show(view: alert)
        return alert
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
