//
//  LoadingView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/21.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class LoadingView: UIView,CAAnimationDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = xlightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let radius:CGFloat = 40
    
    func removeLayerAndAnim() {
        self.layer.removeAllAnimations()
        if self.layer.sublayers != nil {
            
            
            if self.layer.sublayers!.count > 0 {
                for l in self.layer.sublayers! {
                    if l is CAShapeLayer {
                        l.removeFromSuperlayer()
                    }
                }
            }
        }
    }
    func loading() {
        removeLayerAndAnim()
    let shapelayer = CAShapeLayer.init()
    
    let lineWidth:CGFloat = 2
        
    shapelayer.frame = CGRect.init(x: self.bounds.midX - radius, y: self.bounds.midX - radius, width: radius * 2 + lineWidth, height: radius * 2 + lineWidth)
    
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapelayer.bounds.midX, y: shapelayer.bounds.midY), radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
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
    var lineWidth:CGFloat = 6
    func error() {
        removeLayerAndAnim()
        markUp()
        markDown()
    }
    
    func markUp() {
        let slayer = CAShapeLayer.init()
        slayer.frame = self.bounds
        self.layer.addSublayer(slayer)
        
        let partLength: CGFloat = self.radius * 2 / 8
        let pathPartCount:CGFloat = 5
        let visualPathPartCount: CGFloat = 4
        
        let path = UIBezierPath.init()
        let originY = self.bounds.midX - self.radius
        let destY = originY + partLength * pathPartCount
        path.move(to: CGPoint.init(x: self.bounds.midX, y: originY))
        path.addLine(to: CGPoint.init(x: self.bounds.midX, y: destY))
        
        slayer.path = path.cgPath
        slayer.lineWidth = lineWidth
        slayer.strokeColor = UIColor.red.cgColor
        slayer.fillColor = nil
        
        let strokeStart:CGFloat = (pathPartCount - visualPathPartCount ) / pathPartCount
        let strokeEnd:CGFloat = 1.0
        slayer.strokeStart = strokeStart
        slayer.strokeEnd = strokeEnd
        
        let startAnimation = CABasicAnimation.init(keyPath: "strokeStart")
        startAnimation.fromValue = 0
        startAnimation.toValue = strokeStart
        
        let endAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        endAnimation.fromValue = 0
        endAnimation.toValue = strokeEnd
        
        let anima = CAAnimationGroup.init()
        anima.animations = [startAnimation, endAnimation]
        anima.duration = 0.6
        anima.delegate = self
        anima.setValue("needShake", forKey: "kALAnimationKey")
        slayer.add(anima, forKey: nil)
    }
    
    func markDown() {
        let slayer = CAShapeLayer.init()
        slayer.frame = self.bounds
        self.layer.addSublayer(slayer)
        
        let partLength:CGFloat = radius * 2 / 8
        let pathPartCount:CGFloat = 2
        let visualPathPartCount:CGFloat = 1
        
        let path = UIBezierPath.init()
        let originY = self.bounds.midX + self.radius
        let destY = originY - partLength * pathPartCount
        path.move(to: CGPoint.init(x: self.bounds.midX, y: originY))
        path.addLine(to: CGPoint.init(x: self.bounds.midX, y: destY))
        slayer.path = path.cgPath
        slayer.lineWidth = self.lineWidth
        slayer.strokeColor = UIColor.red.cgColor
        slayer.fillColor = nil
        
        let strokeStart:CGFloat = (pathPartCount - visualPathPartCount ) / pathPartCount
        let strokeEnd:CGFloat = 1.0
        slayer.strokeStart = strokeStart
        slayer.strokeEnd = strokeEnd
        
        let startAnimation = CABasicAnimation.init(keyPath: "strokeStart")
        startAnimation.fromValue = 0
        startAnimation.toValue = strokeStart
        
        let endAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        endAnimation.fromValue = 0
        endAnimation.toValue = strokeEnd
        
        let anima = CAAnimationGroup.init()
        anima.animations = [startAnimation, endAnimation]
        anima.duration = 0.6
        slayer.add(anima, forKey: nil)
    }
    func shake() {
     let anima = CABasicAnimation.init(keyPath: "transform.rotation.z")
    anima.fromValue = -M_PI / 12
    anima.toValue = M_PI / 12
    anima.duration = 0.1
    anima.autoreverses = true
    anima.repeatCount = 4
    self.layer.add(anima, forKey: nil)
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim.value(forKey: "kALAnimationKey") as! String == "needShake" {
        shake()
        }
    }
}
