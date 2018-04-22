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
    func getTextSize(font:CGFloat,size:CGSize = CGSize.init(width: SCREEN_Width, height: SCREEN_Height)) -> CGSize {
        let f = UIFont.systemFont(ofSize: font)
        return getTextSizeB(font: f, size: size)
    }
    ///获取文字长度或高度
    func getTextSizeB(font:UIFont,size:CGSize = CGSize.init(width: SCREEN_Width, height: SCREEN_Height)) -> CGSize {
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let s = (self as NSString).boundingRect(with: size, options: option, attributes: attributes, context: nil).size
        
        return s
    }
    
    ///字符串转数据
    func int() -> Int{
        return (self as NSString).integerValue
    }
    func float() -> Float {
        return (self as NSString).floatValue
    }
   
    ///保留小数
    ///
    /// - Parameter count: 保留几位小数
    /// - Returns: 处理好的
    func getDecimals(count:Int = 2,isNeedcomma:Bool = true) -> String {
        var newS = ""
        var havePoint = false
        var num = count
        for c in self.characters {
            if havePoint {
                num -= 1
                if num < 0 {
                    break
                }
            }
            if c == "." {
            havePoint = true
            }
            newS.append(c)
        }
        if !havePoint || num > 0 {
            if !havePoint {
            newS.append(".")
            }
            for _ in 0..<num {
                newS.append("0")
            }
        }
        
        return newS
    }
}
