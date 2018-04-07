//
//  TokenModel.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/2.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit
///手机号码+短信登陆成功返回模型数据
class TokenModel: NSObject {
    ///刷新令牌
    @objc var refreshToken: String?
    ///访问令牌过期时间
    @objc var accessTokenExpire: String?
    ///访问令牌
    @objc var accessToken: String?
    ///用户ID
    var userId: Int?
    ///刷新令牌过期时间
    @objc var refreshTokenExpire: String?
    
    
    class func initWithDict(dict:[String:Any]) -> TokenModel {
        let model = TokenModel()
        var count: UInt32 = 0
        //获取类的属性列表,返回属性列表的数组,可选项
        let list = class_copyIvarList(TokenModel.self, &count)
        
        //遍历数组
        for i in 0..<Int(count) {
            //根据下标获取属性
            let pty = list?[i]
            //获取属性的名称<C语言字符串>
            //转换过程:Int8 -> Byte -> Char -> C语言字符串
            let cName = ivar_getName(pty!)
            //转换成String的字符串
            let name = String(utf8String: cName!)
//            objc_setAssociatedObject(self, cName!, dict[name!], .OBJC_ASSOCIATION_RETAIN)
            if name == "userId" {
                model.userId = dict["userId"] as? Int
            } else {
            model.setValue(dict[name!], forKey: name!)
            }
        }
        free(list) //释放list
        return model
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
