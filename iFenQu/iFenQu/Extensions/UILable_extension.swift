//
//  UILable_extension.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

extension UILabel {
    ///弃用
    /// 定制Lable
    ///
    /// - Parameters:
    ///   - text: <#text description#>
    ///   - textColor: <#textColor description#>
    ///   - textBackColor: <#textBackColor description#>
    ///   - textFont: <#textFont description#>
    ///   - lineColor: <#lineColor description#>
    ///   - lineType: <#lineType description#>
    ///   - priceText: <#priceText description#>
    ///   - priceColor: <#priceColor description#>
    ///   - isChangeSize: <#isChangeSize description#>
    ///   - priceFont: <#priceFont description#>
    func shopLable(text:String,textColor:UIColor,textBackColor:UIColor,textFont:CGFloat,lineColor:UIColor,lineType:TitleType,priceText:String?,priceColor:UIColor?,isChangeSize:Bool?,priceFont:CGFloat?) {
        
        let slayer = CAShapeLayer.init()
        let path = UIBezierPath.init()
        
        ///文本绘制区域
        let textRect = self.textRect(forBounds: self.bounds, limitedToNumberOfLines: 0)
        
        let textWidth = text.getTextSize(font:textFont, size: CGSize.init(width: SCREEN_Width, height: self.height)).width
        if lineType == .cicrl {
            path.move(to: CGPoint.init(x: textRect.origin.x, y: 0))
            path.addLine(to: CGPoint.init(x: textRect.maxX, y: 0))
            path.addArc(withCenter: CGPoint.init(x: textRect.maxX, y: self.height/2), radius: self.height/2, startAngle: CGFloat(-M_PI/2), endAngle: CGFloat(M_PI/2), clockwise: true)
            path.addLine(to: CGPoint.init(x: textRect.origin.x, y: self.height))
            path.addArc(withCenter: CGPoint.init(x: textRect.origin.x, y: self.height/2), radius: self.height/2, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(-M_PI/2), clockwise: true)
            slayer.fillColor = textBackColor.cgColor
            slayer.strokeColor = lineColor.cgColor
            slayer.lineWidth = 0.5
            slayer.path = path.cgPath
            self.layer.addSublayer(slayer)
        } else if lineType == .line {
            
            path.move(to: CGPoint.init(x: textRect.origin.x - 10, y: self.center.y))
            path.addLine(to: CGPoint.init(x:textRect.origin.x - 40, y: self.center.y))
            
            let slayer1 = CAShapeLayer.init()
            let path1 = UIBezierPath.init()

            path.move(to: CGPoint.init(x: textRect.maxX + 10, y: self.center.y))
            path.addLine(to: CGPoint.init(x: textRect.maxX + 40, y: self.center.y))

//            slayer1.fillColor = textBackColor.cgColor
            slayer1.strokeColor = UIColor.red.cgColor
            slayer1.lineWidth = 1
            slayer1.path = path1.cgPath
            self.layer.addSublayer(slayer1)
            
            slayer.fillColor = UIColor.clear.cgColor
            slayer.strokeColor = UIColor.red.cgColor
            slayer.lineWidth = 1
            slayer.path = path.cgPath
            self.layer.addSublayer(slayer)
            
        } else {
            //画箭头
            let l = CAShapeLayer.init()
            let x = textRect.maxX + self.height + 10
            let y = self.center.y
            let p = UIBezierPath.init(arcCenter: CGPoint.init(x: x, y: y), radius: self.height/2, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
            l.strokeColor = UIColor.red.cgColor
            l.lineWidth = 1
            l.path = p.cgPath
            l.fillColor = UIColor.clear.cgColor
            self.layer.addSublayer(l)
            
            let line = CAShapeLayer.init()
            let pa = UIBezierPath.init()
            pa.move(to: CGPoint.init(x: x - self.height/6, y: self.height/4))
            pa.addLine(to: CGPoint.init(x: self.height/4 + x, y: y))
            pa.addLine(to: CGPoint.init(x: x - self.height/6, y: self.height/4*3))
            line.fillColor = UIColor.clear.cgColor
            line.strokeColor = UIColor.darkGray.cgColor
            line.lineWidth = 1
            line.path = pa.cgPath
            self.layer.addSublayer(line)
        }
        
        var price = priceText
        if price == nil {
            price = ""
            
            
            
        }
        
        
        let attr = NSMutableAttributedString.init(string: text + price!)
        
        
        let a = NSMutableAttributedString.init(string: text)
//        let mParagraphStyle = NSMutableParagraphStyle.init()
////        mParagraphStyle.lineBreakMode = .byWordWrapping
//        mParagraphStyle.firstLineHeadIndent = self.height/4
//        attr.addAttribute(.paragraphStyle, value: mParagraphStyle, range: NSRange.init(location: 0, length: attr.length))
        
        attr.addAttribute(.kern, value: self.height/2 + 5, range: NSRange.init(location: a.length - 1, length: 1))
        //字体
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: textFont), range: NSRange.init(location: 0, length: a.length))
        ///背景色
        attr.addAttribute(.foregroundColor, value: textColor, range: NSRange.init(location: 0, length: a.length))
//        attr.addAttribute(.backgroundColor, value: textBackColor, range: NSRange.init(location: 0, length: a.length))
        if price != "" {
            let range = NSRange.init(location: a.length, length: attr.length - a.length)
            
            attr.addAttribute(.font, value: UIFont.systemFont(ofSize: priceFont!), range: range)
            attr.addAttribute(.foregroundColor, value: priceColor!, range: range)
        }
        if isChangeSize != nil && isChangeSize! && priceFont != nil{
            let r = ((text + price!) as NSString).range(of: ".")
            attr.addAttribute(.font, value: UIFont.systemFont(ofSize: priceFont!/3*2), range: NSRange.init(location: r.location, length: attr.length - r.location))
        }
        
        self.attributedText = attr
    }
    
    
    func drawCircle(lineColor:UIColor,backColor:UIColor,isDrawArrows:Bool = false) {
        if self.layer.sublayers == nil {
            return
        }
        for l in self.layer.sublayers! {
            if l is CAShapeLayer {
            return
            }
        }
        let slayer = CAShapeLayer.init()
        let path = UIBezierPath.init()
        let textRect = self.textRect(forBounds: self.bounds, limitedToNumberOfLines: 0)
        path.move(to: CGPoint.init(x: textRect.origin.x, y: 0))
        path.addLine(to: CGPoint.init(x: textRect.maxX, y: 0))
        path.addArc(withCenter: CGPoint.init(x: textRect.maxX, y: self.height/2), radius: self.height/2, startAngle: CGFloat(-M_PI/2), endAngle: CGFloat(M_PI/2), clockwise: true)
        path.addLine(to: CGPoint.init(x: textRect.origin.x, y: self.height))
        path.addArc(withCenter: CGPoint.init(x: textRect.origin.x, y: self.height/2), radius: self.height/2, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(-M_PI/2), clockwise: true)
        slayer.fillColor = backColor.cgColor
        slayer.strokeColor = lineColor.cgColor
        slayer.lineWidth = 0.5
        slayer.path = path.cgPath
        self.layer.sublayers?.insert(slayer, at: 0)
        
        
        if isDrawArrows {
            let imageView = UIImageView.init(frame: CGRect.init(x: textRect.maxX + 10, y: 0, width: self.height, height: self.height))
            imageView.image = UIImage.init(named: "path")
            imageView.contentMode = .center
            
            self.addSubview(imageView)
        }
    }
    func drawLine(lineColor:UIColor) {
        
        let textRect = self.textRect(forBounds: self.bounds, limitedToNumberOfLines: 0)
        let layer1 = drawLineWithPoint(startPoint: CGPoint.init(x: textRect.origin.x - 15, y: self.center.y), endPoint: CGPoint.init(x: textRect.origin.x - 45, y: self.center.y))
        layer1.strokeColor = lineColor.cgColor
        let layer2 = drawLineWithPoint(startPoint: CGPoint.init(x: textRect.maxX + 15, y: self.center.y), endPoint: CGPoint.init(x: textRect.maxX + 45, y: self.center.y))
        layer2.strokeColor = lineColor.cgColor
        self.layer.addSublayer(layer1)
        self.layer.addSublayer(layer2)
    }
    func drawLineWithPoint(startPoint:CGPoint,endPoint:CGPoint)  -> CAShapeLayer {
        let slayer = CAShapeLayer.init()
        let path = UIBezierPath.init()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        slayer.lineWidth = 0.5
        slayer.path = path.cgPath
        return slayer
    }
    
    func adjustSize(title:String,newFont:CGFloat) {
        let attr = NSMutableAttributedString.init(string: title)
        let r = (title as NSString).range(of: ".")
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: newFont/3*2), range: NSRange.init(location: r.location, length: attr.length - r.location))
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: newFont), range: NSRange.init(location: 0, length: r.location))
    
    
        self.attributedText = attr
    }
}





