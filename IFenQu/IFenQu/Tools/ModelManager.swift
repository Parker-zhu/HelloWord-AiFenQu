//
//  ModelManager.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/2.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit
import MJExtension
///模型解析
extension NSObject {
    ///字典转模型
    class func dicToModel(dic:Any) -> NSObject {
        
        return self.mj_object(withKeyValues: dic)
    }
}
