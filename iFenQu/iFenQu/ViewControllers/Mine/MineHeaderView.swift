//
//  MineHeaderView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/9.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class MineHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //背景Image
        let imageView = UIImageView.init(frame: self.bounds)
        imageView.image = UIImage.init(named: "")
        self.addSubview(imageView)
        //头像
        let headImage = UIImageView.init()
        headImage.image = UIImage.init(named: "timg (1)")
        self.addSubview(headImage)
        headImage.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.offset()(20)
            make?.bottom.equalTo()(self)?.offset()(-20)
            make?.width.equalTo()(40)
            make?.height.equalTo()(40)
        }
        //btn
        let btn = UIButton.init()
        self.addSubview(btn)
        btn.setTitle("登陆/注册", for: .normal)
        btn.mas_makeConstraints { (make) in
            make?.left.equalTo()(headImage)?.offset()(40)
            make?.bottom.equalTo()(self)?.offset()(-20)
            make?.width.equalTo()(btn.titleLabel!.getLableWidth(size: CGSize.init(width: SCREEN_Width, height: 40)) + 20)
            make?.height.equalTo()(40)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
