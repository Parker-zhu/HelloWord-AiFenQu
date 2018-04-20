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
 
*/
import UIKit

class CacheManager: NSObject {
    
    static let manager = CacheManager.init()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(removeAllObj), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
        self.loadDataFromLocal()
        
    }
    ///从本地加载数据到缓存，在AppDelegate中调用，异步加载
    private func loadDataFromLocal() {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func removeAllObj() {
        self.cache.removeAllObjects()
    }
    
    
    private lazy var cache: NSCache = {
        return NSCache<AnyObject, AnyObject>.init()
    }()
    
    
    class func readCache(key:String) -> [String:Any]? {
        let m = CacheManager.manager
        
        let obj = m.cache.object(forKey: key as AnyObject)
        //缓存中没有找到数据，从本地找,并且加载到缓存
        if obj == nil {
            let dic = NSDictionary.init(contentsOfFile: m.getCachePath(key: key))
            if dic != nil {
                DispatchQueue.global().async {
                    m.cache.setObject(dic!, forKey: key as AnyObject)
                }
                return dic as? [String : Any]
            } else {
                return nil
            }
        }
        return obj as? [String : Any]
    }
    private func getCachePath(key:String) -> String {
        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        path = path + "\(key).plist"
        return path
    }
    class func storeCache(key:String,obj:[String:Any]) {
        let m = CacheManager.manager
        
        m.cache.setObject(obj as AnyObject, forKey: key as AnyObject)
        //加入缓存中，同时异步存储本地
        DispatchQueue.global().async {
            (obj as NSDictionary).write(toFile: m.getCachePath(key: key), atomically: true)
            
        }
    }
    var tokenModel: TokenModel?
    var userModel: UserModel?
    
}
