//
//  UITextView_extension.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/18.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

extension UITextView {
    
    
}

class XTextView: UITextView {
    ///占位符
    var placeholderLable: UILabel?{
        didSet{
            placeholderLable?.numberOfLines = 0
            placeholderLable?.frame = CGRect.init(x: 5, y: 0, width: self.width, height: 30)
            placeholderLable?.font = self.font
            self.addSubview(placeholderLable!)
            NotificationCenter.default.addObserver(self, selector: #selector(updatePlaceholder), name: .UITextViewTextDidChange, object: nil)
        }
    }
    
    ///更新Placeholder显示
    @objc private func updatePlaceholder() {
        if self.text.count > 0 {
            placeholderLable?.removeFromSuperview()
            
        } else {
            self.addSubview(placeholderLable!)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UITextViewTextDidChange, object: nil)
    }
}
