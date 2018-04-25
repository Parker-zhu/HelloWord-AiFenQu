//
//  ShopModel.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/21.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///商品模型
import UIKit

class ShopModel: ModelManager {
    
    /// 产品缩略图
    var productName: String = ""
    /// 分期数-没有存数据库
    var terms: [Int] = []
    ///产品ID
    var productId: Int = -1
    ///产品图片地址
    var url: String = "url"
    ///产品价格
    var totalPrice: Float = 0.0

    
    ///数组转模型数组
    class func initWithArrToArr(arr: [[String : Any]]) -> [ShopModel] {
        var shopArr = [ShopModel]()

        for dic in arr {
            shopArr.append(ShopModel.initWithDic(dic: dic))
        }

        return shopArr
    }

    ///字典转模型
    class func initWithDic(dic: [String : Any?]) -> ShopModel {
        let model = ShopModel.init()

        model.productName = dic["productName"] as? String ?? ""
        model.terms = dic["terms"] as? [Int] ?? []
        model.productId = dic["productId"] as? Int ?? 0
        model.url = dic["url"] as? String ?? "url"
        model.totalPrice = Float(dic["totalPrice"] as? Double ?? 0.0)

        return model
    }
    ///模型转字典
    func toDic() -> NSMutableDictionary {
        let dic: NSMutableDictionary! = NSMutableDictionary.init()
        dic.setValue(productName, forKey: "productName")
        dic.setValue(productId, forKey: "productId")
        dic.setValue(url, forKey: "url")
        dic.setValue(totalPrice, forKey: "totalPrice")

        
        return dic
    }
    
}
