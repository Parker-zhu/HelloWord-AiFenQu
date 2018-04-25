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
    case rest = "https://rest.ifenqu.com/"
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
        return Url.getEnvironment() + "account/v1/login-verify"
    }
    ///获取商品信息
    class func getShopInformation() -> String {
        return Url.getEnvironment() + "mall/v1/product"
    }
    ///获取商品关联素材
    class func getProductRelation() -> String {
        return Url.getEnvironment() + "product/v1/products/71/contents"
    }
    ///保存寄存地址
    class func getAddress() -> String {
        return Url.getEnvironment() + "v1/mall/address"
    }
    ///返回指定商品的优惠券信息
    class func getGoodCoupon() -> String {
        return Url.getEnvironment() + "v1/mall/goods_ticket/371"
    }
    ///下单
    class func getOrder() -> String {
        return Url.getEnvironment() + "v1/mall/order"
    }
    ///获取卡券
    class func getCards() -> String {
        return Url.getEnvironment() + "v1/cards"
    }
    ///获取订单列表
    class func getGoodsLiet() -> String {
        return Url.getEnvironment() + "personal/v1/order/list"
    }
    ///车险详情
    class func getCarInsuranceDetail() -> String {
        return Url.getEnvironment() + "personal/v1/order/790"
    }
    ///保单摘要
    class func getCarInsurance() -> String {
        return Url.getEnvironment() + "personal/v1/order/783/policy/831"
    }
    ///热销榜
    class func getHotProducts() -> String {
        return Url.getEnvironment() + "product/v1/products/hot_sale"
    }
    ///新品首发
    class func getNewProducts() -> String {
        return Url.getEnvironment() + "product/v1/products/new_product"
    }
}
