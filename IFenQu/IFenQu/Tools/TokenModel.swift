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
    var refreshToken: String = ""
    ///访问令牌过期时间
    var accessTokenExpire: String = ""
    ///访问令牌
    var accessToken: String = ""
    ///用户ID
    var userId: String = ""
    ///刷新令牌过期时间
    var refreshTokenExpire: String = ""
    
    
    class func initWithDic(dic:[String:Any]) -> TokenModel{
        let model = TokenModel()
        model.refreshToken = dic["refreshToken"] as! String
        model.accessTokenExpire = dic["accessTokenExpire"] as! String
        model.accessToken = dic["accessToken"] as! String
        model.refreshTokenExpire = dic["refreshTokenExpire"] as! String
        model.userId = dic["userId"] as! String
        return model
    }
    
}
