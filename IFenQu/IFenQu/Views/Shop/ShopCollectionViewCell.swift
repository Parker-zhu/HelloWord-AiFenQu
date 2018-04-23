//
//  ShopCollectionViewCell.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///首页展示商品信息的cell
import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        imageView = UIImageView.init(frame: CGRect.init(x: offSet, y: offSet, width: frame.width - offSet*2, height: (self.height - offSet*1.5)/8*5))
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        lable1 = UILabel.init(frame: CGRect.init(x: offSet, y: imageView.frame.maxY, width: frame.width - offSet*2, height: (frame.height - offSet*1.5)/16*3))
        lable1.numberOfLines = 0
        lable1.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(lable1)
        
        lable2 = UILabel.init(frame: CGRect.init(x: offSet, y: lable1.frame.maxY, width: self.width - offSet*2, height: (self.height - offSet*1.5)/32*3))
        lable2.numberOfLines = 0
        lable2.font = UIFont.systemFont(ofSize: 10)
        lable2.textColor = UIColor.lightGray
        self.addSubview(lable2)
        
        lable3 = UILabel.init(frame: CGRect.init(x: offSet, y: lable2.frame.maxY, width: 0, height: (self.height - offSet*1.5)/32*3))
        lable3.numberOfLines = 0
        lable3.font = UIFont.systemFont(ofSize: 10)
        lable3.textColor = UIColor.white
        lable3.textAlignment = .center
        lable3.backgroundColor = UIColor.red
        
        lable3.layer.cornerRadius = lable3.height/2
        lable3.layer.masksToBounds = true
        lable3.layer.borderWidth = 0.5
        lable3.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(lable3)
        
        lable4 = UILabel.init(frame: CGRect.init(x: 0, y: lable2.frame.maxY, width: 0, height: (frame.height - offSet*1.5)/32*3))
        lable4.numberOfLines = 0
        lable4.font = UIFont.systemFont(ofSize: 10)
        lable4.textColor = UIColor.red
        self.addSubview(lable4)
    }
    
    ///到边界的距离
    var offSet:CGFloat = 20
    
    var imageView: UIImageView!
    
    var lable1: UILabel!
    
    var lable2: UILabel!
    
    var lable3: UILabel!
    
    var lable4: UILabel!
    
    func setModel(model:Any?) {
        imageView.image = UIImage.init(named: "3C-187x140pt-iPad-Pro-10.5")
        if model != nil {
        lable1.text = "Apple X 国行4G智能手机智能手机"
        lable2.text = "总价 ¥8388.00起"
        lable3.text = "12期"
        
        let lable3Width = "12期".getTextSizeB(font: lable3.font).width
        lable3.width = lable3Width + 10
        
        lable4.adjustSize(title: "¥ 566.00起", newFont: 12)
        lable4.x = lable3.frame.maxX  + 5
        lable4.width = (lable4.text?.getTextSizeB(font: lable4.font).width)!
        imageView.height = (self.height - offSet*1.5)/8*5
        } else {
            imageView.height = self.height - offSet*1.5
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
