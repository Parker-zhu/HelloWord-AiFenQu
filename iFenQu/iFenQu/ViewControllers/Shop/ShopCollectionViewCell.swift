//
//  ShopCollectionViewCell.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView.init(frame:CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height/8*5)
        )
        self.contentView.addSubview(imageView)
        imageView.image = UIImage.init(named: "59df2e7fN86c99a27.jpg!q70 (1)")
        imageView.contentMode = .scaleAspectFit
        
        let lable1 = UILabel.init(frame: CGRect.init(x: 10, y: imageView.frame.maxY, width: frame.width - 20, height: frame.height/16*3))
        lable1.text = "Apple X 国行4G智能手机智能手机"
        
        lable1.numberOfLines = 0
        lable1.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(lable1)
        
        let lable2 = UILabel.init(frame: CGRect.init(x: 10, y: lable1.frame.maxY, width: frame.width - 20, height: frame.height/32*3))
        lable2.text = "总价 ¥8388.00起"
        lable2.font = UIFont.systemFont(ofSize: 10)
        lable2.textColor = UIColor.lightGray
        self.contentView.addSubview(lable2)
        
        let lable3 = UILabel.init(frame: CGRect.init(x: 10, y: lable2.frame.maxY, width: frame.width - 20, height: frame.height/32*3))
        
        lable3.shopLable(text: "12期", textColor: UIColor.red, textBackColor: UIColor.white, textFont: 10, lineColor: UIColor.red, lineType: .circle, priceText: "¥ 566.00起", priceColor: UIColor.red, isChangeSize: true, priceFont: 12)
        self.contentView.addSubview(lable3)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
