//
//  UILable_extension.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

enum LineType {
    case line,circle
}

extension UILabel {
    func getLableWidth(size:CGSize) -> CGFloat {
        let attributes = [NSAttributedStringKey.font: self.font ?? UIFont.systemFont(ofSize: 14)]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let s = (self.text! as NSString).boundingRect(with: size, options: option, attributes: attributes, context: nil).width
        
        return s
    }
    
    func agingLable(agingText:String,priceText:String) {
        let slayer = CAShapeLayer.init()
        let path = UIBezierPath.init()
        
        path.lineWidth = 1
        path.move(to: CGPoint.init(x: self.height/2, y: 0))
        path.addLine(to: CGPoint.init(x: self.height / 2 + agingText.getTextWidth(font: UIFont.systemFont(ofSize: 12), size: CGSize.init(width: 375, height: self.height)), y: 0))
        path.addArc(withCenter: CGPoint.init(x: self.height/2 + agingText.getTextWidth(font: UIFont.systemFont(ofSize: 12), size: CGSize.init(width: 375, height: self.height)), y: self.height/2), radius: self.height/2, startAngle: CGFloat(-M_PI/2), endAngle: CGFloat(M_PI/2), clockwise: true)
        
        path.addLine(to: CGPoint.init(x: self.height/2, y: self.height))
        path.addArc(withCenter: CGPoint.init(x: self.height/2, y: self.height/2), radius: self.height/2, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(-M_PI/2), clockwise: true)
        slayer.fillColor = UIColor.clear.cgColor
        slayer.strokeColor = UIColor.red.cgColor
        slayer.lineWidth = 1
        slayer.path = path.cgPath
        self.layer.addSublayer(slayer)
        
        let attr = NSMutableAttributedString.init(string: agingText + priceText)
        

        let mParagraphStyle = NSMutableParagraphStyle.init()
        mParagraphStyle.lineBreakMode = .byWordWrapping
        
        mParagraphStyle.firstLineHeadIndent = self.height/2
        attr.addAttribute(.paragraphStyle, value: mParagraphStyle, range: NSRange.init(location: 0, length: attr.length))
        let a = NSMutableAttributedString.init(string: agingText)
        attr.addAttribute(.kern, value: self.height/2 + 5, range: NSRange.init(location: a.length - 1, length: 1))
        attr.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange.init(location: 0, length: a.length))
        self.attributedText = attr
    }
    func agingLable(agingText:String,agingTextColor:UIColor,agingTextFont:UIFont,agingTextBackColor:UIColor,priceText:String,priceTextColor:UIColor,priceTextFont:UIFont,lineColor:UIColor) {
        let slayer = CAShapeLayer.init()
        let path = UIBezierPath.init()
        
        path.lineWidth = 1
        path.move(to: CGPoint.init(x: self.height/2, y: 0))
        path.addLine(to: CGPoint.init(x: self.height / 2 + agingText.getTextWidth(font: UIFont.systemFont(ofSize: 12), size: CGSize.init(width: 375, height: self.height)), y: 0))
        path.addArc(withCenter: CGPoint.init(x: self.height/2 + agingText.getTextWidth(font: UIFont.systemFont(ofSize: 12), size: CGSize.init(width: 375, height: self.height)), y: self.height/2), radius: self.height/2, startAngle: CGFloat(-M_PI/2), endAngle: CGFloat(M_PI/2), clockwise: true)
        
        path.addLine(to: CGPoint.init(x: self.height/2, y: self.height))
        path.addArc(withCenter: CGPoint.init(x: self.height/2, y: self.height/2), radius: self.height/2, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(-M_PI/2), clockwise: true)
        slayer.fillColor = agingTextBackColor.cgColor
        slayer.strokeColor = lineColor.cgColor
        slayer.lineWidth = 1
        slayer.path = path.cgPath
        self.layer.addSublayer(slayer)
        
        let attr = NSMutableAttributedString.init(string: agingText + priceText)
        
        
        let mParagraphStyle = NSMutableParagraphStyle.init()
        mParagraphStyle.lineBreakMode = .byWordWrapping
        
        mParagraphStyle.firstLineHeadIndent = self.height/2
        attr.addAttribute(.paragraphStyle, value: mParagraphStyle, range: NSRange.init(location: 0, length: attr.length))
        let a = NSMutableAttributedString.init(string: agingText)
        attr.addAttribute(.kern, value: self.height/2 + 5, range: NSRange.init(location: a.length - 1, length: 1))
        attr.addAttribute(.font, value: agingTextFont, range: NSRange.init(location: 0, length: a.length))
        attr.addAttribute(.foregroundColor, value: agingTextColor, range: NSRange.init(location: 0, length: a.length))
        self.attributedText = attr
    }
    

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
    func shopLable(text:String,textColor:UIColor,textBackColor:UIColor,textFont:CGFloat,lineColor:UIColor,lineType:LineType,priceText:String?,priceColor:UIColor?,isChangeSize:Bool?,priceFont:CGFloat?) {
        
        let slayer = CAShapeLayer.init()
        let path = UIBezierPath.init()
        let textWidth = text.getTextWidth(font: UIFont.systemFont(ofSize: textFont), size: CGSize.init(width: 375, height: self.height))
        if lineType == .circle {
            path.move(to: CGPoint.init(x: self.height/2, y: 0))
            path.addLine(to: CGPoint.init(x: textWidth, y: 0))
            path.addArc(withCenter: CGPoint.init(x: textWidth, y: self.height/2), radius: self.height/2, startAngle: CGFloat(-M_PI/2), endAngle: CGFloat(M_PI/2), clockwise: true)
            path.addLine(to: CGPoint.init(x: self.height/2, y: self.height))
            path.addArc(withCenter: CGPoint.init(x: self.height/2, y: self.height/2), radius: self.height/2, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(-M_PI/2), clockwise: true)
            slayer.fillColor = textBackColor.cgColor
            slayer.strokeColor = lineColor.cgColor
            slayer.lineWidth = 1
            slayer.path = path.cgPath
            self.layer.addSublayer(slayer)
        } else{
            
            path.move(to: CGPoint.init(x: 0, y: self.center.y))
            path.addLine(to: CGPoint.init(x:-30, y: self.center.y))
            
            let slayer1 = CAShapeLayer.init()
            let path1 = UIBezierPath.init()

            path.move(to: CGPoint.init(x: textWidth + 10, y: self.center.y))
            path.addLine(to: CGPoint.init(x: textWidth + 40, y: self.center.y))

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
            
        }
        
        var price = priceText
        if price == nil {
            price = ""
            //画箭头
            let l = CAShapeLayer.init()
            let x = textWidth + self.height
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
        
        
        let attr = NSMutableAttributedString.init(string: text + price!)
        
        
        let mParagraphStyle = NSMutableParagraphStyle.init()
        mParagraphStyle.lineBreakMode = .byWordWrapping
        
        mParagraphStyle.firstLineHeadIndent = self.height/4
        attr.addAttribute(.paragraphStyle, value: mParagraphStyle, range: NSRange.init(location: 0, length: attr.length))
        let a = NSMutableAttributedString.init(string: text)
        //缩进
        attr.addAttribute(.kern, value: self.height/2 + 5, range: NSRange.init(location: a.length - 1, length: 1))
        //字体
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: textFont), range: NSRange.init(location: 0, length: a.length))
        ///背景色
        attr.addAttribute(.foregroundColor, value: textColor, range: NSRange.init(location: 0, length: a.length))
        attr.addAttribute(.backgroundColor, value: textBackColor, range: NSRange.init(location: 0, length: a.length))
        if price != "" {
            let range = NSRange.init(location: a.length - 1, length: attr.length - a.length + 1)
            
            attr.addAttribute(.font, value: UIFont.systemFont(ofSize: priceFont!), range: range)
            attr.addAttribute(.foregroundColor, value: priceColor!, range: range)
        }
        
        self.attributedText = attr
    }
}


