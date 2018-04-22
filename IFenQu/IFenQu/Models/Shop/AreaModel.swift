//
//  AreaModel.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/23.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///存放地址模型
import UIKit
import HandyJSON
class AreaModel: HandyJSON {

    required init(){}
    
    var code: String?
    var name: String?
    var sub: [AreaModel]?
    
    
    
}
