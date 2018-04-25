//
//  CacheManager.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///缓存处理 -- 单例
/*
    缓存逻辑：
            加载的数据加入到缓存，同时在异步存储到本地
 从本地查找数据
 在AppDelegate的时候就初始化，异步读取本地数据，加载到缓存，如果缓存中找不到数据，再从本地找
 //字典数据中有空值，不能使用plist存储
*/
import UIKit

class CacheManager: NSObject {
    
    static let manager = CacheManager.init()
    
    var dataManger:DataManager!
    
    override init() {
        super.init()
        dataManger = DataManager()
    }
    
    ///读取数据
    class func readCache(key:String) -> [ShopModel] {
        let m = CacheManager.manager
        return m.dataManger.getDataFromTable(tableName: key)
    }
    
    
    ///存储数据
    class func storeCache(key:String,obj:[ShopModel]) {
        let m = CacheManager.manager
        m.dataManger.deleteFromTable(tableName: "shop")
        m.dataManger.createTable(tableName: "shop", arFields: ["productName","productId","url","totalPrice",""], arFieldsType: ["TEXT","INTEGER","TEXT","FLOAT"])
        var dicModels: [NSDictionary] = []
        for model in obj {
            dicModels.append(model.toDic() as NSDictionary)
        }
        m.dataManger.updateDataToTable(tableName: key, dicFields: dicModels)
    }
    
    var tokenModel: TokenModel?
    
    var userModel: UserModel?
    
    ///首页商品列表的数据模型，为了提供给’我的‘中使用数据
    var shopGoodModels: [ShopModel]?
}
