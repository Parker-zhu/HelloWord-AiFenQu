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
    
    func shadeColor(starColor:UIColor = UIColor.init(red: 255/255.0, green: 195/255.0, blue: 0, alpha: 1),endColor:UIColor = UIColor.init(red: 1.0, green: 154/255.0, blue: 0, alpha: 1)){
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [starColor.cgColor,endColor.cgColor]
//        gradientLayer.locations = [NSNumber.init(value: 0.5)]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
    class func initFormNib() -> UIView {
        
        let classNameCopy = NSStringFromClass(self.classForCoder())
        let name = classNameCopy.components(separatedBy: ".").last
        let nibView = Bundle.main.loadNibNamed(name!, owner: self, options: nil)!.first
        return nibView as! UIView
    }
}

///图片文字排版位置
enum PositionType {
    case wl_il, il_wl, wl_c_ir, il_c_wr, wr_ir, ir_wr, wl_ir, wr_il
}
class IButton: UIView {
    lazy var titleLable = { () -> UILabel in
        let lable = UILabel.init(frame: CGRect.init(x: 3, y: 3, width: 0, height: self.height - 6))
        lable.textAlignment = .center
        self.addSubview(lable)
        return lable
    }()
    
    lazy var imageView = { () -> UIImageView in
        let image = UIImageView.init()
        image.frame = CGRect.init(x: 0, y: 3, width: (self.height - 6), height: self.height - 6)
        image.contentMode = .center
        self.addSubview(image)
        return image
    }()
    var targetBlock: (()->())?
    
    var positionType:PositionType? {
        didSet{
            let selfHeight = self.height - 6
            titleLable.width = titleLable.text!.getTextSizeB(font: titleLable.font, size: CGSize.init(width: 400, height: selfHeight)).width
            if self.width < titleLable.width + imageView.width {
                self.width = titleLable.width + imageView.width + 9
            }
            switch positionType! {
            case .il_c_wr:
                let ix = (self.width - 3 - imageView.width - titleLable.width)/2.0
                imageView.x = ix
                titleLable.x = imageView.frame.maxX + 3
            case .il_wl:
                
                imageView.x = 3
                titleLable.x = imageView.frame.maxX + 3
            case .ir_wr:
                imageView.x = self.width - imageView.width - 3
                titleLable.x = imageView.x - titleLable.width - 3
            case .wl_c_ir:
                let ix = (self.width - 3 - imageView.width - titleLable.width)/2.0
                titleLable.x = ix
                imageView.x = titleLable.frame.maxX + 3
                
            case .wr_ir:
                titleLable.x = self.width - titleLable.width - 3
                imageView.x = titleLable.x - imageView.width - 3
            case .wr_il:
                titleLable.x = self.width - titleLable.width - 3
                imageView.x = 3
            case .wl_ir:
                titleLable.x = 3
                imageView.x = self.width - imageView.width - 3
            case .wl_il:
                titleLable.x = 3
                imageView.x = titleLable.frame.maxX + 3
        }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(iButtonAction))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func iButtonAction() {
        if targetBlock != nil {
            targetBlock!()
        }
    }
}
