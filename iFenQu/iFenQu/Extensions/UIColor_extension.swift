//
//  UIColor_extension.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/18.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class UIColor_extension: UIColor {
    
    func rgb(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
        return color
    }
}
