//
//  Tools.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/18.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///工具类---存放一些公用的方法

import UIKit

/// 测试方法执行时间
///
/// - Parameter function: 需要测试的方法

func getTime(function:()->()){
    let start=CACurrentMediaTime()
    function()
    let end=CACurrentMediaTime()
    print("方法耗时为：\(end-start)")
}
