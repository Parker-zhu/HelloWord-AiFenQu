//
//  UITextField_extension.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

enum LinePosition {
    case left,right,top,bottom
}

class XTextField: UITextField {

    var linePosition: [LinePosition]? {
        didSet{
           self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        xlightGray.setStroke()
        if let lineP = linePosition {
            for p in lineP {
                switch p {
                case .bottom:
                    initUIBezierPath(startPoint: CGPoint.init(x: 0, y: rect.maxY-1), endPoint: CGPoint.init(x: rect.maxX, y: rect.maxY-1))
                case .right:
                    initUIBezierPath(startPoint: CGPoint.init(x: rect.maxX - 1, y: 0), endPoint: CGPoint.init(x: rect.maxX - 1, y: rect.maxY-1))
                case .left:
                    initUIBezierPath(startPoint: CGPoint.init(x: 0, y: 0), endPoint: CGPoint.init(x: 0, y: rect.maxY-1))
                case .top:
                    initUIBezierPath(startPoint: CGPoint.init(x: 0, y: 1), endPoint: CGPoint.init(x: rect.maxX, y: 1))
            }
        }
        }
    }
    
    
    /// 画线
    ///
    /// - Parameters:
    ///   - startPoint: 起点坐标
    ///   - endPoint: 终点坐标
    private func initUIBezierPath(startPoint:CGPoint,endPoint:CGPoint) {
        let line = UIBezierPath.init()
        line.move(to: startPoint)
        line.addLine(to: endPoint)
        line.lineWidth = 1
        line.stroke()
    }
}
