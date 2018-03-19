//
//  Hud.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
//加载提示

import UIKit
import MBProgressHUD

class Hud {

    private static let shared = Hud()
    private var hud: MBProgressHUD?
    
    class func show() {
        Hud.dismiss()
        Hud.shared.hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    }
    
    class func dismiss() {
        Hud.shared.hud?.hide(animated: true)
    }
    
    class func showError(text:String?) {
        

        Hud.dismiss()
        let h = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        h.mode = .text
        h.label.text = text
        h.label.numberOfLines = 0
        h.hide(animated: true, afterDelay: 2)
    }
    
    
}
