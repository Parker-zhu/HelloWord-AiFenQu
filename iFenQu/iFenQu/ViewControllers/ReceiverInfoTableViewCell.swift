//
//  ReceiverInfoTableViewCell.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/18.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

enum ReceiverActionType {
    case defaultAddress,delete,edit
}

class ReceiverInfoTableViewCell: UITableViewCell {
    ///姓名
    @IBOutlet weak var nameLable: UILabel!
    
    /// 电话
    @IBOutlet weak var phoneLable: UILabel!
    
    /// 地址信息
    @IBOutlet weak var addressLable: UILabel!
    
    /// 设为默认地址
    @IBOutlet weak var defaultAddressBtn: XButton!
    
    /// 编辑
    @IBOutlet weak var editBtn: XButton!
    
    /// 删除
    @IBOutlet weak var deleteBtn: XButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    ///配置信息模型数据
    func setModel() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
