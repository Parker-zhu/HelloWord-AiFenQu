//
//  ProductModel.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/21.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///商品信息模型
import UIKit

class ProductModel: ModelManager {
    ///产品ID
    var productId: Int?
    var updateTime: String?
    var updateUserId: Int?
    
    ///1.车险，2.意外险
    var productType: Int?
    ///0.删除，1.已审核已上架，2.未审核，3.下架，4.过期
    var productStatus: Int?
    ///描述
    var describe: String?
    
    var orderColumn: String?
    ///产品名
    var productName: String?
    ///规格支付渠道
    var typeMap: [String:Any]?
    
    var categoryId: String?
    ///产品简介
    var productAbout: String?
    ///商品列表
    var goodsList: [GoodModel]?
    
    var catcreateTimeegoryId: String?
    var brandId: String?
    var createUserId: Int?
    
    ///所属公司ID
    var companyId: Int?
    var status: Int?
    
    
//    ///数组转模型数组
//    class func initWithArrToArr(arr: [[String : Any]]) -> [ProductModel] {
//        var shopArr = [ProductModel]()
//        
//        for dic in arr {
//            shopArr.append(ProductModel.initWithDic(dic: dic))
//        }
//        
//        return shopArr
//    }
//    
//    ///字典转模型
//    class func initWithDic(dic: [String : Any]) -> ProductModel {
//        let model = ProductModel.init()
//        
//        model.productId = dic["productId"] as? Int ?? -1
//        model.updateTime = dic["updateTime"] as? String ?? ""
//        model.updateUserId = dic["updateUserId"] as? Int ?? -1
//        
//        model.productType = dic["productType"] as? Int ?? -1
//        model.productStatus = dic["productStatus"] as? Int ?? -1
//        model.describe = dic["describe"] as? String ?? ""
//        
//        model.orderColumn = dic["orderColumn"] as? String ?? ""
//        model.productName = dic["productName"] as? String ?? ""
//        model.typeMap = dic["typeMap"] as? [String:Any] ?? ["":""]
//        
//        model.categoryId = dic["categoryId"] as? String ?? ""
//        model.productAbout = dic["productAbout"] as? String ?? ""
//        model.goodsList = dic["goodsList"] as? [[String:Any]] ?? []
//        
//        model.catcreateTimeegoryId = dic["catcreateTimeegoryId"] as? String ?? ""
//        model.brandId = dic["brandId"] as? String ?? ""
//        model.createUserId = dic["createUserId"] as? Int ?? -1
//        
//        model.companyId = dic["companyId"] as? Int ?? -1
//        model.status = dic["status"] as? Int ?? -1
//        
//        return model
//    }
    
    
}
