//
//  GoodModel.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/21.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class GoodModel: NSObject {
    
    var companyId: Int?
    var sysCompanyInfos: String?
    var productId: String?

    var venderAmount: Int?
    ///价格
    var amount: String?
    ///库存
    var stock: String?
    
    var officialPrice: Int?
    var productGoodsDetail: String?
    ///描述
    var describe: String?
    
    var status: Int?
    var cargoNumber: String?
    var createUserId: String?
    
    var productList: Int?
    var goodsPicUrl: String?
    var goodstStatus: String?
    
    var updateTime: Int?
    ///对应sys dictionary data 字典表中主键ID
    var detailType: String?
    ///商品ID
    var goodsId: String?
    
    var goodsDictDetailList: [String:Any]?
    ///商品名
    var goodsName: String?
    var createTime: String?
    
    var updateUserId: String?
    ///商品简介
    var goodsAbout: String?
}
