//
//  Sting_extension.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

extension String {

    ///判断是否是数字
    func isNum() -> Bool {
        let scan = Scanner.init(string: self)
        var val: Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    ///判断是否是手机号
    func isPhoneNum() -> Bool {
        
        let regex = "^[1][3-8]\\d{9}$"
        let pre = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return pre.evaluate(with:self)
    }
    
    ///获取文字长度或高度
    func getTextSize(font:CGFloat,size:CGSize) -> CGSize {
        let f = UIFont.systemFont(ofSize: font)
        return getTextSizeB(font: f, size: size)
    }
    ///获取文字长度或高度
    func getTextSizeB(font:UIFont,size:CGSize) -> CGSize {
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let s = (self as NSString).boundingRect(with: size, options: option, attributes: attributes, context: nil).size
        
        return s
    }
}
