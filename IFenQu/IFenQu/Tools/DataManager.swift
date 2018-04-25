//
//  DataManager.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/2.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///数据库

import UIKit
import FMDB

class DataManager: NSObject {
    
    func database() -> FMDatabase {
        //获取沙盒路径
        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        path = path + "/shop.sqlite"
        //传入路径，初始化数据库，若该路径没有对应的文件，则会创建此文件
        print("数据库user.sqlite 的路径===" + path)
        return FMDatabase.init(path:path)
    }
    //MARK: - 创建表格
    
    /// 创建表格
    ///
    /// - Parameters:
    ///   - tableName: 表名称
    ///   - arFields: 表字段
    ///   - arFieldsType: 表属性
    func createTable(tableName:String , arFields:NSArray, arFieldsType:NSArray){
        let db = database()
        if db.open() {
            var  sql = "CREATE TABLE IF NOT EXISTS " + tableName + "(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
            let arFieldsKey:[String] = arFields as! [String]
            let arFieldsType:[String] = arFieldsType as! [String]
            for i in 0..<arFieldsType.count {
                if i != arFieldsType.count - 1 {
                    sql = sql + arFieldsKey[i] + " " + arFieldsType[i] + ", "
                }else{
                    sql = sql + arFieldsKey[i] + " " + arFieldsType[i] + ")"
                }
            }
            do{
                try db.executeUpdate(sql, values: nil)
                print("数据库操作====" + tableName + "表创建成功！")
            }catch{
                print(db.lastErrorMessage())
            }
            
        }
        db.close()
        
    }
        
    //MARK: - 添加数据
    /// 插入数据
    ///
    /// - Parameters:
    ///   - tableName: 表名字
    ///   - dicFields: key为表字段，value为对应的字段值
    func updateDataToTable(tableName:String,dicFields:[NSDictionary]){
        let db = database()
        if db.open() {
            for dic in dicFields {
            let arFieldsKeys:[String] = dic.allKeys as! [String]
            let arFieldsValues:[Any] = dic.allValues
            var sqlUpdatefirst = "INSERT INTO '" + tableName + "' ("
            var sqlUpdateLast = " VALUES("
            for i in 0..<arFieldsKeys.count {
                if i != arFieldsKeys.count-1 {
                    sqlUpdatefirst = sqlUpdatefirst + arFieldsKeys[i] + ","
                    sqlUpdateLast = sqlUpdateLast + "?,"
                }else{
                    sqlUpdatefirst = sqlUpdatefirst + arFieldsKeys[i] + ")"
                    sqlUpdateLast = sqlUpdateLast + "?)"
                }
            }
            do{
                try db.executeUpdate(sqlUpdatefirst + sqlUpdateLast, values: arFieldsValues)
                
                print("数据库操作==== 添加数据成功！")
                
            }catch{
                print(db.lastErrorMessage())
            }
            }
            
        }
    }
    //MARK: - 查询数据
    /// 查询数据
    ///
    /// - Parameters:
    ///   - tableName: 表名称
    ///   - arFieldsKey: 要查询获取的表字段
    /// - Returns: 返回相应数据
    func getDataFromTable(tableName:String)->([ShopModel]){
        let db = database()
        var dicModel: [ShopModel] = []
        
        let sql = "SELECT * FROM " + tableName
        if db.open() {
            do{
                let rs = try db.executeQuery(sql, values: nil)
                while rs.next() {
                    let dic: [String:Any?] = ["productName":rs.string(forColumn: "productName"),"productId":rs.long(forColumn: "productId"),"url":rs.string(forColumn: "url"),"totalPrice":rs.double(forColumn: "totalPrice")]
                    
                    dicModel.append(ShopModel.initWithDic(dic: dic ))
                }
            }catch{
                print(db.lastErrorMessage())
            }
            
        }
        return dicModel
    }
    //MARK: - 删除数据
    /// 删除数据
    ///
    /// - Parameters:
    ///   - tableName: 表名称
    ///   - FieldKey: 过滤的表字段
    ///   - FieldValue: 过滤表字段对应的值
    func deleteFromTable(tableName:String) {
        let db = database()
        
        if db.open() {
            let  sql = "DROP TABLE " + tableName
            if db.executeStatements(sql) {
                print("删除成功")
            } else {
                print(db.lastErrorMessage())
            }
        }
        
    }
        
}
