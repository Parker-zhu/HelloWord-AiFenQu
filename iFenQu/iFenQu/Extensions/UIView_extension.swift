//
//  UIView_extension.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/17.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit
///画线，四边
enum DrawLine {
    case left,right,bottom,top
}
extension UIView {
    
    var width: CGFloat {
        get{
           return self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    func drawLine(types:[DrawLine]) {
        var arr = [(DrawLine,UIColor)]()
        for t in types {
            let l = (t,xlightGray)
            arr.append(l)
        }
        drawLine(types: arr)
    }
    
    
    func drawLine(types:[(t:DrawLine,c:UIColor)]) {
        for type in types {
            switch type.t {
            case .bottom:
                let slayer = CAShapeLayer.init()
                let path = UIBezierPath.init()
                path.move(to: CGPoint.init(x: 0, y: self.height))
                path.addLine(to: CGPoint.init(x: self.width, y: self.height))
                slayer.path = path.cgPath
                slayer.lineWidth = 1
                slayer.strokeColor = type.c.cgColor
                self.layer.addSublayer(slayer)
            case .top:
                let slayer = CAShapeLayer.init()
                let path = UIBezierPath.init()
                path.move(to: CGPoint.init(x: 0, y: 0))
                path.addLine(to: CGPoint.init(x: self.width, y: 0))
                slayer.path = path.cgPath
                slayer.lineWidth = 1
                slayer.strokeColor = type.c.cgColor
                self.layer.addSublayer(slayer)
            case .left:
                let slayer = CAShapeLayer.init()
                let path = UIBezierPath.init()
                path.move(to: CGPoint.init(x: 0, y: 0))
                path.addLine(to: CGPoint.init(x: 0, y: self.height))
                slayer.path = path.cgPath
                slayer.lineWidth = 1
                slayer.strokeColor = type.c.cgColor
                self.layer.addSublayer(slayer)
            case .right:
                let slayer = CAShapeLayer.init()
                let path = UIBezierPath.init()
                path.move(to: CGPoint.init(x: self.width, y: 0))
                path.addLine(to: CGPoint.init(x: self.width, y: self.height))
                slayer.path = path.cgPath
                slayer.lineWidth = 1
                slayer.strokeColor = type.c.cgColor
                self.layer.addSublayer(slayer)
                
            }
        }
    }
    ///渐变色
    func shadeColor(starColor:UIColor,endColor:UIColor){
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [starColor.cgColor,endColor.cgColor]
//        gradientLayer.locations = [NSNumber.init(value: 0.5)]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
}
