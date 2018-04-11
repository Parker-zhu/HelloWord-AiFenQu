//
//  UIButton_extension
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

enum Position {
    case left,right
}

class XButton: UIButton {

    ///是否开启下划线
    var isShowBottomLine = false
    ///下划线颜色，默认浅灰色，前提开启下划线
    var bottomLineColor: UIColor = UIColor.lightGray
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if self.isShowBottomLine {
            let path = UIBezierPath.init()
            path.move(to: CGPoint.init(x: 0, y: rect.maxY))
            path.addLine(to: CGPoint.init(x: rect.maxX, y: rect.maxY))
            bottomLineColor.setStroke()
            path.lineWidth = 1
            path.stroke()

        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.isShowBottomLine {
        self.titleLabel?.frame = self.bounds
        self.titleLabel?.textAlignment = .left
        self.imageView?.x = self.width - self.imageView!.width
        }
    }

    ///
    private var timer: Timer?
    ///计时Btn类型，设置time时间就OK
    var time: Int? {
        didSet{
            if time == nil {
                timer?.invalidate()
                timer = nil
                self.isUserInteractionEnabled = true
                
            } else if timer == nil {
                timeCopy = time
                    self.isUserInteractionEnabled = false
                    timer = Timer.init(timeInterval: 1, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
                    timer?.fire()
                    RunLoop.main.add(timer!, forMode: .commonModes)
                
            }
        }
    }
    
    private var timeCopy: Int?
    
    @objc private func timeAction() {
        if timeCopy! >= 1 {
            
        let title = String.init(format:"%d s", arguments: [timeCopy!])
        timeCopy! -= 1
        self.setTitle(title, for: .normal)
        } else {
            time = nil
            self.isUserInteractionEnabled = true
            self.setTitle("重新请求", for: .normal)
        }
    }    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        self.time = nil
    }
    
}

typealias btnBlock = () -> Void
struct associatedBlockKey {
    static var key = "originalDataBlockKey"
}

extension UIButton {

    var block:btnBlock? {
        get{
            return objc_getAssociatedObject(self, &associatedBlockKey.key) as? btnBlock
        }
        set{
            objc_setAssociatedObject(self, &associatedBlockKey.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.removeTarget(self, action: #selector(btnClick), for: .touchUpInside)
            if block != nil {
                self.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            }
            
        }
    }
    
    @objc private func btnClick() {
        self.block!()
    }
    
    
    
    
}
