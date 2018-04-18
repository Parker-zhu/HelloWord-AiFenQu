//
//  PopView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/10.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///弹出框

import UIKit

class PopView: NSObject {

    static let share = PopView.init()

    ///点击背景是否miss
    var isHiddenWhenTouch = false
    private var didHiddenBlock: (()->())?
    
    
    lazy private var contentView: UIView = {
        let view = UIView.init(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        view.isUserInteractionEnabled = true
        if isHiddenWhenTouch {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(miss))
        view.addGestureRecognizer(tap)
        }
        return view
    }()
    
    class func show(view:UIView) {
        PopView.show(view: view, didHidden: nil)
        
    }
    ///block,弹出框消失的回调
    class func show(view:UIView,didHidden:(()->())?) {
        
        let window = UIApplication.shared.keyWindow
        window?.addSubview(PopView.share.contentView)
        view.center = window!.center
        PopView.share.contentView.addSubview(view)
        PopView.share.didHiddenBlock = didHidden
    }
    
    class func disMiss(){
        PopView.share.miss()
    }
    @objc private func miss() {
        if self.contentView.subviews.count > 0 {
            self.contentView.subviews.last?.removeFromSuperview()
        }
        if didHiddenBlock != nil {
            didHiddenBlock!()
        }
        self.contentView.removeFromSuperview()
    }
    class func show(view:UIView,isAnmation:Bool) {
        view.backgroundColor = UIColor.white
        view.frame = CGRect.init(x: 0, y: SCREEN_Height - view.height, width: view.width, height: view.height)
        let window = UIApplication.shared.keyWindow
        
        PopView.share.isHiddenWhenTouch = true
        window?.addSubview(PopView.share.contentView)
        PopView.share.contentView.addSubview(view)
        view.y = SCREEN_Height
        UIView.animate(withDuration: 1) {
            view.y = SCREEN_Height - view.height
        }
        
    }
    
}
