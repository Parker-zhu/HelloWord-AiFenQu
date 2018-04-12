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
        let selfHeight = self.height - 15
        let selfWidth = self.width - 20
        
        let imageView = UIImageView.init(frame:CGRect.init(x: 0, y: 10, width: selfWidth, height: selfHeight/8*5 )
        )
        self.contentView.addSubview(imageView)
        imageView.image = UIImage.init(named: "59df2e7fN86c99a27.jpg!q70 (1)")
        imageView.contentMode = .center
        
        let lable1 = UILabel.init(frame: CGRect.init(x: 10, y: imageView.frame.maxY, width: selfWidth, height: selfHeight/16*3))
        lable1.text = "Apple X 国行4G智能手机智能手机"
        
        lable1.numberOfLines = 0
        lable1.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(lable1)
        
        let lable2 = UILabel.init(frame: CGRect.init(x: 10, y: lable1.frame.maxY, width: selfWidth, height: selfHeight/32*3))
        lable2.text = "总价 ¥8388.00起"
        lable2.font = UIFont.systemFont(ofSize: 10)
        lable2.textColor = UIColor.lightGray
        self.contentView.addSubview(lable2)
        
        let lable3 = UILabel.init(frame: CGRect.init(x: 10, y: lable2.frame.maxY, width: "12期".getTextSize(font: 12, size: CGSize.init(width: SCREEN_Width, height: selfHeight/32*3)).width, height: selfHeight/32*3 + 5))
        lable3.text = "12期"
        lable3.font = UIFont.systemFont(ofSize: 10)
        lable3.drawCircle(lineColor: UIColor.red, backColor: UIColor.clear)
        let lable4 = UILabel.init(frame: CGRect.init(x: lable3.frame.maxX + 5, y: lable2.frame.maxY, width: selfWidth, height: selfHeight/32*3))
        lable4.adjustSize(title: "¥ 566.00起", newFont: 12)
        lable4.textColor = UIColor.red
        var c = lable4.center
        c.x = lable3.center.x
        
        lable3.center = c
        self.contentView.addSubview(lable3)
        self.contentView.addSubview(lable4)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
