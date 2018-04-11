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
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.mas_makeConstraints { (make) in
            make?.left.equalTo()(headImage)?.offset()(40)
            make?.bottom.equalTo()(self)?.offset()(-20)
            make?.width.equalTo()(btn.titleLabel!.getLableWidth(size: CGSize.init(width: SCREEN_Width, height: 40)) + 20)
            make?.height.equalTo()(40)
        }
        weak var weakSelf = self
        btn.block = {
            weakSelf?.findVc(vc: self)?.navigationController?.present(LoginViewController(), animated: true, completion: nil)
        }
        
        let quit = UIButton.init()
        self.addSubview(quit)
        quit.setImage(UIImage.init(named: "Group 618"), for: .normal)
        quit.mas_makeConstraints { (make) in
            make?.right.equalTo()(self)?.offset()(-20)
            make?.top.equalTo()(self)?.offset()(40)
            make?.width.equalTo()(40)
            make?.height.equalTo()(40)
        }
        
        let q = UIButton.init()
        self.addSubview(q)
        q.setImage(UIImage.init(named: "Group 618"), for: .normal)
        q.mas_makeConstraints { (make) in
            make?.right.equalTo()(quit)?.offset()(-60)
            make?.top.equalTo()(self)?.offset()(40)
            make?.width.equalTo()(40)
            make?.height.equalTo()(40)
        }
        
        
    }
    func findVc(vc:UIView) -> UIViewController? {
        if vc.viewController != nil && vc.viewController is MineViewController {
            return vc.viewController
        }
        if vc.superview != nil {
            findVc(vc: vc.superview!)
            print(vc)
        }
        return nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
