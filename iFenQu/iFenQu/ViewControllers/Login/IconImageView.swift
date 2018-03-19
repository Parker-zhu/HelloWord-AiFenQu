//
//  IconImageView.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/18.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class IconImageView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        ///绘制6变形
        
        let line = UIBezierPath.init()
        line.move(to: CGPoint.init(x: self.width/3, y: 0))
        line.addLine(to: CGPoint.init(x: self.width/3*2, y: 0))
        line.addLine(to: CGPoint.init(x: self.width, y: self.height/3))
        line.addLine(to: CGPoint.init(x: self.width, y: self.height/3*2))
        line.addLine(to: CGPoint.init(x: self.width/3*2, y: self.height))
        line.addLine(to: CGPoint.init(x: self.width/3, y: self.height))
        line.addLine(to: CGPoint.init(x: 0, y: self.height/3*2))
        line.addLine(to: CGPoint.init(x: 0, y: self.height/3))
        line.close()
        xyellow.setFill()
        line.fill()
        
    }
    
    ///
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.setNeedsDisplay()
        let imageView = UIImageView.init(frame: frame)
        self.addSubview(imageView)
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor.clear
        imageView.image = UIImage.init(named: "iconImage")
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
