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
    }
    
    var offSet:CGFloat = 20
    
    lazy var imageView = { () -> UIImageView in
        
        let view = UIImageView.init(frame: CGRect.init(x: offSet, y: offSet, width: self.width - offSet*2, height: self.height - offSet*2))
        view.contentMode = .center
        
        self.addSubview(view)
        return view
    }()
    lazy var lable1 = { () -> UILabel in
        
        let view = UILabel.init(frame: CGRect.init(x: offSet, y: offSet + (self.height - offSet*2)/8*5, width: self.width - offSet*2, height: (self.height - offSet*2)/16*3))
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(view)
        return view
    }()
    lazy var lable2 = { () -> UILabel in
        
        let view = UILabel.init(frame: CGRect.init(x: offSet, y: lable1.frame.maxY, width: self.width - offSet*2, height: (self.height - offSet*2)/32*3))
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = UIColor.lightGray
        self.addSubview(view)
        return view
    }()
    lazy var lable3 = { () -> UILabel in
        
        let view = UILabel.init(frame: CGRect.init(x: offSet, y: lable2.frame.maxY, width: self.width - offSet*2, height: (self.height - offSet*2)/32*3))
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = UIColor.lightGray
        self.addSubview(view)
        return view
    }()
    lazy var lable4 = { () -> UILabel in
        
        let view = UILabel.init(frame: CGRect.init(x: lable3.frame.maxX + 5, y: lable2.frame.maxY, width: self.width - offSet*2, height: (self.height - offSet*2)/32*3))
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = UIColor.lightGray
        self.addSubview(view)
        return view
    }()
    
    func setModel(model:Any?) {
        imageView.image = UIImage.init(named: "59df2e7fN86c99a27.jpg!q70 (1)")
        if model != nil {
        lable1.text = "Apple X 国行4G智能手机智能手机"
        lable2.text = "总价 ¥8388.00起"
        lable3.text = "12期"
        lable3.drawCircle(lineColor: UIColor.red, backColor: UIColor.clear)
        lable3.width = lable3.text!.getTextSize(font: 10, size: CGSize.init(width: 300, height: lable3.height)).width
        lable4.adjustSize(title: "¥ 566.00起", newFont: 12)
        lable4.x = lable3.frame.maxX + 5
        
            imageView.height = (self.height - offSet*2)/8*5
        }

//        if self.subviews.count > 2 {
//            imageView.height = (self.height - offSet*2)/8*5
//        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
