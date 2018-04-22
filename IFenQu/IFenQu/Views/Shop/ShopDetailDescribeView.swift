//
//  ShopDetailDescribeView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/22.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///商品详情底部描述视图
import UIKit

class ShopDetailDescribeView: UIView,UIScrollViewDelegate {

    var topView: UIView!
    var scrollView: UIScrollView!
    
    var lineView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 50))
        topView.backgroundColor = UIColor.white
        self.addSubview(topView)
        let btnName = ["产品详情","购前说明","常见问答"]
        lineView = UIView.init(frame: CGRect.init(x: 0, y: topView.frame.maxY - 2, width: btnName[0].getTextSize(font: 14).width, height: 2))
        lineView.backgroundColor = xyellow
        
        for i in 0..<3 {
            let btn = UIButton.init(frame: CGRect.init(x: SCREEN_Width/3*CGFloat(i), y: 20, width: SCREEN_Width/3, height: 30))
            btn.setTitle(btnName[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.darkGray, for: .normal)
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
            if i == 0 {
                self.btnAction(btn: btn)
            }
            topView.addSubview(btn)
        }
        
        topView.addSubview(lineView)
        
//        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: topView.frame.maxY + 2, width: SCREEN_Width, height: frame.height - 52))
//        scrollView.delegate = self
//        self.addSubview(scrollView)
    }
    @objc func btnAction(btn:UIButton) {
        let i = btn.tag - 1000
        for view in topView.subviews {
            if view is UIButton {
                let b = view as! UIButton
                if b.tag == i {
                    b.setTitleColor(xlightGray, for: .normal)
                } else {
                    b.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        UIView.animate(withDuration: 0.5) {
            let ly = self.lineView.y
            self.lineView.center = btn.center
            self.lineView.y = ly
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
