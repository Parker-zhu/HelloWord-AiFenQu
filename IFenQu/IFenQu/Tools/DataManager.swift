//
//  DataManager.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/2.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///管理数据

import UIKit

class DataManager: NSObject {
    static let manager = DataManager.init()
    
    var token: TokenModel?
    
}
