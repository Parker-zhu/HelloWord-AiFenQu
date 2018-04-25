//
//  MessageTableViewCell.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/10.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    ///传递模型数据
    func setModel(model:Any?) {
        
    }
    
}
