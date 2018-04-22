//
//  ProductTypeItemCellCell.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/13.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class ProductTypeItemCellCell: UICollectionViewCell {
    var textLable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLable = UILabel.init(frame: frame)
        textLable.layer.borderColor = UIColor.lightGray.cgColor
        textLable.layer.borderWidth = 1
        textLable.layer.cornerRadius = 2
        textLable.layer.masksToBounds = true
        textLable.font = UIFont.systemFont(ofSize: 11)
        textLable.textColor = UIColor.black
        self.contentView.addSubview(textLable)
    }
    func setModel(title: String) {
        textLable.text = title
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
