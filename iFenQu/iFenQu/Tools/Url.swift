//
//  Url.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/15.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///存放网络地址

import UIKit

enum Environment: String {
    case dev = "https://dev-rest.ifenqu.com/account/"
    case sit = "https://sit-rest.ifenqu.com/account/"
    case rest = "https://rest.ifenqu.com/account/"
}

class Url {
    
    ///获取当前开发环境
    class func getEnvironment() -> String {
        return Environment.rest.rawValue
    }
    
    ///获取启动页地址
    class func getBootPage() -> String {
        return Url.getEnvironment() + "cms/v1/content/1"
    }
    
    ///产品列表接口
    class func getProducts() -> String{
        return Url.getEnvironment() + "product/v1/products"
    }
    ///登陆界面，登陆接口
    class func getLogin() -> String {
        return Url.getEnvironment() + "v1/login-verify"
    }
    
}
