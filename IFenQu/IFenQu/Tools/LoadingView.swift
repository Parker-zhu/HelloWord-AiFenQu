//
//  LoadingView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/21.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = xlightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loading() {
        
    let shapelayer = CAShapeLayer.init()
        let radius:CGFloat = 40
    let lineWidth:CGFloat = 2
    shapelayer.frame = CGRect.init(x: 0, y: 0, width: radius * 2 + lineWidth, height: radius * 2 + lineWidth)
    
        let path = UIBezierPath.init(arcCenter: self.center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
    //路径
        shapelayer.path = path.cgPath
    //填充色
        shapelayer.fillColor = UIColor.clear.cgColor
    // 设置线的颜色
    shapelayer.strokeColor = UIColor.black.cgColor
    //线的宽度
    shapelayer.lineWidth = lineWidth
    self.layer.addSublayer(shapelayer)
    
    let anima = CABasicAnimation.init(keyPath: "strokeEnd")
        anima.fromValue = NSNumber.init(value: 0.0)
        anima.toValue = NSNumber.init(value: 1.0)
        anima.duration = 2.0
        anima.repeatCount = MAXFLOAT
//        anima.timingFunction = CAMediaTimingFunction.fun
//        anima.timingFunction = CAMediaTimingFunction.f
//            CAMediaTimingFunction.init(name: "kCAMediaTimingFunctionEaseInEaseOut")
        anima.autoreverses = true
        anima.isRemovedOnCompletion = false
        shapelayer.add(anima, forKey: "strokeEndAniamtion")
    
     let anima3 = CABasicAnimation.init(keyPath: "transform.rotation.z")
        anima3.toValue = NSNumber.init(value: M_PI*2)
        anima3.duration = 1.0
        anima3.repeatCount = MAXFLOAT
//        anima3.timingFunction= CAMediaTimingFunction.init(name: "kCAMediaTimingFunctionEaseInEaseOut")
        self.layer.add(anima3, forKey: "rotaionAniamtion")
    
    }

}
