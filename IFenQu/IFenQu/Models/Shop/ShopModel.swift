//
//  ShopModel.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/21.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///商品模型
import UIKit
import HandyJSON
class ShopModel: HandyJSON {
    /// 产品缩略图
    var productName: String?
    /// 分期数
    var terms: [Int]?
    ///产品ID
    var productId: Int?
    ///产品图片地址
    var url: String?
    ///产品价格
    var totalPrice: Float?

    
    ///数组转模型数组
    class func initWithArrToArr(arr: [[String : Any]]) -> [ShopModel] {
        var shopArr = [ShopModel]()
        
        for dic in arr {
            shopArr.append(ShopModel.initWithDic(dic: dic))
        }
        
        return shopArr
    }
    
    ///字典转模型
    class func initWithDic(dic: [String : Any]) -> ShopModel {
        let model = ShopModel.init()
        
        model.productName = dic["productName"] as? String ?? ""
        model.terms = dic["terms"] as? [Int] ?? []
        model.productId = dic["productId"] as? Int ?? 0
        model.url = dic["url"] as? String ?? ""
        model.totalPrice = dic["totalPrice"] as? Float ?? 0.0
        
        return model
    }
    required init() {
        
    }
}
